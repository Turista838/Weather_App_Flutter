// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(minTemp) => "Min: ${minTemp} ºC";

  static String m1(day, month) => "Weather forecast: ${day} / ${month}";

  static String m2(day, month) => "Weather forecast ${day} / ${month}";

  static String m3(maxTemp) => "Max: ${maxTemp} ºC /";

  static String m4(humidity) => "Humidity: ${humidity}%";

  static String m5(lat, lon) => "Latitude: ${lat}; Longitude: ${lon}";

  static String m6(max, min) => "Max: ${max} ºC \nMin: ${min} ºC";

  static String m7(uv) => "UV Index: ${uv}";

  static String m8(wind) => "Wind: ${wind} km/h";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ApiLanguage": MessageLookupByLibrary.simpleMessage("en"),
        "LocationDeniedForever": MessageLookupByLibrary.simpleMessage(
            "Location permission denied forever by the system. It is necessary to authorize location services through system settings!"),
        "aboutCredits": MessageLookupByLibrary.simpleMessage(
            "Created by:\nGonçalo Ramalho\n\nAMOV 21/22 - ISEC"),
        "currentTemp":
            MessageLookupByLibrary.simpleMessage("Current Temperature:"),
        "forcastMin": m0,
        "forecastDate": m1,
        "forecastDateDetails": m2,
        "forecastMax": m3,
        "humidity": m4,
        "lastTimeUpdate": MessageLookupByLibrary.simpleMessage("Last update: "),
        "latLong": m5,
        "maxMinForecast": m6,
        "meteoDaysFive": MessageLookupByLibrary.simpleMessage("5 days"),
        "meteoDaysSeven": MessageLookupByLibrary.simpleMessage("7 days"),
        "meteoDaysThree": MessageLookupByLibrary.simpleMessage("3 days"),
        "rain": MessageLookupByLibrary.simpleMessage("Rain prob.: "),
        "serviceDenied": MessageLookupByLibrary.simpleMessage("Service denied"),
        "serviceNotAvailabe":
            MessageLookupByLibrary.simpleMessage("Service not available"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updateNeeded":
            MessageLookupByLibrary.simpleMessage("You need to update"),
        "uv": m7,
        "weatherDetails":
            MessageLookupByLibrary.simpleMessage("Forecast details"),
        "wind": m8
      };
}
