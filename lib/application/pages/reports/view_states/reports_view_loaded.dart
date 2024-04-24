import 'package:centinelas_app/application/core/strings.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportsViewLoaded extends StatelessWidget {
  const ReportsViewLoaded({
    super.key,
    required this.reportsModelList
  });
  final List<ReportModel> reportsModelList;

  @override
  Widget build(BuildContext context) {
    return
      reportsModelList.isEmpty ?
      const Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: Text(reportsPlaceholderText),
          )
      )
          :
      ListView.builder(
        itemCount: reportsModelList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(4.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      reportsModelList[index].raceNameString
                    ),
                    const Text('Bitacora de actividad:'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                      child: ListView.builder(
                        itemCount: reportsModelList[index].raceLog.length,
                        itemBuilder: (context, raceLogIndex) {
                          return Text('${reportsModelList[index].raceLog.keys.toList()[raceLogIndex]} '
                              ': ${timeStampToDate(
                              reportsModelList[index].raceLog.values.toList()[raceLogIndex]
                          )}');
                        },
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
                    reportsModelList[index].incidencesList.isNotEmpty ?
                    const Text('Incidencias:') : Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                      child: ListView.builder(
                        itemCount: reportsModelList[index].incidencesList.length,
                        itemBuilder: (context, incidencesIndex){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hora de reporte: ${reportsModelList[index].incidencesList[incidencesIndex].time}'),
                              Text('Texto incidencia: ${reportsModelList[index].incidencesList[incidencesIndex].text}'),
                              const Divider(),
                            ],
                          );
                        },
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  String timeStampToDate(int timestamp){
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${tsdate.day}/'
        '${tsdate.month}/'
        '${tsdate.year} - ${tsdate.hour}:${tsdate.minute}:${tsdate.second}';
  }
}
