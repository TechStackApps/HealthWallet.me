import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('de'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'HealthWallet.me'**
  String get appTitle;

  /// The title of the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// The title of the profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// The title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// The welcome message shown to users
  ///
  /// In en, this message translates to:
  /// **'Welcome to HealthWallet.me!'**
  String get welcomeMessage;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'a Health Wallet for You!'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely access your complete medical history with <link>HealthWallet.me</link>. Connect to over 100,000 US healthcare institutions or add records by sharing directly with the app or scan documents. Your health data is private, compliant, and stored only on your device.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Sync your healthcare data through <link>FastenHealth OnPrem</link> with the healthcare providers and see your complete medical history in one place. Secured, compliant and always on your device. Enjoy!'**
  String get onboardingWelcomeDescription;

  /// No description provided for @onboardingRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Always in Sync'**
  String get onboardingRecordsTitle;

  /// No description provided for @onboardingRecordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'**Keep your medical history effortlessly up-to-date with both automatic and manual options.**'**
  String get onboardingRecordsSubtitle;

  /// No description provided for @onboardingRecordsDescription.
  ///
  /// In en, this message translates to:
  /// **'<link>HealthWallet.me</link> ensures your complete health history is always up-to-date. It automatically syncs new records from connected providers and lets you instantly add physical documents with a quick scan.'**
  String get onboardingRecordsDescription;

  /// No description provided for @onboardingScanButton.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get onboardingScanButton;

  /// No description provided for @onboardingSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Private by Design'**
  String get onboardingSyncTitle;

  /// No description provided for @onboardingSyncSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your health data belongs only to you.'**
  String get onboardingSyncSubtitle;

  /// No description provided for @onboardingSyncDescription.
  ///
  /// In en, this message translates to:
  /// **'We believe your sensitive health information should never sit on a company server. Your data is encrypted and stored exclusively on your device, meaning you are the only one with access.'**
  String get onboardingSyncDescription;

  /// No description provided for @onboardingBiometricText.
  ///
  /// In en, this message translates to:
  /// **'You can lock your HealthWallet with biometric security like Face ID or a fingerprint scan.'**
  String get onboardingBiometricText;

  /// No description provided for @homeHi.
  ///
  /// In en, this message translates to:
  /// **'Hi, '**
  String get homeHi;

  /// No description provided for @homeLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced: '**
  String get homeLastSynced;

  /// No description provided for @homeNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get homeNever;

  /// No description provided for @homeVitalSigns.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get homeVitalSigns;

  /// No description provided for @homeOverview.
  ///
  /// In en, this message translates to:
  /// **'Medical Records'**
  String get homeOverview;

  /// No description provided for @homeSource.
  ///
  /// In en, this message translates to:
  /// **'Source:'**
  String get homeSource;

  /// No description provided for @homeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeAll;

  /// No description provided for @homeRecentRecords.
  ///
  /// In en, this message translates to:
  /// **'Recent Records'**
  String get homeRecentRecords;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeNA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get homeNA;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @recordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get recordsTitle;

  /// No description provided for @syncTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get syncTitle;

  /// No description provided for @syncSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Sync successful!'**
  String get syncSuccessful;

  /// No description provided for @syncDataLoadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your medical records have been synchronized. You will be redirected to the home page.'**
  String get syncDataLoadedSuccessfully;

  /// No description provided for @cancelSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Sync?'**
  String get cancelSyncTitle;

  /// No description provided for @cancelSyncMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the synchronization? This will stop the current sync process.'**
  String get cancelSyncMessage;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @continueSync.
  ///
  /// In en, this message translates to:
  /// **'Continue Sync'**
  String get continueSync;

  /// No description provided for @syncAgain.
  ///
  /// In en, this message translates to:
  /// **'Sync Again'**
  String get syncAgain;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed: '**
  String get syncFailed;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @syncedAt.
  ///
  /// In en, this message translates to:
  /// **'Synced at: '**
  String get syncedAt;

  /// No description provided for @pasteSyncData.
  ///
  /// In en, this message translates to:
  /// **'Paste Sync Data'**
  String get pasteSyncData;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @hideManualEntry.
  ///
  /// In en, this message translates to:
  /// **'Hide Manual Entry'**
  String get hideManualEntry;

  /// No description provided for @enterDataManually.
  ///
  /// In en, this message translates to:
  /// **'Enter data manually'**
  String get enterDataManually;

  /// No description provided for @medicalRecords.
  ///
  /// In en, this message translates to:
  /// **'Medical Records'**
  String get medicalRecords;

  /// No description provided for @searchRecordsHint.
  ///
  /// In en, this message translates to:
  /// **'Search records, doctors, locations...'**
  String get searchRecordsHint;

  /// No description provided for @detailsFor.
  ///
  /// In en, this message translates to:
  /// **'Details for '**
  String get detailsFor;

  /// No description provided for @patientId.
  ///
  /// In en, this message translates to:
  /// **'Patient ID: '**
  String get patientId;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @lastSyncedProfile.
  ///
  /// In en, this message translates to:
  /// **'Last synced: 2 hours ago'**
  String get lastSyncedProfile;

  /// No description provided for @syncLatestRecords.
  ///
  /// In en, this message translates to:
  /// **'Sync your latest medical records from your healthcare provider.'**
  String get syncLatestRecords;

  /// No description provided for @scanToSync.
  ///
  /// In en, this message translates to:
  /// **'Scan to Sync'**
  String get scanToSync;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @pleaseAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to continue'**
  String get pleaseAuthenticate;

  /// No description provided for @authenticate.
  ///
  /// In en, this message translates to:
  /// **'Authenticate'**
  String get authenticate;

  /// No description provided for @bypass.
  ///
  /// In en, this message translates to:
  /// **'Bypass'**
  String get bypass;

  /// No description provided for @onboardingAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric Authentication'**
  String get onboardingAuthTitle;

  /// No description provided for @onboardingAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Add an extra layer of security to your account by enabling biometric authentication.'**
  String get onboardingAuthDescription;

  /// No description provided for @onboardingAuthEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable Now'**
  String get onboardingAuthEnable;

  /// No description provided for @onboardingAuthSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get onboardingAuthSkip;

  /// No description provided for @biometricAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuthentication;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @setupDeviceSecurity.
  ///
  /// In en, this message translates to:
  /// **'Set Up Device Security'**
  String get setupDeviceSecurity;

  /// No description provided for @deviceSecurityMessage.
  ///
  /// In en, this message translates to:
  /// **'Your device has no security setup. For your safety, please set up device security before using this app:'**
  String get deviceSecurityMessage;

  /// No description provided for @deviceSettingsStep1.
  ///
  /// In en, this message translates to:
  /// **'Go to your device Settings'**
  String get deviceSettingsStep1;

  /// No description provided for @deviceSettingsStep2.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Security or Lock screen'**
  String get deviceSettingsStep2;

  /// No description provided for @deviceSettingsStep3.
  ///
  /// In en, this message translates to:
  /// **'Set up a screen lock (PIN, pattern, or password)'**
  String get deviceSettingsStep3;

  /// No description provided for @deviceSettingsStep4.
  ///
  /// In en, this message translates to:
  /// **'Optionally add fingerprint or face unlock for convenience'**
  String get deviceSettingsStep4;

  /// No description provided for @deviceSecurityReturnMessage.
  ///
  /// In en, this message translates to:
  /// **'After setting up device security, return to this app and try again.'**
  String get deviceSecurityReturnMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @settingsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Settings Not Available'**
  String get settingsNotAvailable;

  /// No description provided for @settingsNotAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not open device settings automatically. Please manually:\n\n1. Open Settings\n2. Go to Security → Biometrics\n3. Add fingerprint or face unlock\n4. Return to this app and try again'**
  String get settingsNotAvailableMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @scanCode.
  ///
  /// In en, this message translates to:
  /// **'Scan code'**
  String get scanCode;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @manualSyncMessage.
  ///
  /// In en, this message translates to:
  /// **'Raw QR Code'**
  String get manualSyncMessage;

  /// No description provided for @pasteSyncDataHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the raw QR code'**
  String get pasteSyncDataHint;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @scanNewQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan New QR Code'**
  String get scanNewQRCode;

  /// No description provided for @loadDemoData.
  ///
  /// In en, this message translates to:
  /// **'Load Demo Data'**
  String get loadDemoData;

  /// No description provided for @syncData.
  ///
  /// In en, this message translates to:
  /// **'Sync Data'**
  String get syncData;

  /// No description provided for @noMedicalRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No medical records yet'**
  String get noMedicalRecordsYet;

  /// No description provided for @noRecordTypeYet.
  ///
  /// In en, this message translates to:
  /// **'No {recordType} yet'**
  String noRecordTypeYet(Object recordType);

  /// No description provided for @loadDemoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Load demo data to explore the app or sync your real medical records'**
  String get loadDemoDataMessage;

  /// No description provided for @syncDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Sync or update your data to view {recordType} records'**
  String syncDataMessage(Object recordType);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @pleaseEnterSourceName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a source name'**
  String get pleaseEnterSourceName;

  /// No description provided for @selectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Select birth date'**
  String get selectBirthDate;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @errorUpdatingSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Error updating source label'**
  String get errorUpdatingSourceLabel;

  /// No description provided for @noChangesDetected.
  ///
  /// In en, this message translates to:
  /// **'No changes detected'**
  String get noChangesDetected;

  /// No description provided for @pleaseSelectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Please select a birth date'**
  String get pleaseSelectBirthDate;

  /// No description provided for @errorSavingPatientData.
  ///
  /// In en, this message translates to:
  /// **'Error saving patient data'**
  String get errorSavingPatientData;

  /// No description provided for @walletHolder.
  ///
  /// In en, this message translates to:
  /// **'Wallet Holder'**
  String get walletHolder;

  /// No description provided for @walletHolderDescription.
  ///
  /// In en, this message translates to:
  /// **'This patient is the primary owner of this health wallet'**
  String get walletHolderDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @failedToUpdateDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Failed to update display name'**
  String get failedToUpdateDisplayName;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get actionCannotBeUndone;

  /// No description provided for @confirmDeleteFile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{filename}\"?'**
  String confirmDeleteFile(Object filename);

  /// No description provided for @selectAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Select at least one {type} to continue.'**
  String selectAtLeastOne(Object type);

  /// No description provided for @editSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit source label'**
  String get editSourceLabel;

  /// No description provided for @saveDetails.
  ///
  /// In en, this message translates to:
  /// **'Save details'**
  String get saveDetails;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit details'**
  String get editDetails;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @noFilesAttached.
  ///
  /// In en, this message translates to:
  /// **'This record has no files attached'**
  String get noFilesAttached;

  /// No description provided for @attachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get attachFile;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @recentRecords.
  ///
  /// In en, this message translates to:
  /// **'Recent records'**
  String get recentRecords;

  /// No description provided for @chooseToDisplay.
  ///
  /// In en, this message translates to:
  /// **'Choose the {type} you want to see on your dashboard.'**
  String chooseToDisplay(Object type);

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayName;

  /// No description provided for @bloodTypeAPositive.
  ///
  /// In en, this message translates to:
  /// **'A positive'**
  String get bloodTypeAPositive;

  /// No description provided for @bloodTypeANegative.
  ///
  /// In en, this message translates to:
  /// **'A negative'**
  String get bloodTypeANegative;

  /// No description provided for @bloodTypeBPositive.
  ///
  /// In en, this message translates to:
  /// **'B positive'**
  String get bloodTypeBPositive;

  /// No description provided for @bloodTypeBNegative.
  ///
  /// In en, this message translates to:
  /// **'B negative'**
  String get bloodTypeBNegative;

  /// No description provided for @bloodTypeABPositive.
  ///
  /// In en, this message translates to:
  /// **'AB positive'**
  String get bloodTypeABPositive;

  /// No description provided for @bloodTypeABNegative.
  ///
  /// In en, this message translates to:
  /// **'AB negative'**
  String get bloodTypeABNegative;

  /// No description provided for @bloodTypeOPositive.
  ///
  /// In en, this message translates to:
  /// **'O positive'**
  String get bloodTypeOPositive;

  /// No description provided for @bloodTypeONegative.
  ///
  /// In en, this message translates to:
  /// **'O negative'**
  String get bloodTypeONegative;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on the server'**
  String get serverError;

  /// No description provided for @serverTimeout.
  ///
  /// In en, this message translates to:
  /// **'Server timeout'**
  String get serverTimeout;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get connectionError;

  /// No description provided for @unknownSource.
  ///
  /// In en, this message translates to:
  /// **'Unknown Source'**
  String get unknownSource;

  /// No description provided for @synchronization.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get synchronization;

  /// No description provided for @syncMedicalRecords.
  ///
  /// In en, this message translates to:
  /// **'Sync Medical records'**
  String get syncMedicalRecords;

  /// No description provided for @syncLatestMedicalRecords.
  ///
  /// In en, this message translates to:
  /// **'Sync your latest medical records from your healthcare provider using a secure JWT token.'**
  String get syncLatestMedicalRecords;

  /// No description provided for @neverSynced.
  ///
  /// In en, this message translates to:
  /// **'Never synced'**
  String get neverSynced;

  /// No description provided for @lastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced'**
  String get lastSynced;

  /// No description provided for @tapToSelectPatient.
  ///
  /// In en, this message translates to:
  /// **'Tap to select patient'**
  String get tapToSelectPatient;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @confirmDisableBiometric.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you would like to disable the Biometric Auth (FaceID / Passcode)?'**
  String get confirmDisableBiometric;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @enableBiometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric Auth (FaceID / Passcode)'**
  String get enableBiometricAuth;

  /// No description provided for @disableBiometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Disable Biometric Auth (FaceID / Passcode)'**
  String get disableBiometricAuth;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @noPatientsFound.
  ///
  /// In en, this message translates to:
  /// **'No patients found'**
  String get noPatientsFound;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @vitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get vitals;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No records found'**
  String get noRecordsFound;

  /// No description provided for @tryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords'**
  String get tryDifferentKeywords;

  /// No description provided for @clearAllFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAllFilters;

  /// No description provided for @syncingData.
  ///
  /// In en, this message translates to:
  /// **'Syncing data'**
  String get syncingData;

  /// No description provided for @syncingMessage.
  ///
  /// In en, this message translates to:
  /// **'It might take a while. Please wait.'**
  String get syncingMessage;

  /// No description provided for @scanQRMessage.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code from your Fasten Health server to create a new sync connection.'**
  String get scanQRMessage;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @vitalSigns.
  ///
  /// In en, this message translates to:
  /// **'Vital Signs'**
  String get vitalSigns;

  /// No description provided for @longPressToReorder.
  ///
  /// In en, this message translates to:
  /// **'Long press to move & reorder cards, or filter to select which ones appear on your dashboard.'**
  String get longPressToReorder;

  /// No description provided for @effectiveDate.
  ///
  /// In en, this message translates to:
  /// **'Effective Date'**
  String get effectiveDate;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is our highest priority.'**
  String get privacyIntro;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'is a simple, secure tool designed to help you organize your health records at ease, directly on your device. This policy explains our commitment to your privacy: we do not collect your data, and we do not track you. You are in complete control.'**
  String get privacyDescription;

  /// No description provided for @corePrinciple.
  ///
  /// In en, this message translates to:
  /// **'Our Core Principle: Your Data Stays on Your Device'**
  String get corePrinciple;

  /// No description provided for @whatInformationHandled.
  ///
  /// In en, this message translates to:
  /// **'What Information is Handled?'**
  String get whatInformationHandled;

  /// No description provided for @informationWeDoNotCollect.
  ///
  /// In en, this message translates to:
  /// **'Information We Do Not Collect or Access'**
  String get informationWeDoNotCollect;

  /// No description provided for @informationYouManage.
  ///
  /// In en, this message translates to:
  /// **'Information You Manage'**
  String get informationYouManage;

  /// No description provided for @importingDocuments.
  ///
  /// In en, this message translates to:
  /// **'Importing Documents from Your Device'**
  String get importingDocuments;

  /// No description provided for @connectingFastenHealth.
  ///
  /// In en, this message translates to:
  /// **'Connecting to FastenHealth OnPrem'**
  String get connectingFastenHealth;

  /// No description provided for @howInformationUsed.
  ///
  /// In en, this message translates to:
  /// **'How Your Information is Used'**
  String get howInformationUsed;

  /// No description provided for @dataStorageSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data Storage, Security, and Sharing'**
  String get dataStorageSecurity;

  /// No description provided for @childrensPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Privacy'**
  String get childrensPrivacy;

  /// No description provided for @changesToPolicy.
  ///
  /// In en, this message translates to:
  /// **'Changes to This Privacy Policy'**
  String get changesToPolicy;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @builtWithLove.
  ///
  /// In en, this message translates to:
  /// **'Built with love by Life Value!'**
  String get builtWithLove;

  /// No description provided for @sourceName.
  ///
  /// In en, this message translates to:
  /// **'Source name'**
  String get sourceName;

  /// No description provided for @provideCustomLabel.
  ///
  /// In en, this message translates to:
  /// **'Provide a custom label for:'**
  String get provideCustomLabel;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @demoDataLoadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Demo data has been loaded successfully. You will be redirected to the home page.'**
  String get demoDataLoadedSuccessfully;

  /// No description provided for @documentScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get documentScanTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
