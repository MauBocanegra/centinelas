const googleClientId = '908225121225-775b6uq57a57nm6c3j6pki745e36r5r3.apps.googleusercontent.com';

const apiEnv = 'prod';
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

const raceIdKeyForMapping = 'raceIdString';
const raceEngagementKeyForMapping = 'raceEngagementObj';
const phoneKeyForMapping = 'phoneIdString';
const incidenceTextKeyForMapping = 'incidenceTextString';
const incidenceTypeKeyForMapping = 'incidenceTypeObj';
const uidKeyForMapping = 'uidString';

const incidenceEmergencyTypeForMapping = 'incidenciaEmergencia';
const incidenceAssistanceTypeForMapping = 'incidenciaAsistencia';

const incidencesRealtimeDBPath = '$apiEnv/incidencias';
const assistanceIncidencesRealtimeDBPath = '$apiEnv/asistencias-incidencias';
const emergencyIncidencesRealtimeDBPath = '$apiEnv/emergencias-incidencias';
const usersIncidencesRealtimeDBPath = '$apiEnv/usuarios-incidencias';
const racesIncidencesRealtimeDBPath = '$apiEnv/carreras-incidencias';
const raceIdRealtimeDBKey = 'carrera_id';
const incidenceTextRealtimeDBKey = 'texto_incidencia';
const incidenceTimeRealtimeDBKey = 'hora_incidencia';
const incidenceTypeRealtimeDBKey = 'tipo_incidencia';
const centinelIdRealtimeDBKey = 'centinela_id';

const activeRaceIdParamKey = 'activeRaceId';