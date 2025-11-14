import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/notifications/bloc/notification_bloc.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  void _showOverlay(NotificationState state) {
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _hideOverlay,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              child: CompositedTransformFollower(
                link: _layerLink,
                followerAnchor: Alignment.topRight,
                targetAnchor: Alignment.bottomCenter,
                offset: const Offset(48, 12.0),
                child: Material(
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      width: MediaQuery.sizeOf(context).width / 1.3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Notifications",
                                style: AppTextStyle.titleSmall,
                              ),
                              TextButton(
                                onPressed: () {
                                  _hideOverlay();
                                  context
                                      .read<NotificationBloc>()
                                      .add(const NotificationCleared());
                                },
                                style: TextButton.styleFrom(
                                    visualDensity: const VisualDensity(
                                        horizontal: -4.0, vertical: -4.0)),
                                child: const Text(
                                  "Clear",
                                  style: AppTextStyle.buttonMedium,
                                ),
                              )
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: state.notifications
                                .map((notification) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: GestureDetector(
                                        onTap: () {
                                          _hideOverlay();
                                          context.router.push(notification.route);
                                        },
                                        child: Expanded(
                                          child: Text(
                                            "${DateFormat("HH:mm").format(notification.time!)} — ${notification.text}",
                                            style:
                                                AppTextStyle.bodySmall.copyWith(
                                              color: notification.read
                                                  ? null
                                                  : AppColors.primary,
                                              fontWeight: notification.read
                                                  ? null
                                                  : FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    context.read<NotificationBloc>().add(const NotificationPopupClosed());
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleOverlay(NotificationState state) {
    if (_overlayEntry == null) {
      _showOverlay(state);
    } else {
      _hideOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final hasUnread =
            state.notifications.any((notification) => !notification.read);

        return CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                if (hasUnread)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.all(4),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: (state.notifications.isNotEmpty)
                      ? () => _toggleOverlay(state)
                      : null,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
