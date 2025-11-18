import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_notification.freezed.dart';

@freezed
class WalletNotification with _$WalletNotification {
  const WalletNotification._();

  const factory WalletNotification({
    @Default('') String text,
    @Default(PageRouteInfo('')) PageRouteInfo route,
    @Default(false) bool read,
    DateTime? time,
  }) = _WalletNotification;
}
