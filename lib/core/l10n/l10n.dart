import 'package:flutter/material.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';

export 'package:health_wallet/core/l10n/arb/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
