// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'HealthWallet.me';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get welcomeMessage => '¡Bienvenido a HealthWallet.me!';

  @override
  String get onboardingBack => 'Atrás';

  @override
  String get onboardingGetStarted => 'Empezar';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingWelcomeTitle => '¡una Cartera de Salud para Ti!';

  @override
  String get onboardingWelcomeSubtitle =>
      'Accede de forma segura a tu historial médico completo con <link>HealthWallet.me</link>. Conéctate a más de 100,000 instituciones de salud de EE.UU. o agrega registros compartiendo directamente con la app o escaneando documentos. Tus datos de salud son privados, compatibles y se almacenan solo en tu dispositivo.';

  @override
  String get onboardingWelcomeDescription =>
      'Sincroniza tus datos de salud a través de <link>FastenHealth OnPrem</link> con los proveedores de atención médica y ve tu historial médico completo en un solo lugar. Seguro, compatible y siempre en tu dispositivo. ¡Disfruta!';

  @override
  String get onboardingRecordsTitle => 'Tu Salud, Siempre Sincronizada';

  @override
  String get onboardingRecordsSubtitle =>
      '**Mantén tu historial médico actualizado sin esfuerzo con opciones automáticas y manuales.**';

  @override
  String get onboardingRecordsDescription =>
      '<link>HealthWallet.me</link> asegura que tu historial de salud completo esté siempre actualizado. Sincroniza automáticamente nuevos registros de proveedores conectados y te permite agregar instantáneamente documentos físicos con un escaneo rápido.';

  @override
  String get onboardingScanButton => 'Escanear';

  @override
  String get onboardingSyncTitle => 'Privado por Diseño';

  @override
  String get onboardingSyncSubtitle =>
      'Tus datos de salud te pertenecen solo a ti.';

  @override
  String get onboardingSyncDescription =>
      'Creemos que tu información de salud sensible nunca debería estar en el servidor de una empresa. Tus datos están encriptados y almacenados exclusivamente en tu dispositivo, lo que significa que eres el único con acceso.';

  @override
  String get onboardingBiometricText =>
      'Para una capa adicional de protección, puedes bloquear tu HealthWallet con seguridad biométrica como Face ID o un escaneo de huella dactilar.';

  @override
  String get homeHi => 'Hola, ';

  @override
  String get homeLastSynced => 'Última sincronización: ';

  @override
  String get homeNever => 'Nunca';

  @override
  String get homeVitalSigns => 'Signos vitales';

  @override
  String get homeOverview => 'Visión general';

  @override
  String get homeSource => 'Fuente:';

  @override
  String get homeAll => 'Todos';

  @override
  String get homeRecentRecords => 'Registros recientes';

  @override
  String get homeViewAll => 'Ver todo';

  @override
  String get homeNA => 'N/A';

  @override
  String get dashboardTitle => 'Tablero';

  @override
  String get recordsTitle => 'Registros';

  @override
  String get syncTitle => 'Sincronizar';

  @override
  String get syncSuccessful => '¡Sincronización exitosa!';

  @override
  String get syncDataLoadedSuccessfully =>
      'Sus registros médicos han sido sincronizados. Será redirigido a la página de inicio.';

  @override
  String get cancelSyncTitle => '¿Cancelar sincronización?';

  @override
  String get cancelSyncMessage =>
      '¿Está seguro de que desea cancelar la sincronización? Esto detendrá el proceso de sincronización actual.';

  @override
  String get yesCancel => 'Sí, cancelar';

  @override
  String get continueSync => 'Continuar sincronización';

  @override
  String get syncAgain => 'Sincronizar de nuevo';

  @override
  String get syncFailed => 'Sincronización fallida: ';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get syncedAt => 'Sincronizado en: ';

  @override
  String get pasteSyncData => 'Pegar datos de sincronización';

  @override
  String get submit => 'Enviar';

  @override
  String get hideManualEntry => 'Ocultar entrada manual';

  @override
  String get enterDataManually => 'Ingresar datos manualmente';

  @override
  String get medicalRecords => 'Registros médicos';

  @override
  String get searchRecordsHint => 'Buscar registros, médicos, ubicaciones...';

  @override
  String get detailsFor => 'Detalles de ';

  @override
  String get patientId => 'ID de paciente: ';

  @override
  String get age => 'Edad';

  @override
  String get sex => 'Sexo';

  @override
  String get bloodType => 'Tipo de sangre';

  @override
  String get lastSyncedProfile => 'Última sincronización: hace 2 horas';

  @override
  String get syncLatestRecords =>
      'Sincronice sus últimos registros médicos de su proveedor de atención médica.';

  @override
  String get scanToSync => 'Escanear para sincronizar';

  @override
  String get theme => 'Tema';

  @override
  String get pleaseAuthenticate => 'Por favor, autentíquese para continuar';

  @override
  String get authenticate => 'Autenticar';

  @override
  String get bypass => 'Omitir';

  @override
  String get onboardingAuthTitle => 'Habilitar Autenticación Biométrica';

  @override
  String get onboardingAuthDescription =>
      'Agrega una capa extra de seguridad a tu cuenta habilitando la autenticación biométrica.';

  @override
  String get onboardingAuthEnable => 'Habilitar Ahora';

  @override
  String get onboardingAuthSkip => 'Omitir por Ahora';

  @override
  String get biometricAuthentication => 'Autenticación Biométrica';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get setupDeviceSecurity => 'Configurar Seguridad del Dispositivo';

  @override
  String get deviceSecurityMessage =>
      'Tu dispositivo no tiene configuración de seguridad. Por tu seguridad, por favor configura la seguridad del dispositivo antes de usar esta aplicación:';

  @override
  String get deviceSettingsStep1 => 'Ve a la Configuración de tu dispositivo';

  @override
  String get deviceSettingsStep2 => 'Navega a Seguridad o Pantalla de bloqueo';

  @override
  String get deviceSettingsStep3 =>
      'Configura un bloqueo de pantalla (PIN, patrón o contraseña)';

  @override
  String get deviceSettingsStep4 =>
      'Opcionalmente agrega huella dactilar o desbloqueo facial para mayor comodidad';

  @override
  String get deviceSecurityReturnMessage =>
      'Después de configurar la seguridad del dispositivo, regresa a esta aplicación e inténtalo de nuevo.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get openSettings => 'Abrir Configuración';

  @override
  String get settingsNotAvailable => 'Configuración No Disponible';

  @override
  String get settingsNotAvailableMessage =>
      'No se pudo abrir la configuración del dispositivo automáticamente. Por favor hazlo manualmente:\n\n1. Abrir Configuración\n2. Ir a Seguridad → Biometría\n3. Agregar huella dactilar o desbloqueo facial\n4. Regresar a esta aplicación e intentar de nuevo';

  @override
  String get ok => 'OK';

  @override
  String get scanCode => 'Escanear código';

  @override
  String get or => 'o';

  @override
  String get manualSyncMessage =>
      'Si no puedes escanear el código QR, puedes pegar manualmente los datos de sincronización:';

  @override
  String get pasteSyncDataHint => 'Pegar datos de sincronización aquí';

  @override
  String get connect => 'Conectar';

  @override
  String get scanNewQRCode => 'Escanear Nuevo Código QR';

  @override
  String get loadDemoData => 'Cargar Datos de Demostración';

  @override
  String get syncData => 'Sincronizar Datos';

  @override
  String get noMedicalRecordsYet => 'Aún no hay registros médicos';

  @override
  String noRecordTypeYet(Object recordType) {
    return 'Aún no hay $recordType';
  }

  @override
  String get loadDemoDataMessage =>
      'Carga datos de demostración para explorar la aplicación o sincroniza tus registros médicos reales';

  @override
  String syncDataMessage(Object recordType) {
    return 'Sincroniza o actualiza tus datos para ver registros de $recordType';
  }

  @override
  String get retry => 'Reintentar';

  @override
  String get pleaseEnterSourceName => 'Por favor ingresa un nombre de fuente';

  @override
  String get selectBirthDate => 'Seleccionar fecha de nacimiento';

  @override
  String get years => 'años';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Femenino';

  @override
  String get preferNotToSay => 'Prefiero no decir';

  @override
  String get errorUpdatingSourceLabel =>
      'Error al actualizar etiqueta de fuente';

  @override
  String get noChangesDetected => 'No se detectaron cambios';

  @override
  String get pleaseSelectBirthDate =>
      'Por favor selecciona una fecha de nacimiento';

  @override
  String get errorSavingPatientData => 'Error al guardar datos del paciente';

  @override
  String get failedToUpdateDisplayName =>
      'Error al actualizar nombre para mostrar';

  @override
  String get actionCannotBeUndone => 'Esta acción no se puede deshacer.';

  @override
  String confirmDeleteFile(Object filename) {
    return '¿Estás seguro de que quieres eliminar \"$filename\"?';
  }

  @override
  String selectAtLeastOne(Object type) {
    return 'Selecciona al menos un $type para continuar.';
  }

  @override
  String get editSourceLabel => 'Editar etiqueta de fuente';

  @override
  String get saveDetails => 'Guardar detalles';

  @override
  String get editDetails => 'Editar detalles';

  @override
  String get done => 'Hecho';

  @override
  String get attachments => 'Archivos adjuntos';

  @override
  String get noFilesAttached => 'Este registro no tiene archivos adjuntos';

  @override
  String get attachFile => 'Adjuntar archivo';

  @override
  String get overview => 'Resumen';

  @override
  String get recentRecords => 'Registros recientes';

  @override
  String chooseToDisplay(Object type) {
    return 'Elige los $type que quieres ver en tu panel de control.';
  }

  @override
  String get displayName => 'Nombre para mostrar';

  @override
  String get bloodTypeAPositive => 'A positivo';

  @override
  String get bloodTypeANegative => 'A negativo';

  @override
  String get bloodTypeBPositive => 'B positivo';

  @override
  String get bloodTypeBNegative => 'B negativo';

  @override
  String get bloodTypeABPositive => 'AB positivo';

  @override
  String get bloodTypeABNegative => 'AB negativo';

  @override
  String get bloodTypeOPositive => 'O positivo';

  @override
  String get bloodTypeONegative => 'O negativo';

  @override
  String get serverError => 'Algo salió mal en el servidor';

  @override
  String get serverTimeout => 'Tiempo de espera del servidor agotado';

  @override
  String get connectionError => 'Error de conexión';

  @override
  String get unknownSource => 'Fuente Desconocida';

  @override
  String get synchronization => 'Sincronización';

  @override
  String get syncMedicalRecords => 'Sincronizar registros médicos';

  @override
  String get syncLatestMedicalRecords =>
      'Sincroniza tus últimos registros médicos de tu proveedor de atención médica usando un token JWT seguro.';

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get lastSynced => 'Última sincronización';

  @override
  String get tapToSelectPatient => 'Toca para seleccionar paciente';

  @override
  String get preferences => 'Preferencias';

  @override
  String get version => 'Versión';

  @override
  String get on => 'ENCENDIDO';

  @override
  String get off => 'APAGADO';

  @override
  String get confirmDisableBiometric =>
      '¿Estás seguro de que quieres desactivar la Autenticación Biométrica (FaceID / Código de acceso)?';

  @override
  String get disable => 'Desactivar';

  @override
  String get continueButton => 'Continuar';

  @override
  String get getStarted => 'Empezar';

  @override
  String get enableBiometricAuth =>
      'Habilitar Autenticación Biométrica (FaceID / Código de acceso)';

  @override
  String get disableBiometricAuth =>
      'Desactivar Autenticación Biométrica (FaceID / Código de acceso)';

  @override
  String get patient => 'Paciente';

  @override
  String get noPatientsFound => 'No se encontraron pacientes';

  @override
  String get id => 'ID';

  @override
  String get gender => 'Género';

  @override
  String get loading => 'Cargando...';

  @override
  String get source => 'Fuente';

  @override
  String get showAll => 'Mostrar Todo';

  @override
  String get records => 'Registros';

  @override
  String get vitals => 'Signos Vitales';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get clearAll => 'Limpiar todo';

  @override
  String get save => 'Guardar';

  @override
  String get noRecordsFound => 'No se encontraron registros';

  @override
  String get tryDifferentKeywords =>
      'Intenta buscar con palabras clave diferentes';

  @override
  String get clearAllFilters => 'Limpiar todo';

  @override
  String get syncingData => 'Sincronizando datos';

  @override
  String get syncingMessage => 'Puede tomar un tiempo. Por favor espera.';

  @override
  String get scanQRMessage =>
      'Escanea el código QR de tu servidor Fasten Health para crear una nueva conexión de sincronización.';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get vitalSigns => 'Signos Vitales';

  @override
  String get longPressToReorder =>
      'Mantén presionado para mover y reordenar tarjetas, o filtra para seleccionar cuáles aparecen en tu panel de control.';

  @override
  String get effectiveDate => 'Fecha de vigencia';

  @override
  String get privacyIntro => 'Tu privacidad es nuestra máxima prioridad.';

  @override
  String get privacyDescription =>
      'es una herramienta simple y segura diseñada para ayudarte a organizar tus registros de salud con facilidad, directamente en tu dispositivo. Esta política explica nuestro compromiso con tu privacidad: no recopilamos tus datos y no te rastreamos. Tienes el control completo.';

  @override
  String get corePrinciple =>
      'Nuestro Principio Fundamental: Tus Datos Permanecen en Tu Dispositivo';

  @override
  String get whatInformationHandled => '¿Qué Información se Maneja?';

  @override
  String get informationWeDoNotCollect =>
      'Información que No Recopilamos o Accedemos';

  @override
  String get informationYouManage => 'Información que Tú Administras';

  @override
  String get importingDocuments => 'Importar Documentos desde Tu Dispositivo';

  @override
  String get connectingFastenHealth => 'Conectando a FastenHealth OnPrem';

  @override
  String get howInformationUsed => 'Cómo se Usa Tu Información';

  @override
  String get dataStorageSecurity =>
      'Almacenamiento de Datos, Seguridad y Compartir';

  @override
  String get childrensPrivacy => 'Privacidad de los Niños';

  @override
  String get changesToPolicy => 'Cambios a Esta Política de Privacidad';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get builtWithLove => '¡Construido con amor por Life Value!';

  @override
  String get sourceName => 'Nombre de fuente';

  @override
  String get provideCustomLabel =>
      'Proporciona una etiqueta personalizada para:';

  @override
  String get success => 'Éxito';

  @override
  String get demoDataLoadedSuccessfully =>
      'Los datos de demostración se han cargado exitosamente. Serás redirigido a la página de inicio.';

  @override
  String get documentScanTitle => 'Scan Document';
}
