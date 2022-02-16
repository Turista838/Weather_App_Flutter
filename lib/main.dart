import 'dart:convert';
import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/weather_details.dart';

import 'generated/l10n.dart';

extension StringExtension on String {
  String addZeroMinutesHours() {
    var time = split(":");
    if (time[1].length == 1) {
      time[1] = "0" + time[1];
    }
    if (time[2].length == 1) {
      time[2] = "0" + time[2];
    }
    return "${time[0]}:${time[1]}:${time[2]}";
  }
}

class OpenWeatherAPI {
  String? language;

  OpenWeatherAPI(String lgg) {
    language = lgg;
  }

  Uri getUri(double lat, double lon) {
    //https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&units=metric&exclude=minutely,hourly,alerts&appid=67a6f0e8e8f709f6127ef5301e0cc3db

    final params = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': "metric",
      'exclude': "minutely,hourly,alerts",
      'lang': language,
      'appid': "67a6f0e8e8f709f6127ef5301e0cc3db"
    };

    return Uri.https("api.openweathermap.org", "/data/2.5/onecall", params);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //intl:
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      title: 'WeatherApp',
      theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.teal, scaffoldBackgroundColor: Colors.white),
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName: (_) => const MyHomePage(title: "WeatherApp"),
        WeatherDetails.routeName: (_) => const WeatherDetails(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static const String routeName = "MyWeatherApp";
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Color colorA = const Color(0xFF00A19D);
  Color colorB = const Color(0xFFFFF8E5);
  Color colorC = const Color(0xFFFFB344);
  Color colorD = const Color(0xFFE05D5D);

  late String _lastUpdate;

  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  late double _lat;
  late double _lon;
  late String _city;

  bool _fetchingChanges = true;
  Weather? weather;

  late String _listViewStr = S.of(context).meteoDaysThree;
  int _listViewSize = 5;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  final Tween<double> _scaleAnimation = Tween(begin: 0.85, end: 1.15);
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = _scaleAnimation.animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
    ));
    _fetchPermission();
    _getLastUpdate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchPermission() async {
    try {
      setState(() => _fetchingChanges = true);

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }
    } catch (ex, stacktrace) {
      debugPrint('[_fetchPermission()] Something went wrong: $ex');
      debugPrint('$stacktrace');
    } finally {
      setState(() => _fetchingChanges = false);
    }
  }

  Future<void> _fetchLocation() async {
    if (_permissionGranted != PermissionStatus.deniedForever ||
        _permissionGranted != PermissionStatus.denied) {
      _locationData = await location.getLocation();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble("lastLat", _locationData?.latitude ?? 0);
      await prefs.setDouble("lastLon", _locationData?.longitude ?? 0);

      _lat = _locationData?.latitude ?? 0;
      _lon = _locationData?.longitude ?? 0;

      List<geo.Placemark> places =
          await geo.placemarkFromCoordinates(_lat, _lon);
      _city = places[0].locality ?? "";
      await prefs.setString("city", _city);

      _updateWeather();
    }

    setState(() {});
  }

  Future<void> _updateWeather() async {
    try {
      setState(() => _fetchingChanges = true);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime _now = DateTime.now();

      OpenWeatherAPI openWeatherAPI = OpenWeatherAPI(S.of(context).ApiLanguage);
      http.Response response = await http.get(openWeatherAPI.getUri(
          _locationData!.latitude!, _locationData!.longitude!));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> decodedData =
            json.decode(response.body); //receive
        weather = Weather.fromJson(decodedData); //decode
        await prefs.setString("weatherMap", json.encode(decodedData)); //save
      }

      _lastUpdate = "${_now.hour}:${_now.minute}:${_now.second}";
      await prefs.setString('lastTimedUpdated', _lastUpdate);
    } catch (ex, stacktrace) {
      debugPrint('[_updateWeather()] Something went wrong: $ex');
      debugPrint('$stacktrace');
    } finally {
      setState(() => _fetchingChanges = false);
    }
  }

  Future<void> _getLastUpdate() async {
    try {
      setState(() => _fetchingChanges = true);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      _lastUpdate = (prefs.getString('lastTimedUpdated') ?? "null");

      var _weatherJson = (prefs.getString('weatherMap') ?? "null");
      if (_weatherJson != "null") {
        Map<String, dynamic> weatherInfo = jsonDecode(_weatherJson);
        weather = Weather.fromJson(weatherInfo);
      }

      if (_lastUpdate == "null") {
        DateTime _now = DateTime.now();
        _lastUpdate = "${_now.hour}:${_now.minute}:${_now.second}";
        await prefs.setString('lastTimedUpdated', _lastUpdate);
      }

      _lat = (prefs.getDouble('lastLat') ?? 0);
      _lon = (prefs.getDouble('lastLon') ?? 0);

      _city = (prefs.getString('city') ?? "");

      //_listViewStr = (prefs.getString('listViewStr') ?? S.of(context).meteoDaysThree);
      _listViewSize = (prefs.getInt('listViewSize') ?? 5);

      if (_listViewSize == 5) {
        _listViewStr = S.of(context).meteoDaysThree;
      } else {
        if (_listViewSize == 3) {
          _listViewStr = S.of(context).meteoDaysFive;
        } else {
          _listViewStr = S.of(context).meteoDaysSeven;
        }
      }

    } catch (ex, stacktrace) {
      debugPrint('[_getLastUpdate()] Something went wrong: $ex');
      debugPrint('$stacktrace');
    } finally {
      setState(() => _fetchingChanges = false);
    }
  }

  Future<void> _updateListSize(String newValue) async {
    try {
      setState(() => _fetchingChanges = true);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (newValue[0] == "3") {
        //show 3 days
        _listViewStr = S.of(context).meteoDaysThree;
        _listViewSize = 5;
      } else {
        //show 5 days
        if (newValue[0] == "5") {
          _listViewStr = S.of(context).meteoDaysFive;
          _listViewSize = 3;
        } else {
          //show 7 days
          _listViewStr = S.of(context).meteoDaysSeven;
          _listViewSize = 1;
        }
      }

      //await prefs.setString('listViewStr', _listViewStr);
      await prefs.setInt('listViewSize', _listViewSize);

    } catch (ex, stacktrace) {
      debugPrint('[_updateListSize()] Something went wrong: $ex');
      debugPrint('$stacktrace');
    } finally {
      setState(() => _fetchingChanges = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
          icon: Icon(
            Icons.help,
            color: colorC,
          ),
          tooltip: 'About',
          onPressed: () {
            showAboutDialog(
                context: context,
                applicationVersion: '1.0.0',
                applicationIcon: Image.asset('assets/weather_icon.png'),
                applicationLegalese: S.of(context).aboutCredits);
          },
        ),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_fetchingChanges)
              const CircularProgressIndicator()
            else ...[
              if (weather != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 2),
                      child: Column(
                        children: [
                          Text(S.of(context).lastTimeUpdate +
                              _lastUpdate.addZeroMinutesHours()),
                          Text(
                              S.of(context).latLong(_lat.toStringAsFixed(4),
                                  _lon.toStringAsFixed(4)),
                              style: const TextStyle(fontSize: 12)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(_city,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                      child: Column(
                        children: [
                          Text(S.of(context).currentTemp,
                              style: const TextStyle(fontSize: 16)),
                          Text(
                              (weather?.currentInfo.temp.toString() ?? "") + " ºC",
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ScaleTransition(
                              scale: _animation,
                              child: Image.network(
                                  "https://openweathermap.org/img/wn/${weather?.currentInfo.weatherInfo.icon}@2x.png", fit: BoxFit.none,
                              ),
                            ),
                          ),
                          Text(
                              weather?.currentInfo.weatherInfo.description
                                      .capitalize() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              if (weather != null)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                          color: colorC,
                          child: ListTile(
                            //visualDensity: const VisualDensity(horizontal: 0, vertical: 1.6),
                            contentPadding:
                                const EdgeInsets.fromLTRB(24, 8, 24, 8),
                            title: Text(S.of(context).forecastDate(
                                DateTime.fromMillisecondsSinceEpoch(
                                        weather!.forecastInfo[index].time *
                                            1000)
                                    .day,
                                DateTime.fromMillisecondsSinceEpoch(
                                        weather!.forecastInfo[index].time *
                                            1000)
                                    .month)),
                            subtitle: Text(S.of(context).maxMinForecast(
                                weather!
                                    .forecastInfo[index].forecastTemp.maxTemp,
                                weather!
                                    .forecastInfo[index].forecastTemp.minTemp)),
                            trailing: Image.network(
                                "https://openweathermap.org/img/wn/${weather!.forecastInfo[index].weatherInfo.icon}@2x.png"),
                            onTap: () => Navigator.pushNamed(
                                context, WeatherDetails.routeName,
                                arguments: weather!.forecastInfo[index]),
                          )),
                      separatorBuilder: (_, __) => Divider(
                            height: 4,
                            thickness: 4,
                            color: colorB,
                          ),
                      itemCount: weather!.forecastInfo.length - _listViewSize),
                ),
            ],
            if (!_serviceEnabled)
              Text(S.of(context).serviceNotAvailabe,
                  textAlign: TextAlign.center)
            else if (_permissionGranted == PermissionStatus.denied)
              Text(S.of(context).serviceDenied, textAlign: TextAlign.center)
            else if (_permissionGranted == PermissionStatus.deniedForever)
              Text(S.of(context).LocationDeniedForever,
                  textAlign: TextAlign.center)
            else if (_locationData == null)
              Text(S.of(context).updateNeeded, textAlign: TextAlign.center),
            if (_permissionGranted != PermissionStatus.deniedForever)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: _listViewStr,
                      dropdownColor: colorB,
                      icon: Icon(Icons.arrow_upward_rounded, color: colorD),
                      elevation: 16,
                      style: TextStyle(color: colorD),
                      underline: Container(
                        height: 5,
                        color: colorD,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _updateListSize(newValue!);
                        });
                      },
                      items: <String>[
                        S.of(context).meteoDaysThree,
                        S.of(context).meteoDaysFive,
                        S.of(context).meteoDaysSeven
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(
                              fontSize: 15)),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () => _fetchLocation(),
                      child: Text(S.of(context).update, style: const TextStyle(
                          fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        primary: colorD,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
