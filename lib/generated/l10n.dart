// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `3 days`
  String get meteoDaysThree {
    return Intl.message(
      '3 days',
      name: 'meteoDaysThree',
      desc: '',
      args: [],
    );
  }

  /// `5 days`
  String get meteoDaysFive {
    return Intl.message(
      '5 days',
      name: 'meteoDaysFive',
      desc: '',
      args: [],
    );
  }

  /// `7 days`
  String get meteoDaysSeven {
    return Intl.message(
      '7 days',
      name: 'meteoDaysSeven',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get ApiLanguage {
    return Intl.message(
      'en',
      name: 'ApiLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Last update: `
  String get lastTimeUpdate {
    return Intl.message(
      'Last update: ',
      name: 'lastTimeUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Latitude: {lat}; Longitude: {lon}`
  String latLong(Object lat, Object lon) {
    return Intl.message(
      'Latitude: $lat; Longitude: $lon',
      name: 'latLong',
      desc: '',
      args: [lat, lon],
    );
  }

  /// `Current Temperature:`
  String get currentTemp {
    return Intl.message(
      'Current Temperature:',
      name: 'currentTemp',
      desc: '',
      args: [],
    );
  }

  /// `Weather forecast: {day} / {month}`
  String forecastDate(Object day, Object month) {
    return Intl.message(
      'Weather forecast: $day / $month',
      name: 'forecastDate',
      desc: '',
      args: [day, month],
    );
  }

  /// `Max: {max} ºC \nMin: {min} ºC`
  String maxMinForecast(Object max, Object min) {
    return Intl.message(
      'Max: $max ºC \nMin: $min ºC',
      name: 'maxMinForecast',
      desc: '',
      args: [max, min],
    );
  }

  /// `Service not available`
  String get serviceNotAvailabe {
    return Intl.message(
      'Service not available',
      name: 'serviceNotAvailabe',
      desc: '',
      args: [],
    );
  }

  /// `Service denied`
  String get serviceDenied {
    return Intl.message(
      'Service denied',
      name: 'serviceDenied',
      desc: '',
      args: [],
    );
  }

  /// `You need to update`
  String get updateNeeded {
    return Intl.message(
      'You need to update',
      name: 'updateNeeded',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Forecast details`
  String get weatherDetails {
    return Intl.message(
      'Forecast details',
      name: 'weatherDetails',
      desc: '',
      args: [],
    );
  }

  /// `Humidity: {humidity}%`
  String humidity(Object humidity) {
    return Intl.message(
      'Humidity: $humidity%',
      name: 'humidity',
      desc: '',
      args: [humidity],
    );
  }

  /// `Rain prob.: `
  String get rain {
    return Intl.message(
      'Rain prob.: ',
      name: 'rain',
      desc: '',
      args: [],
    );
  }

  /// `Wind: {wind} km/h`
  String wind(Object wind) {
    return Intl.message(
      'Wind: $wind km/h',
      name: 'wind',
      desc: '',
      args: [wind],
    );
  }

  /// `UV Index: {uv}`
  String uv(Object uv) {
    return Intl.message(
      'UV Index: $uv',
      name: 'uv',
      desc: '',
      args: [uv],
    );
  }

  /// `Max: {maxTemp} ºC /`
  String forecastMax(Object maxTemp) {
    return Intl.message(
      'Max: $maxTemp ºC /',
      name: 'forecastMax',
      desc: '',
      args: [maxTemp],
    );
  }

  /// `Min: {minTemp} ºC`
  String forcastMin(Object minTemp) {
    return Intl.message(
      'Min: $minTemp ºC',
      name: 'forcastMin',
      desc: '',
      args: [minTemp],
    );
  }

  /// `Weather forecast {day} / {month}`
  String forecastDateDetails(Object day, Object month) {
    return Intl.message(
      'Weather forecast $day / $month',
      name: 'forecastDateDetails',
      desc: '',
      args: [day, month],
    );
  }

  /// `Created by:\nGonçalo Ramalho\n\nAMOV 21/22 - ISEC`
  String get aboutCredits {
    return Intl.message(
      'Created by:\nGonçalo Ramalho\n\nAMOV 21/22 - ISEC',
      name: 'aboutCredits',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied forever by the system. It is necessary to authorize location services through system settings!`
  String get LocationDeniedForever {
    return Intl.message(
      'Location permission denied forever by the system. It is necessary to authorize location services through system settings!',
      name: 'LocationDeniedForever',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
