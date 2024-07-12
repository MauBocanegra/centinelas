const {onRequest} = require("firebase-functions/v2/https");
const {onValueCreated} = require("firebase-functions/v2/database");
const {logger} = require("firebase-functions");

// The Firebase Admin SDK to access the Firebase Realtime Database.
const functions = require('firebase-functions');
const admin = require("firebase-admin");

var serviceAccount = require("./centinelas_firebase_admin.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://centinelas-27d9b-default-rtdb.firebaseio.com"
});

const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors({origin: true}));

const db = admin.firestore();
const realtimeDB = admin.database();

// Routes
app.get('/api/prod/reports/:userId', async (req, res) => {
    try {
        const userRef = db.collection('production/usuarios/' + req.params.userId);
        const userSnapshot = await userRef.get();

        const carrerasDocRef = userRef.doc('datos_carreras');
        const carrerasDocSnapshot = await carrerasDocRef.get();

        let response = [];
        const raceDocData = carrerasDocSnapshot.data();

        if(!carrerasDocSnapshot.exists){
            return res.status(200).send({ status: 'SUCCESS', 'message':'EMPTY_DATA', 'data': {} });
        }

        for (const race_id of Object.keys(raceDocData)) {
            if (!race_id.startsWith('bitacora')) {
                const fullRaceObj = await db.doc('production/eventos/' + race_id).get();
                const fullRace = fullRaceObj.data();
                let eachRaceObject = {
                    'race_id': race_id,
                    'last_interaction': raceDocData[race_id],
                    'esta_activa': fullRace['esta_activa'],
                    'titulo': fullRace['titulo'],
                    'race_log': raceDocData['bitacora/' + race_id],
                    'incidences': [],
                };
                response.push(eachRaceObject);
            }
        }

        const incidenceSnapshot = await realtimeDB.ref('production/incidencias').once('value');
        incidenceSnapshot.forEach(eachIncidence => {
            if (eachIncidence.child('centinela_id').val() === req.params.userId) {
                response.forEach(eachRace => {
                    if (eachRace['race_id'] === eachIncidence.child('carrera_id').val()) {
                        const eachIncidenceObject = {
                            'carrera_id': eachIncidence.child('carrera_id').val(),
                            'centinela_id': eachIncidence.child('centinela_id').val(),
                            'hora_incidencia': eachIncidence.child('hora_incidencia').val(),
                            'latitud_incidencia': eachIncidence.child('latitud_incidencia').val(),
                            'longitud_incidencia': eachIncidence.child('longitud_incidencia').val(),
                            'texto_incidencia': eachIncidence.child('texto_incidencia').val(),
                            'tipo_incidencia': eachIncidence.child('tipo_incidencia').val(),
                        };
                        eachRace['incidences'].push(eachIncidenceObject);
                    }
                });
            }
        });

        return res.status(200).send({ status: 'SUCCESS', 'message':'OK', 'data': response });
    } catch (error) {
        console.log(error);
        return res.status(500).send({ status: 'ERROR', 'message':'ERROR', data: { message: error.message } });
    }
});


app.get('/api/dev/reports/:userId', async (req, res) => {
    try {
        const userRef = db.collection('development/usuarios/' + req.params.userId);
        const userSnapshot = await userRef.get();

        const carrerasDocRef = userRef.doc('datos_carreras');
        const carrerasDocSnapshot = await carrerasDocRef.get();

        let response = [];
        const raceDocData = carrerasDocSnapshot.data();

        if(!carrerasDocSnapshot.exists){
            return res.status(200).send({ status: 'SUCCESS', 'message':'EMPTY_DATA', 'data': {} });
        }

        for (const race_id of Object.keys(raceDocData)) {
            if (!race_id.startsWith('bitacora')) {
                const fullRaceObj = await db.doc('development/eventos/' + race_id).get();
                const fullRace = fullRaceObj.data();
                let eachRaceObject = {
                    'race_id': race_id,
                    'last_interaction': raceDocData[race_id],
                    'esta_activa': fullRace['esta_activa'],
                    'titulo': fullRace['titulo'],
                    'race_log': raceDocData['bitacora/' + race_id],
                    'incidences': [],
                };
                response.push(eachRaceObject);
            }
        }

        const incidenceSnapshot = await realtimeDB.ref('development/incidencias').once('value');
        incidenceSnapshot.forEach(eachIncidence => {
            if (eachIncidence.child('centinela_id').val() === req.params.userId) {
                response.forEach(eachRace => {
                    if (eachRace['race_id'] === eachIncidence.child('carrera_id').val()) {
                        const eachIncidenceObject = {
                            'carrera_id': eachIncidence.child('carrera_id').val(),
                            'centinela_id': eachIncidence.child('centinela_id').val(),
                            'hora_incidencia': eachIncidence.child('hora_incidencia').val(),
                            'latitud_incidencia': eachIncidence.child('latitud_incidencia').val(),
                            'longitud_incidencia': eachIncidence.child('longitud_incidencia').val(),
                            'texto_incidencia': eachIncidence.child('texto_incidencia').val(),
                            'tipo_incidencia': eachIncidence.child('tipo_incidencia').val(),
                        };
                        eachRace['incidences'].push(eachIncidenceObject);
                    }
                });
            }
        });

        return res.status(200).send({ status: 'SUCCESS', 'message':'OK', 'data': response });
    } catch (error) {
        console.log(error);
        return res.status(500).send({ status: 'ERROR', 'message':'ERROR', data: { message: error.message } });
    }
});

exports.notifyDispatchersDev = onValueCreated("/development/incidencias/{incidenceid}/texto_incidencia", (event) => {
  
  admin.database().ref('/development/despachadores').once('value', dispatchersSnapshot => {
    const dispatchersFCMTokens = [];
    dispatchersSnapshot.forEach(eachDispatcher => {
      dispatchersFCMTokens.push(eachDispatcher.child('despachador_fcm_token').val());
    });

    const dispatchersMails = [];
    dispatchersSnapshot.forEach(eachDispatcher => {
      dispatchersMails.push(eachDispatcher.child('despachador_email').val());
    });

    const message = {
      notification : {
        title: "Incidencia reportada!",
        body: "Verifica la app Centinelas",
        sound: 'default',
      },
      data: {
        message: "Verifica la app Centinelas",
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
    };
    const options = {
      priority: "high",
    };

      const response = admin.messaging().sendToDevice(dispatchersFCMTokens, message, options).then(function (response) {
       console.log("Successfully sent message:", response);
     })
     .catch(function (error) {
      console.log("Error sending message:", error);
     });;

    return event.data.ref.parent.child("despachadores_notificados").set(dispatchersMails);
  });
});

exports.notifyDispatchersProd = onValueCreated("/production/incidencias/{incidenceid}/texto_incidencia", (event) => {

  admin.database().ref('/production/despachadores').once('value', dispatchersSnapshot => {
    const dispatchersFCMTokens = [];
    dispatchersSnapshot.forEach(eachDispatcher => {
      dispatchersFCMTokens.push(eachDispatcher.child('despachador_fcm_token').val());
    });

    const dispatchersMails = [];
    dispatchersSnapshot.forEach(eachDispatcher => {
      dispatchersMails.push(eachDispatcher.child('despachador_email').val());
    });

    const message = {
      notification : {
        title: "Incidencia reportada!",
        body: "Verifica la app Centinelas",
        sound: 'default',
      },
      data: {
        message: "Verifica la app Centinelas",
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
    };
    const options = {
      priority: "high",
    };

      const response = admin.messaging().sendToDevice(dispatchersFCMTokens, message, options).then(function (response) {
       console.log("Successfully sent message:", response);
     })
     .catch(function (error) {
      console.log("Error sending message:", error);
     });;

    return event.data.ref.parent.child("despachadores_notificados").set(dispatchersMails);
  });
});

// Export api to Firebase Cloud Functions
exports.app = functions.https.onRequest(app);

