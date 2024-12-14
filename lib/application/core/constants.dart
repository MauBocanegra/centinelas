const googleClientId = '908225121225-775b6uq57a57nm6c3j6pki745e36r5r3.apps.googleusercontent.com';
const fcmVapidKey = 'BPembO7RJ6ind06ohC8gdUXRoAtmBbCG3WFOYYPVC6EzWoz9QeXCJMS6NcljvvGFDh57UNSPYVnXCnNKjx7G05M';

const apiEnv = apiEnvProd;
const apiEnvDev = 'development';
const apiEnvProd = 'production';
const apiEnvReportEndpoint = apiEnv == apiEnvDev ? 'dev' : 'prod';

const collectionIdToBeDisplayedRoute = 'coleccion_visible';
const collectionIdToBeDisplayedId = 'coleccion_visible_en_app';
const raceEntryCollectionKey = 'titulares_de_carrera';
const racesCollectionKey = 'eventos';
const usersInfoCollectionKey = 'usuarios';
const userDataKey = 'datos_usuario';
const lastActiveDayKeyForUser = 'ultimo_dia_activo';
const userEmailKeyForUser = 'correo_usuario';
const userEmailsKeyForUser = 'correos_usuario';
const userRacesDataKey = 'datos_carreras';
const raceEngagementEmpty = 'vacio';
const raceEngagementRegistered = 'registrada';
const raceEngagementCheckedIn = 'checkedin';
const userDataPhoneKey = 'telefono';
const adminsDataKey = 'administradores';
const dispatchersDataKey = 'despachadores';

const raceEntryIdKey = 'id';
const raceEntryTitleKey = 'titulo';
const raceEntryImageKey = 'logo_carrera';
const raceEntryDescriptionKey = 'descripcionCorta';
const raceEntryLogoKey = 'logo_carrera';
const raceDayLogoKey = 'dia_carrera';
const raceDateLogoKey = 'fecha_carrera';
const raceHourLogoKey = 'hora_carrera';


const raceTitleKey = 'titulo';
const raceAddressKey = 'ubicacion';
const raceDescriptionKey = 'descripcion';
const raceMainImageKey = 'imagen_carrera';
const raceLogoKey = 'logo_carrera';
const raceDayKey = 'dia_carrera';
const raceDateKey = 'fecha_carrera';
const raceHourKey = 'hora_carrera';
const raceActiveKey = 'esta_activa';
const raceGoogleMapRouteKey = 'ruta_google_map';
const raceGoogleMapPointsKey = 'puntos_google_map';

const raceIdKeyForMapping = 'raceIdString';
const raceEngagementKeyForMapping = 'raceEngagementObj';
const phoneKeyForMapping = 'phoneIdString';
const incidenceTextKeyForMapping = 'incidenceTextString';
const incidenceTypeKeyForMapping = 'incidenceTypeObj';
const incidenceLatitudeKeyForMapping = 'incidenceLatitudeString';
const incidenceLongitudeKeyForMapping = 'incidenceLongitudeString';
const uidKeyForMapping = 'uidString';

const incidenceEmergencyTypeForMapping = 'incidenciaEmergencia';
const incidenceAssistanceTypeForMapping = 'incidenciaAsistencia';

const incidencesRealtimeDBPath = '$apiEnv/incidencias';
const assistanceIncidencesRealtimeDBPath = '$apiEnv/asistencias-incidencias';
const emergencyIncidencesRealtimeDBPath = '$apiEnv/emergencias-incidencias';
const usersIncidencesRealtimeDBPath = '$apiEnv/usuarios-incidencias';
const racesIncidencesRealtimeDBPath = '$apiEnv/carreras-incidencias';
const dispatchersRealtimeDBPath = '$apiEnv/despachadores';
const raceIdRealtimeDBKey = 'carrera_id';
const incidenceTextRealtimeDBKey = 'texto_incidencia';
const incidenceTimeRealtimeDBKey = 'hora_incidencia';
const incidenceTypeRealtimeDBKey = 'tipo_incidencia';
const centinelIdRealtimeDBKey = 'centinela_id';
const incidenceLatitudeRealtimeDBKey = 'latitud_incidencia';
const incidenceLongitudeRealtimeDBKey = 'longitud_incidencia';

const dispatcherEmailRealtimeDBKey = 'despachador_email';
const dispatcherFCMTokenRealtimeDBKey = 'despachador_fcm_token';

const activeRaceIdParamKey = 'activeRaceId';
const raceFullIdParamKey = 'raceFullParam';
const raceRouteParamKey = 'raceRouteParam';
const racePointsParamKey = 'racePointsParam';

const userDataNameKey = 'nombre_centinela';
const userDataEmergencyContactNameKey = 'contacto_emergencia_nombre';
const userDataEmergencyContactPhoneKey = 'contacto_emergencia_telefono';
const userDataSevereAllergiesKey = 'alergias_severas';
const userDataDrugSensitivitiesKey = 'sensibilidad_farmacos';
const userDataAccountDeletionKey = 'borrado_de_cuenta_iniciado';

const raceActivityLog = 'bitacora/';

const firebaseEventLogout = 'logout_cen';
const firebaseEventRegister = 'register_race_cen';
const firebaseEventCheckinAfterPhone = 'checkin_afterphone_race_cen';
const firebaseEventCheckin = 'checkin_race_cen';
const firebaseEventFollow = 'follow_race_cen';
const firebaseEventGoToProfile = 'goto_profile_cen';
const firebaseEventGoToRace = 'goto_race_detail';
const firebaseEventGoToTab = 'goto_tab';
const firebaseEventGoToMap = 'goto_map';
const firebaseEventGoToPrivacy = 'goto_privacy';
const firebaseEventGoToDispatch = 'goto_dispatch';
const firebaseEventSendEmergencyIncidence = 'incidence_emergency';
const firebaseEventSendAssistanceIncidence = 'incidence_assistance';

const noRouteConst = 'noroute';
const hidrationPointKey = 'punto_hidratacion';
const exitPointKey = 'punto_salida';
const finishPointKey = 'punto_meta';
const kmPointKey = 'punto_km';
const medicPointKey = 'punto_medico';

const hidrationPointKey1 = 'punto_hidratacion_1';
const hidrationPointKey2 = 'punto_hidratacion_2';
const hidrationPointKey3 = 'punto_hidratacion_3';
const hidrationPointKey4 = 'punto_hidratacion_4';
const hidrationPointKey5 = 'punto_hidratacion_5';
const hidrationPointKey6 = 'punto_hidratacion_6';
const hidrationPointKey7 = 'punto_hidratacion_7';
const hidrationPointKey8 = 'punto_hidratacion_8';
const hidrationPointKey9 = 'punto_hidratacion_9';
const hidrationPointKey10 = 'punto_hidratacion_10';

const medicPointKey1 = 'punto_medico_1';
const medicPointKey2 = 'punto_medico_2';
const medicPointKey3 = 'punto_medico_3';
const medicPointKey4 = 'punto_medico_4';
const medicPointKey5 = 'punto_medico_5';
const medicPointKey6 = 'punto_medico_6';
const medicPointKey7 = 'punto_medico_7';
const medicPointKey8 = 'punto_medico_8';
const medicPointKey9 = 'punto_medico_9';
const medicPointKey10 = 'punto_medico_10';


const redPoint = 'punto_rojo';
const rosePoint = 'punto_rosa';
const orangePoint = 'punto_naranja';
const azurePoint = 'punto_azul_claro';
const greenPoint = 'punto_verde';
const bluePoint = 'punto_azul';
const cyanPoint = 'punto_cyan';
const magentaPoint = 'punto_magenta';
const violetPoint = 'punto_violeta';
const yellowPoint = 'punto_amarillo';

const minIncidenceLength = apiEnv==apiEnvDev ? 3 : 20;

const km1PointKey = 'punto_km1';
const km2PointKey = 'punto_km2';
const km3PointKey = 'punto_km3';
const km4PointKey = 'punto_km4';
const km5PointKey = 'punto_km5';
const km6PointKey = 'punto_km6';
const km7PointKey = 'punto_km7';
const km8PointKey = 'punto_km8';
const km9PointKey = 'punto_km9';
const km10PointKey = 'punto_km10';
const km11PointKey = 'punto_km11';
const km12PointKey = 'punto_km12';
const km13PointKey = 'punto_km13';
const km14PointKey = 'punto_km14';
const km15PointKey = 'punto_km15';
const km16PointKey = 'punto_km16';
const km17PointKey = 'punto_km17';
const km18PointKey = 'punto_km18';
const km19PointKey = 'punto_km19';
const km20PointKey = 'punto_km20';
const km21PointKey = 'punto_km21';
const km22PointKey = 'punto_km22';
const km23PointKey = 'punto_km23';
const km24PointKey = 'punto_km24';
const km25PointKey = 'punto_km25';
const km26PointKey = 'punto_km26';
const km27PointKey = 'punto_km27';
const km28PointKey = 'punto_km28';
const km29PointKey = 'punto_km29';
const km30PointKey = 'punto_km30';
const km31PointKey = 'punto_km31';
const km32PointKey = 'punto_km32';
const km33PointKey = 'punto_km33';
const km34PointKey = 'punto_km34';
const km35PointKey = 'punto_km35';
const km36PointKey = 'punto_km36';
const km37PointKey = 'punto_km37';
const km38PointKey = 'punto_km38';
const km39PointKey = 'punto_km39';
const km40PointKey = 'punto_km40';
const km41PointKey = 'punto_km41';
const km42PointKey = 'punto_km42';