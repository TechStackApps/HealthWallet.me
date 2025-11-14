import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/domain/entity/processing_session.dart';
import 'package:health_wallet/features/scan/presentation/widgets/custom_progress_indicator.dart';
import 'package:intl/intl.dart';

class SessionList extends StatelessWidget {
  const SessionList({
    required this.sessions,
    super.key,
  });

  final List<ProcessingSession> sessions;

  @override
  Widget build(BuildContext context) {
    sessions.sort();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final isInProgress = session.status == ProcessingStatus.processing;

          return InkWell(
            onTap: () => context.router.push(FhirMapperRoute(session: session)),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: (index < sessions.length - 1) ? 16 : 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isInProgress
                        ? context.theme.primaryColor
                        : context.theme.dividerColor,
                    width: isInProgress ? 2.0 : 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('MMMM d, HH:mm:ss')
                              .format(session.createdAt!)),
                          Text(session.status.toString())
                        ],
                      ),
                      if (isInProgress)
                        CustomProgressIndicator(progress: session.progress),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
