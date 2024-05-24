import 'dart:ui';

import 'package:centinelas_app/application/core/constants.dart';
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
      Column(
        children: [
          Material(
            elevation: 8,
            child: Container(
              alignment: Alignment.center,
              height: 12,
              child: Container(),
            ),
          ),
          const SizedBox(height: 24,),
          ListView.builder(
              shrinkWrap: true,
              itemCount: reportsModelList.length,
              itemBuilder: (context, index) {
                return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const SizedBox(width: 8,),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                          (reportsModelList[index].title ?? '').toUpperCase()
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(28, 4, 0, 0),
                    child: Text('Bitacora de actividad:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reportsModelList[index].raceLog.length,
                      itemBuilder: (context, raceLogIndex) {
                        return Text('${
                          raceLogKeyFormatter(
                              reportsModelList[index].raceLog.keys.toList()[raceLogIndex]
                          )
                        } '
                            ': ${timeStampToDate(
                            reportsModelList[index].raceLog.values.toList()[raceLogIndex]
                        )}');
                      },
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                  reportsModelList[index].incidencesList.isNotEmpty ?
                  const Text('Incidencias:') : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reportsModelList[index].incidencesList.length,
                      itemBuilder: (context, incidencesIndex){
                        return LayoutBuilder(
                          builder: (context, constraints){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 32, 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*
                                  Text('Hora de reporte: ${reportsModelList[index].incidencesList[incidencesIndex].time}'),
                                  Text('Texto incidencia: ${reportsModelList[index].incidencesList[incidencesIndex].text}'),
                                  const Divider(),
                                  */
                                  Material(
                                    elevation: 8.0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(0),
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(0)
                                      )
                                    ),
                                    color: mapColorFromIncidenceType(
                                        reportsModelList[index].incidencesList[incidencesIndex].type
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                                        child: Text(
                                            formatTextForIncidence(
                                                reportsModelList[index].incidencesList[incidencesIndex].type,
                                                reportsModelList[index].incidencesList[incidencesIndex].text
                                            ),
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              color: Colors.white
                                            ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        );
                      },
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                ],
              );
            }
              ),
        ],
      );
  }

  String formatTextForIncidence(String type, String text){
    String introText;
    if(type == incidenceEmergencyTypeForMapping){
      introText = 'EMERGENCIA';
    } else if(type == incidenceAssistanceTypeForMapping){
      introText = 'ASISTENCIA';
    } else {
      introText = '';
    }
    return '$introText: $text';
  }

  Color mapColorFromIncidenceType(String type){
    if(type == incidenceEmergencyTypeForMapping){
      return const Color.fromRGBO(211, 47, 47, 1);
    } else if(type == incidenceAssistanceTypeForMapping){
      return const Color.fromRGBO(163, 214, 191, 1);
    } else {
      return Colors.white;
    }
  }

  String raceLogKeyFormatter(String raceKey){
    if(raceKey == raceEngagementRegistered){
      return 'Registro';
    } else if(raceKey == raceEngagementCheckedIn){
      return 'Check In';
    } else {
      return '';
    }
  }

  String timeStampToDate(int timestamp){
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${tsdate.day}/'
        '${tsdate.month}/'
        '${tsdate.year} - ${tsdate.hour}:${tsdate.minute}:${tsdate.second}';
  }
}
