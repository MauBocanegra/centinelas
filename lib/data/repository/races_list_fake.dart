import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';

final List<RaceEntry> racesFake = [
  RaceEntry(
      'https://www.zonaturistica.com/files/ferias/995/F1_995.jpg',
      title: 'AsTri Merida',
      id: RaceEntryId.fromUniqueString('0'),
      description:'AsTri Mérida - Mérida Yucatan (2 y 3 de Marzo 2024)'
  ),
  RaceEntry(
      'https://www.zonaturistica.com/files/ferias/995/F3_995.jpg',
      title: 'AsTri Campeche',
      id: RaceEntryId.fromUniqueString('1'),
      description:'AsTri Campeche- Campeche (4 de Febrero 2024)'
  ),
  RaceEntry(
      'https://www.canyon.com/dw/image/v2/BCML_PRD/on/demandware.static/-/Library-Sites-canyon-shared/default/dwcb8cfa7a/images/blog/Pro-Sports/tour-de-france-2022-mvdp-yellow-jersey.jpg?sw=1064&sfrm=jpg&q=80',
      title: 'GranFondo La Paz',
      id: RaceEntryId.fromUniqueString('2'),
      description:'LeEtapè La Paz (Tour de France) - La Paz BCS (10 de Marzo 2024)'
  ),
  RaceEntry(
      'https://escueladerunning.com/wp-content/uploads/2017/03/correr-running-runner-playa.jpg',
      title: 'Medio Maraton Veracruz',
      id: RaceEntryId.fromUniqueString('3'),
      description:'18º Medio Maratón Veracruz - Puerto Veracruz (21 de Enero 2024)'
  ),
  RaceEntry(
      'https://www.zonaturistica.com/files/ferias/995/F4_995.jpg',
      title: 'AsTri Cancun',
      id: RaceEntryId.fromUniqueString('4'),
      description:'AsTri Cancún - Cancún (28 de Abril 2024)'
  ),
  RaceEntry( // Carrera del ajolote
      'https://i0.wp.com/blog.claroshop.com/wp-content/uploads/2022/01/What-is-mindful-running-small.jpg?w=1200&ssl=1',
      title: 'Carrera del Ajolote',
      id: RaceEntryId.fromUniqueString('5'),
      description:'Carrera del Ajolote - CDMX (27 de Enero 2024)'
  ),
  RaceEntry( // Maraton
      'https://www.capital21.cdmx.gob.mx/noticias/wp-content/uploads/2022/11/marato%CC%81ncdmx.jpeg',
      title: 'XLI Maraton',
      id: RaceEntryId.fromUniqueString('6'),
      description:'XLI Maratón - CDMX (27 de Agosto 2024)'
  ),
];

final List<RaceFull> racesFullFake = [
  RaceFull(
      'Triatlón AsTri Mérida 2024',
      'Triatlón',
      'Mérida Yucatan, Puerto Progreso',
      "Lugar sede: Puerto Progreso\n"
          "Junior 14-15 años (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n"
          "Súper Sprint (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n"
          "WomanUp (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n",
      'https://www.zonaturistica.com/files/ferias/995/F1_995.jpg',
      id: RaceEntryId.fromUniqueString('0')
  ),
  RaceFull(
      'Triatlón AsTri Campeche 2024',
      'Triatlón',
      'Campeche, Puerto de Arribó',
      "Lugar sede: Puerto de Arribó\n"
          "Junior 14-15 años (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n"
          "Súper Sprint (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n",
      'https://www.zonaturistica.com/files/ferias/995/F3_995.jpg',
      id: RaceEntryId.fromUniqueString('1')
  ),
  RaceFull(
      'LeEtapè La Paz (Tour de France)',
      'Ciclísmo',
      'La Paz, BCS',
      "Lugar sede: Malecón\n"
          "Junior 14-15 años (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n"
          "Súper Sprint (Natación 400 m /Ciclismo 10 km / Carrera 2.5km)\n",
      'https://www.canyon.com/dw/image/v2/BCML_PRD/on/demandware.static/-/Library-Sites-canyon-shared/default/dwcb8cfa7a/images/blog/Pro-Sports/tour-de-france-2022-mvdp-yellow-jersey.jpg?sw=1064&sfrm=jpg&q=80',
      id: RaceEntryId.fromUniqueString('2')
  ),
  RaceFull(
      '18º Medio Maratón Veracruz',
      'Running',
      'Veracruz, Veracruz',
      "Lugar sede: Malecón de Boca del Río\n"
          "21 Km,13.5 mts sobre nivel del Mar, Humedad relativa 58%\n",
      'https://escueladerunning.com/wp-content/uploads/2017/03/correr-running-runner-playa.jpg',
      id: RaceEntryId.fromUniqueString('3')
  ),
  RaceFull(
      'Triatlón AsTri Cancún 2024',
      'Triatlón',
      'Cancún, Puerto Juárez',
      "Lugar sede: Puerto Cancún, Puerto Juárez 77500\n"
          "Triatlón Junior 14-15, Súper Sprint (hombres)\n"
          "WomanUp (solo mujeres novatas): Natación 400 m /Ciclismo 10 km / Carrera 2.5km\n"
          "Triatlón Sprint (individual y relevos): Natación 750 m / Ciclismo 20 km / Carrera 5 km\n"
          "Triatlón Olímpico (individual y relevos): Natación 1,500 m / Ciclismo 40 km / Carrera 10 km\n"
          "Duatlón Sprint (individual): Carrera 5 km / Ciclismo 20 km / Carrera 2.5 km\n",
      'https://escueladerunning.com/wp-content/uploads/2017/03/correr-running-runner-playa.jpg',
      id: RaceEntryId.fromUniqueString('4')
  ),
  RaceFull(
      'Carrera del Ajolote',
      'Running',
      'CDMX',
      "Lugar sede: Pase de la Reforma\n"
          "10 Km, 2,240 mts sobre nivel del Mar, Humedad relativa 32%\n"
          "10 Km, 2,240 mts sobre nivel del Mar, Humedad relativa 32%\n",
      'https://i0.wp.com/blog.claroshop.com/wp-content/uploads/2022/01/What-is-mindful-running-small.jpg?w=1200&ssl=1',
      id: RaceEntryId.fromUniqueString('5')
  ),
  RaceFull(
      'XLI Maratón CDMX',
      'Running',
      'CDMX',
      "Lugar sede: Zócalo Centro Histórico\n"
          "21 Km, 2,240 mts sobre nivel del Mar, Humedad relativa 32%\n",
      'https://www.capital21.cdmx.gob.mx/noticias/wp-content/uploads/2022/11/marato%CC%81ncdmx.jpeg',
      id: RaceEntryId.fromUniqueString('6')
  ),
];