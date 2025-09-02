// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HealthWallet.me';

  @override
  String get homeTitle => 'Home';

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get welcomeMessage => 'Welcome to HealthWallet.me!';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingWelcomeTitle => 'a Health Wallet for You!';

  @override
  String get onboardingWelcomeSubtitle =>
      'Securely access your complete medical history with <link>HealthWallet.me</link>. Connect to over 100,000 US healthcare institutions or add records by sharing directly with the app or scan documents. Your health data is private, compliant, and stored only on your device.';

  @override
  String get onboardingWelcomeDescription =>
      'Sync your healthcare data through <link>FastenHealth OnPrem</link> with the healthcare providers and see your complete medical history in one place. Secured, compliant and always on your device. Enjoy!';

  @override
  String get onboardingRecordsTitle => 'Your Health, Always in Sync';

  @override
  String get onboardingRecordsSubtitle =>
      '**Keep your medical history effortlessly up-to-date with both automatic and manual options.**';

  @override
  String get onboardingRecordsDescription =>
      '<link>HealthWallet.me</link> ensures your complete health history is always up-to-date. It automatically syncs new records from connected providers and lets you instantly add physical documents with a quick scan.';

  @override
  String get onboardingScanButton => 'Scan';

  @override
  String get onboardingSyncTitle => 'Private by Design';

  @override
  String get onboardingSyncSubtitle => 'Your health data belongs only to you.';

  @override
  String get onboardingSyncDescription =>
      'We believe your sensitive health information should never sit on a company server. Your data is encrypted and stored exclusively on your device, meaning you are the only one with access.';

  @override
  String get onboardingBiometricText =>
      'You can lock your HealthWallet with biometric security like Face ID or a fingerprint scan.';

  @override
  String get homeHi => 'Hi, ';

  @override
  String get homeLastSynced => 'Last synced: ';

  @override
  String get homeNever => 'Never';

  @override
  String get homeVitalSigns => 'Vitals';

  @override
  String get homeOverview => 'Medical Records';

  @override
  String get homeSource => 'Source:';

  @override
  String get homeAll => 'All';

  @override
  String get homeRecentRecords => 'Recent Records';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeNA => 'N/A';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get recordsTitle => 'Records';

  @override
  String get syncTitle => 'Sync';

  @override
  String get syncSuccessful => 'Sync successful!';

  @override
  String get syncAgain => 'Sync Again';

  @override
  String get syncFailed => 'Sync failed: ';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get syncedAt => 'Synced at: ';

  @override
  String get pasteSyncData => 'Paste Sync Data';

  @override
  String get submit => 'Submit';

  @override
  String get hideManualEntry => 'Hide Manual Entry';

  @override
  String get enterDataManually => 'Enter data manually';

  @override
  String get medicalRecords => 'Medical Records';

  @override
  String get searchRecordsHint => 'Search records, doctors, locations...';

  @override
  String get detailsFor => 'Details for ';

  @override
  String get patientId => 'Patient ID: ';

  @override
  String get age => 'Age';

  @override
  String get sex => 'Sex';

  @override
  String get bloodType => 'Blood Type';

  @override
  String get lastSyncedProfile => 'Last synced: 2 hours ago';

  @override
  String get syncLatestRecords =>
      'Sync your latest medical records from your healthcare provider.';

  @override
  String get scanToSync => 'Scan to Sync';

  @override
  String get theme => 'Theme';

  @override
  String get pleaseAuthenticate => 'Please authenticate to continue';

  @override
  String get authenticate => 'Authenticate';

  @override
  String get bypass => 'Bypass';

  @override
  String get onboardingAuthTitle => 'Enable Biometric Authentication';

  @override
  String get onboardingAuthDescription =>
      'Add an extra layer of security to your account by enabling biometric authentication.';

  @override
  String get onboardingAuthEnable => 'Enable Now';

  @override
  String get onboardingAuthSkip => 'Skip for Now';

  @override
  String get biometricAuthentication => 'Biometric Authentication';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get setupDeviceSecurity => 'Set Up Device Security';

  @override
  String get deviceSecurityMessage =>
      'Your device has no security setup. For your safety, please set up device security before using this app:';

  @override
  String get deviceSettingsStep1 => 'Go to your device Settings';

  @override
  String get deviceSettingsStep2 => 'Navigate to Security or Lock screen';

  @override
  String get deviceSettingsStep3 =>
      'Set up a screen lock (PIN, pattern, or password)';

  @override
  String get deviceSettingsStep4 =>
      'Optionally add fingerprint or face unlock for convenience';

  @override
  String get deviceSecurityReturnMessage =>
      'After setting up device security, return to this app and try again.';

  @override
  String get cancel => 'Cancel';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get settingsNotAvailable => 'Settings Not Available';

  @override
  String get settingsNotAvailableMessage =>
      'Could not open device settings automatically. Please manually:\n\n1. Open Settings\n2. Go to Security → Biometrics\n3. Add fingerprint or face unlock\n4. Return to this app and try again';

  @override
  String get ok => 'OK';

  @override
  String get scanCode => 'Scan code';

  @override
  String get or => 'or';

  @override
  String get manualSyncMessage =>
      'If you can\'t scan the QR code, you can manually paste the sync data:';

  @override
  String get pasteSyncDataHint => 'Paste sync data here';

  @override
  String get connect => 'Connect';

  @override
  String get scanNewQRCode => 'Scan New QR Code';

  @override
  String get loadDemoData => 'Load Demo Data';

  @override
  String get syncData => 'Sync Data';

  @override
  String get noMedicalRecordsYet => 'No medical records yet';

  @override
  String noRecordTypeYet(Object recordType) {
    return 'No $recordType yet';
  }

  @override
  String get loadDemoDataMessage =>
      'Load demo data to explore the app or sync your real medical records';

  @override
  String syncDataMessage(Object recordType) {
    return 'Sync or update your data to view $recordType records';
  }

  @override
  String get retry => 'Retry';

  @override
  String get pleaseEnterSourceName => 'Please enter a source name';

  @override
  String get selectBirthDate => 'Select birth date';

  @override
  String get years => 'years';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get preferNotToSay => 'Prefer not to say';

  @override
  String get errorUpdatingSourceLabel => 'Error updating source label';

  @override
  String get noChangesDetected => 'No changes detected';

  @override
  String get pleaseSelectBirthDate => 'Please select a birth date';

  @override
  String get errorSavingPatientData => 'Error saving patient data';

  @override
  String get failedToUpdateDisplayName => 'Failed to update display name';

  @override
  String get actionCannotBeUndone => 'This action cannot be undone.';

  @override
  String confirmDeleteFile(Object filename) {
    return 'Are you sure you want to delete \"$filename\"?';
  }

  @override
  String selectAtLeastOne(Object type) {
    return 'Select at least one $type to continue.';
  }

  @override
  String get editSourceLabel => 'Edit source label';

  @override
  String get saveDetails => 'Save details';

  @override
  String get editDetails => 'Edit details';

  @override
  String get done => 'Done';

  @override
  String get attachments => 'Attachments';

  @override
  String get noFilesAttached => 'This record has no files attached';

  @override
  String get attachFile => 'Attach file';

  @override
  String get overview => 'Overview';

  @override
  String get recentRecords => 'Recent records';

  @override
  String chooseToDisplay(Object type) {
    return 'Choose the $type you want to see on your dashboard.';
  }

  @override
  String get displayName => 'Display name';

  @override
  String get bloodTypeAPositive => 'A positive';

  @override
  String get bloodTypeANegative => 'A negative';

  @override
  String get bloodTypeBPositive => 'B positive';

  @override
  String get bloodTypeBNegative => 'B negative';

  @override
  String get bloodTypeABPositive => 'AB positive';

  @override
  String get bloodTypeABNegative => 'AB negative';

  @override
  String get bloodTypeOPositive => 'O positive';

  @override
  String get bloodTypeONegative => 'O negative';

  @override
  String get serverError => 'Something went wrong on the server';

  @override
  String get serverTimeout => 'Server timeout';

  @override
  String get connectionError => 'Connection error';

  @override
  String get unknownSource => 'Unknown Source';

  @override
  String get synchronization => 'Synchronization';

  @override
  String get syncMedicalRecords => 'Sync Medical records';

  @override
  String get syncLatestMedicalRecords =>
      'Sync your latest medical records from your healthcare provider using a secure JWT token.';

  @override
  String get neverSynced => 'Never synced';

  @override
  String get lastSynced => 'Last synced';

  @override
  String get tapToSelectPatient => 'Tap to select patient';

  @override
  String get preferences => 'Preferences';

  @override
  String get version => 'Version';

  @override
  String get on => 'ON';

  @override
  String get off => 'OFF';

  @override
  String get confirmDisableBiometric =>
      'Are you sure you would like to disable the Biometric Auth (FaceID / Passcode)?';

  @override
  String get disable => 'Disable';

  @override
  String get continueButton => 'Continue';

  @override
  String get getStarted => 'Get started';

  @override
  String get enableBiometricAuth => 'Enable Biometric Auth (FaceID / Passcode)';

  @override
  String get disableBiometricAuth =>
      'Disable Biometric Auth (FaceID / Passcode)';

  @override
  String get confirmDisableBiometricOnboarding =>
      'Are you sure you want to disable biometric authentication?';

  @override
  String get patient => 'Patient';

  @override
  String get noPatientsFound => 'No patients found';

  @override
  String get id => 'ID';

  @override
  String get gender => 'Gender';

  @override
  String get loading => 'Loading...';

  @override
  String get source => 'Source';

  @override
  String get showAll => 'Show All';

  @override
  String get records => 'Records';

  @override
  String get vitals => 'Vitals';

  @override
  String get selectAll => 'Select all';

  @override
  String get clearAll => 'Clear all';

  @override
  String get save => 'Save';

  @override
  String get noRecordsFound => 'No records found';

  @override
  String get tryDifferentKeywords => 'Try searching with different keywords';

  @override
  String get clearAllFilters => 'Clear all';

  @override
  String get syncingData => 'Syncing data';

  @override
  String get syncingMessage => 'It might take a while. Please wait.';

  @override
  String get scanQRMessage =>
      'Scan the QR code from your Fasten Health server to create a new sync connection.';

  @override
  String get viewAll => 'View all';

  @override
  String get vitalSigns => 'Vital Signs';

  @override
  String get longPressToReorder =>
      'Long press to move & reorder cards, or filter to select which ones appear on your dashboard.';

  @override
  String get effectiveDate => 'Effective Date';

  @override
  String get privacyIntro => 'Your privacy is our highest priority.';

  @override
  String get privacyDescription =>
      'is a simple, secure tool designed to help you organize your health records at ease, directly on your device. This policy explains our commitment to your privacy: we do not collect your data, and we do not track you. You are in complete control.';

  @override
  String get corePrinciple =>
      'Our Core Principle: Your Data Stays on Your Device';

  @override
  String get whatInformationHandled => 'What Information is Handled?';

  @override
  String get informationWeDoNotCollect =>
      'Information We Do Not Collect or Access';

  @override
  String get informationYouManage => 'Information You Manage';

  @override
  String get importingDocuments => 'Importing Documents from Your Device';

  @override
  String get connectingFastenHealth => 'Connecting to FastenHealth OnPrem';

  @override
  String get howInformationUsed => 'How Your Information is Used';

  @override
  String get dataStorageSecurity => 'Data Storage, Security, and Sharing';

  @override
  String get childrensPrivacy => 'Children\'s Privacy';

  @override
  String get changesToPolicy => 'Changes to This Privacy Policy';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get builtWithLove => 'Built with love by Life Value!';

  @override
  String get sourceName => 'Source name';

  @override
  String get provideCustomLabel => 'Provide a custom label for:';
}
