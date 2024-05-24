const registerButtonText = 'Registrate';
const checkInButtonText = 'Check In';
const mapButtonText = 'Seguir carrera en tiempo real';
const String phoneAndCheckInButtonText = 'Guardar / Check In';
const assistanceButtonText = 'Soliciar asistencia';
const emergencyButtonText = 'Reportar EMERGENCIA';
const checkedInNotActiveRaceText = 'Tu Check-In esta completo\nUna vez activa la carrera podrás realizar tus reportes';
const obtainingLocationString = 'Obteniendo ubicacion y enviando incidencia...';
const errorRaceDetailButtonsWidget = 'Ocurrio un error, intenta nuevamente mas tarde';

const String stringPhoneTitle = 'Teléfono celular';
const String hintPhone = 'Número celular a 10 digitos';
const String errorPhone = 'El número debe ser de 10 dígitos';
const String stringEmergencyContactName = 'Nombre (contacto de emergencia)';
const String stringEmergencyContactPhone = 'Teléfono (contacto de emergencia)';
const String stringAllergies = 'Alergias severas';
const String stringDrugSensitivity = 'Sensibilidad a Farmacos';

const String allowedChars = '[a-zA-Z áéíóúüçñÑ]';

const assistanceDialogTitle = 'Asistencia';
const assistanceDialogHint = 'Reportar de manera concisa la alerta';
const assistanceDialogDescription = 'Describe el incidente con el mayor detalle posible, '
    'no olvides el número del corredor y su género.';
const assistanceDialogNoEmptyText = 'No puedes mandar incidencias que no contengan información importante\n$assistanceDialogDescription';
const emergencyDialogTitle = 'EMERGENCIA';
const emergencyDialogHint = 'EMERGENCIA, SE CONTACTARÁ UN DESPACHADOR DE INMEDIATO';
const emergencyDialogDescription = 'Describe la EMERGENCIA con el mayor detalle posible, no olvides el número del corredor y su género.';
const emergencyDialogNoEmptyText = 'No puedes mandar incidencias que no contengan información importante\n$emergencyDialogDescription';
const incidenceReportedConfirmationText = 'Incidencia reportada correctamente\n'
    'Un despachador se pondrá en contacto contigo';
const incidenceReportedErrorText ='Ocurrio un error, intenta nuevamente';
const reportsPlaceholderText = 'Aquí podrás ver los reportes que realizaste durante la carrera.';

const goToMapButtonText = '';

const locationDeniedDialogTitle = 'Denegaste dar a la app Centinelas el acceso a tu ubicación.\nSin acceso a tu ubicación tus reportes de incidencia no incluirán la ubicación';
const locationOffDialogTitle = 'La ubicación de tu dispositivo no esta encendida.\nSin acceso a tu ubicacion tus reportes de incidencia no incluiran la ubicacion';
const locationErrorDialogOkButton = 'Continuar';

const reportsErrorString = 'Ocurrió un error al cargar tus reportes, intenta nuevamente más tarde...';
const reportErrorString = 'Ocurrió un error al cargar los reportes, intenta nuevamente más tarde...';
const usersListErrorString = 'Ocurrió un error al obtener el listado de Centinelas, intenta nuevamente más tarde...';

const privacyButtonText1 = 'Al iniciar sesión aceptas la ';
const privacyButtonText2 = 'Política de privacidad de datos';
const privacyText = "AVISO DE PRIVACIDAD"+
    "De conformidad con lo establecido en la Ley Federal de Protección de Datos Personales en Posesión de los Particulares, Sport Promotion S.A de C.V. pone a su disposición el siguiente aviso de privacidad."+
    "Sport Promotion S.A de C.V., es responsable del uso y protección de sus datos personales, en este sentido y atendiendo las obligaciones legales establecidas en la Ley Federal de Protección de Datos Personales en Posesión de los Particulares, a través de este instrumento se informa a los titulares de los datos, la información que de ellos se recaba y los fines que se le darán a dicha información."+
    "Además de lo anterior, informamos a usted que Sport Promotion S.A de C.V., tiene su domicilio ubicado en:"+
    "Morena 216-A, Col. Del Valle, Benito Juárez, 03100, CDMX."+
    "Los datos personales que recabamos de usted serán utilizados para las siguientes finalidades, las cuales son necesarias para concretar nuestra relación con usted, así como para atender los servicios y/o pedidos que solicite:"+
    "Brindar una atención mucho mas eficiente como Centinela"+
    "Para llevar a cabo las finalidades descritas en el presente aviso de privacidad, utilizaremos los siguientes datos personales:"+
    "- Teléfono celular - Ubicación aproximada del dispositivo al momento de reportar una incidencia"+
    "Por otra parte, informamos a usted, que sus datos personales no serán compartidos con ninguna autoridad, empresa, organización o persona distintas a nosotros y serán utilizados exclusivamente para los fines señalados."+
    "Usted tiene en todo momento el derecho a conocer qué datos personales tenemos de usted, para qué los utilizamos y las condiciones del uso que les damos (Acceso). Asimismo, es su derecho solicitar la corrección de su información personal en caso de que esté desactualizada, sea inexacta o incompleta (Rectificación); de igual manera, tiene derecho a que su información se elimine de nuestros registros o bases de datos cuando considere que la misma no está siendo utilizada adecuadamente (Cancelación); así como también a oponerse al uso de sus datos personales para fines específicos (Oposición). Estos derechos se conocen como derechos ARCO."+
    "Para el ejercicio de cualquiera de los derechos ARCO, se deberá presentar la solicitud respectiva a través del siguiente correo electrónico:"+
    "marcoaliceaga@sportspromotion.com.mx"+
    "Lo anterior también servirá para conocer el procedimiento y requisitos para el ejercicio de los derechos ARCO, no obstante, la solicitud de ejercicio de estos derechos debe contener la siguiente información:"+
    "Nombre completo Correo electrónico con el cual hizo uso de la aplicación \"Centinelas\""+
    "La respuesta a la solicitud se dará en el siguiente plazo: 20 días hábiles, y se comunicará de la siguiente manera:"+
    "A través del correo electrónico por el cual se inicie la solicitud"+
    "Los datos de contacto de la persona o departamento de datos personales, que está a cargo de dar trámite a las solicitudes de derechos ARCO, son los siguientes:"+
    "a) Nombre del responsable: Marco Antonio Liceaga Echevarría"+
    "b) Domicilio:"+
    "Morena 216-A, Col. Del Valle, Benito Juárez, 03100, CDMX."+
    "c) Teléfono: 55 2900 6382 d) Correo electrónico: marcoaliceaga@sportspromotion.com.mx e) Otro medio de contacto: sportspromotion.com.mx@gmail.com"+
    "Cabe mencionar, que en cualquier momento usted puede revocar su consentimiento para el uso de sus datos personales. Del mismo modo, usted puede revocar el consentimiento que, en su caso, nos haya otorgado para el tratamiento de sus datos personales."+
    "Asimismo, usted deberá considerar que para ciertos fines la revocación de su consentimiento implicará que no podamos seguir prestando el servicio que nos solicitó, o la conclusión de su relación con nosotros."+
    "Para revocar el consentimiento que usted otorga en este acto o para limitar su divulgación, se deberá presentar la solicitud respectiva a través del siguiente correo electrónico:"+
    "marcoaliceaga@sportspromotion.com.mx"+
    "Del mismo modo, podrá solicitar la información para conocer el procedimiento y requisitos para la revocación del consentimiento, así como limitar el uso y divulgación de su información personal, sin embargo, estas solicitudes deberán contener la siguiente información:"+
    "- Nombre completo - Correo electrónico con el cual se dio de alta en la aplicación \"Centinelas\""+
    "La respuesta a la solicitud de revocación o limitación de divulgación de sus datos se dará a más tardar en el siguiente plazo: 20 días hábiles, y se comunicará de la siguiente forma:"+
    "A través del correo electrónico con el cuál se haga la petición de cambios en nuestro modelo de negocio, o por otras causas, por lo cual, nos comprometemos a mantenerlo informado sobre los cambios que pueda sufrir el presente aviso de privacidad, sin embargo, usted puede solicitar información sobre si el mismo ha sufrido algún cambio a través del siguiente correo electrónico:"+
    "marcoaliceaga@sportspromotion.com.mx" ;