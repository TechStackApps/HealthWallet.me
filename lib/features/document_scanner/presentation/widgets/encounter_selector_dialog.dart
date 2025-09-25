// encounter_selector_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:intl/intl.dart';

class EncounterSelectorDialog extends StatefulWidget {
  const EncounterSelectorDialog({super.key});

  @override
  State<EncounterSelectorDialog> createState() => _EncounterSelectorDialogState();
}

class _EncounterSelectorDialogState extends State<EncounterSelectorDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<Encounter> _allEncounters = [];
  List<Encounter> _filteredEncounters = [];
  bool _isLoading = true;
  late final RecordsRepository _recordsRepository;

  @override
  void initState() {
    super.initState();
    _recordsRepository = GetIt.instance.get<RecordsRepository>();
    _loadEncounters();
    _searchController.addListener(_filterEncounters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadEncounters() async {
    try {
      // Load all encounters from the repository
      final resources = await _recordsRepository.getResources(
        resourceTypes: [FhirType.Encounter],
        limit: 100, // Adjust limit as needed
      );
      
      // Filter to only encounters and cast to Encounter type
      _allEncounters = resources
          .whereType<Encounter>()
          .toList();
      
      setState(() {
        _filteredEncounters = _allEncounters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error - you might want to show a snackbar or dialog
      print('Error loading encounters: $e');
    }
  }

  void _filterEncounters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredEncounters = _allEncounters;
      } else {
        _filteredEncounters = _allEncounters
            .where((encounter) =>
                encounter.title.toLowerCase().contains(query) ||
                encounter.id.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Encounter'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // Search field
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search encounters',
                hintText: 'Type to search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Encounters list
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredEncounters.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 48,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No encounters found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredEncounters.length,
                          itemBuilder: (context, index) {
                            final encounter = _filteredEncounters[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.medical_information,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  encounter.displayTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID: ${encounter.id}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (encounter.date != null)
                                      Text(
                                        DateFormat.yMMMd().format(encounter.date!),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).pop(encounter.id);
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}