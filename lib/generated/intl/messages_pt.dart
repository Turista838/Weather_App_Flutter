// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(minTemp) => "Min: ${minTemp} ºC";

  static String m1(day, month) => "Previsão dia: ${day} / ${month}";

  static String m2(day, month) => "Previsão do dia ${day} / ${month}";

  static String m3(maxTemp) => "Max: ${maxTemp} ºC /";

  static String m4(humidity) => "Humidade: ${humidity}%";

  static String m5(lat, lon) => "Latitude: ${lat}; Longitude: ${lon}";

  static String m6(max, min) => "Max: ${max}  ºC \nMin: ${min}  ºC";

  static String m7(uv) => "Index UV: ${uv}";

  static String m8(wind) => "Vento: ${wind} km/h";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ApiLanguage": MessageLookupByLibrary.simpleMessage("pt"),
        "LocationDeniedForever": MessageLookupByLibrary.simpleMessage(
            "Permissão de localização negada para sempre pelo sistema. É necessário autorizar os serviços de localização através das definições do sistema!"),
        "aboutCredits": MessageLookupByLibrary.simpleMessage(
            "Criado por:\nGonçalo Ramalho\n\nAMOV 21/22 - ISEC"),
        "currentTemp":
            MessageLookupByLibrary.simpleMessage("Temperatura actual:"),
        "forcastMin": m0,
        "forecastDate": m1,
        "forecastDateDetails": m2,
        "forecastMax": m3,
        "humidity": m4,
        "lastTimeUpdate":
            MessageLookupByLibrary.simpleMessage("Última actualização: "),
        "latLong": m5,
        "maxMinForecast": m6,
        "meteoDaysFive": MessageLookupByLibrary.simpleMessage("5 dias"),
        "meteoDaysSeven": MessageLookupByLibrary.simpleMessage("7 dias"),
        "meteoDaysThree": MessageLookupByLibrary.simpleMessage("3 dias"),
        "rain": MessageLookupByLibrary.simpleMessage("Prob. chuva: "),
        "serviceDenied": MessageLookupByLibrary.simpleMessage("Serviço negado"),
        "serviceNotAvailabe":
            MessageLookupByLibrary.simpleMessage("Serviço não disponivel"),
        "update": MessageLookupByLibrary.simpleMessage("Actualizar"),
        "updateNeeded":
            MessageLookupByLibrary.simpleMessage("É necessário actualizar"),
        "uv": m7,
        "weatherDetails":
            MessageLookupByLibrary.simpleMessage("Detalhes da previsão"),
        "wind": m8
      };
}
