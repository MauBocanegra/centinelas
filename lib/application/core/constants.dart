const googleClientId = '908225121225-775b6uq57a57nm6c3j6pki745e36r5r3.apps.googleusercontent.com';
const fcmVapidKey = 'BPembO7RJ6ind06ohC8gdUXRoAtmBbCG3WFOYYPVC6EzWoz9QeXCJMS6NcljvvGFDh57UNSPYVnXCnNKjx7G05M';

const apiEnv = apiEnvProd;
const apiEnvDev = 'development';
const apiEnvProd = 'production';
const collectionIdToBeDisplayedRoute = 'coleccion_visible';
const collectionIdToBeDisplayedId = 'coleccion_visible_en_app';
const raceEntryCollectionKey = 'titulares_de_carrera';
const racesCollectionKey = 'eventos';
const usersInfoCollectionKey = 'usuarios';
const userDataKey = 'datos_usuario';
const lastActiveDayKeyForUser = 'ultimo_dia_activo';
const userRacesDataKey = 'datos_carreras';
const raceEngagementEmpty = 'vacio';
const raceEngagementRegistered = 'registrada';
const raceEngagementCheckedIn = 'checkedin';
const userDataPhoneKey = 'telefono';
const adminsDataKey = 'administradores';
const dispatchersDataKey = 'despachadores';

const raceTitleKey = 'titulo';

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

const userDataNameKey = 'nombre_centinela';
const userDataEmergencyContactNameKey = 'contacto_emergencia_nombre';
const userDataEmergencyContactPhoneKey = 'contacto_emergencia_telefono';
const userDataSevereAllergiesKey = 'alergias_severas';
const userDataDrugSensitivitiesKey = 'sensibilidad_farmacos';

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

const minIncidenceLength = apiEnv==apiEnvDev ? 3 : 20;