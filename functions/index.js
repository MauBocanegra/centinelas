const {onRequest} = require("firebase-functions/v2/https");
const {onValueCreated} = require("firebase-functions/v2/database");
const {logger} = require("firebase-functions");

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require("firebase-admin");
admin.initializeApp();

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

