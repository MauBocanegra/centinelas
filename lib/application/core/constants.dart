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