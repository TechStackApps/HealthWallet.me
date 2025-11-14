import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/home/domain/entities/wallet_notification.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationAdded>(_onNotificationAdded);
    on<NotificationPopupClosed>(_onNotificationPopupClosed);
    on<NotificationCleared>(_onNotificationCleared);
  }

  void _onNotificationAdded(
    NotificationAdded event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(
      notifications: [event.notification, ...state.notifications],
    ));
    log(state.notifications.toString());
  }

  void _onNotificationPopupClosed(
    NotificationPopupClosed event,
    Emitter<NotificationState> emit,
  ) {
    final notificationsRead = [...state.notifications]
        .map((notification) => notification.copyWith(read: true))
        .toList();

    emit(state.copyWith(notifications: notificationsRead));
  }

  void _onNotificationCleared(
    NotificationCleared event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(notifications: []));
  }
}
