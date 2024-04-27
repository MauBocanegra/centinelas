import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class IncidenceEntryItemViewLoaded extends StatelessWidget {
  const IncidenceEntryItemViewLoaded({
    super.key,
    required this.incidenceModel,
  });
  final IncidenceModel incidenceModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(
            incidenceModel.type == incidenceEmergencyTypeForMapping
                ? 'Emergencia' : 'Asistencia',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(incidenceModel.text),
          leading: incidenceModel.type == incidenceEmergencyTypeForMapping
            ? const Icon(
                Icons.warning_rounded,
                color: Colors.red,
              ) // emergency
            : const Icon(
                Icons.supervised_user_circle_rounded,
                color: Colors.blue,
              ),
          onTap: () async {
            final phoneNumber = incidenceModel.phoneNumber;
            final result = await showModalActionSheet<String>(
                context: context,
              actions: (incidenceModel.lat!=0.0 &&incidenceModel.lon!=0.0) ? [
                SheetAction(
                  icon: Icons.phone,
                  label: 'Llamar al ${phoneNumber}',
                  key: 'phoneCall',
                ),
                SheetAction(
                  icon: Icons.copy,
                  label: 'Copiar \"${phoneNumber}\"',
                  key: 'clipboard',
                ),
                const SheetAction(
                  icon: Icons.map,
                  label: 'Abrir ubicación en Maps',
                  key: 'maps',
                ),
                const SheetAction(
                  icon: Icons.location_on_outlined,
                  label: 'Copiar ubicación',
                  key: 'clipboard_map',
                ),
              ] : [
                SheetAction(
                  icon: Icons.phone,
                  label: 'Llamar al ${phoneNumber}',
                  key: 'phoneCall',
                ),
                SheetAction(
                  icon: Icons.copy,
                  label: 'Copiar \"${phoneNumber}\"',
                  key: 'clipboard',
                ),
              ]
            );
            if(result != null && result == 'phoneCall' && phoneNumber!=null ){
              makePhoneCall(phoneNumber);
            } else if(result != null && result == 'clipboard' && phoneNumber!=null) {
              copyToClipboard(phoneNumber);
            } else if(result != null && result == 'clipboard_map'){
              copyToClipboard('${incidenceModel.lat}, ${incidenceModel.lon}');
            } else if(result != null && result == 'maps'){
              openMaps(incidenceModel.lat, incidenceModel.lon);
            }
          },// assistance
        ),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async{
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('exception in LaunchURL: ${exception.toString()}');
    }
  }

  Future<void> openMaps(double lat, double lon) async{
    try {
      MapsLauncher.launchCoordinates(lat, lon);
    }on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('exception in LaunchURL: ${exception.toString()}');
    }
  }

  Future<void> copyToClipboard(String phoneNumber) async {
    try {
      await Clipboard.setData(ClipboardData(text: phoneNumber));
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('exception in LaunchURL: ${exception.toString()}');
    }
  }
}
