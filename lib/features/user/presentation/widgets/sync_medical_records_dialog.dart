import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';

class SyncMedicalRecordsDialog extends StatefulWidget {
  const SyncMedicalRecordsDialog({super.key});

  @override
  State<SyncMedicalRecordsDialog> createState() =>
      _SyncMedicalRecordsDialogState();
}

class _SyncMedicalRecordsDialogState extends State<SyncMedicalRecordsDialog> {
  final TextEditingController _jwtTokenController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _jwtTokenController.dispose();
    super.dispose();
  }

  void _syncRecords() {
    if (_jwtTokenController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
    } else {
      setState(() {
        _showError = false;
      });
      // TODO: Implement actual JWT token sync logic here
      print('Syncing with JWT Token: ${_jwtTokenController.text}');
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sync Medical Records',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textMuted),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'JWT Token',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _jwtTokenController,
              decoration: InputDecoration(
                hintText: 'Enter your JWT token',
                hintStyle:
                    textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColors.primaryBlue),
                ),
                errorText: _showError ? 'JWT Token cannot be empty' : null,
                suffixIcon: _showError
                    ? const Icon(Icons.error_outline, color: Colors.red)
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _syncRecords,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textSecondary, // Greyed out color
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Sync Records',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
