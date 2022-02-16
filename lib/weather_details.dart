import 'package:flutter/material.dart';
import 'package:weather_app/weather.dart';

import 'generated/l10n.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class WeatherDetails extends StatefulWidget {
  static const String routeName = 'WeatherDetails';

  const WeatherDetails({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> with TickerProviderStateMixin {
  late double borderRadius;
  Color colorA = const Color(0xFF00A19D);
  Color colorB = const Color(0xFFFFF8E5);
  Color colorC = const Color(0xFFFFB344);
  Color colorD = const Color(0xFFE05D5D);
  late Color colorBorder;
  bool tapped = false;
  late final ForecastInfo forecastInfo = ModalRoute.of(context)?.settings.arguments as ForecastInfo;

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
    colorBorder = colorB;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeContainerDecoration() {
    setState(() {
      if (tapped) {
        Color temp = colorC;
        colorC = colorD;
        colorD = temp;
        colorBorder = colorB;
      } else {
        Color temp = colorC;
        colorC = colorD;
        colorD = temp;
        colorBorder = colorA;
      }
      tapped = !tapped;
    });
  }

  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).weatherDetails),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Column(children: [
                      Text(S.of(context).forecastDateDetails( DateTime.fromMillisecondsSinceEpoch(forecastInfo.time * 1000).day,
                          (DateTime.fromMillisecondsSinceEpoch(forecastInfo.time * 1000).month)),
                          style: const TextStyle(fontSize: 22)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: Column(children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ScaleTransition(
                          scale: _animation,
                          child: Image.network(
                            "https://openweathermap.org/img/wn/${forecastInfo.weatherInfo.icon}@2x.png", fit: BoxFit.none,
                          ),
                        ),
                      ),
                      Text(forecastInfo.weatherInfo.description.capitalize(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeContainerDecoration(),
                      child: AnimatedContainer(
                        //margin: EdgeInsets.all(margin),
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorC, colorD],
                          ),
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: colorBorder),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.thermostat,
                              color: Colors.deepOrangeAccent,
                              size: 36.0,
                            ),
                            const SizedBox(width: 20),
                            Text(
                                S.of(context).forecastMax(
                                    forecastInfo.forecastTemp.maxTemp),
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                S.of(context).forcastMin(
                                    forecastInfo.forecastTemp.minTemp),
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeContainerDecoration(),
                      child: AnimatedContainer(
                        //margin: EdgeInsets.all(margin),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorC, colorD],
                          ),
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: colorBorder),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.waves,
                              color: Colors.lightBlueAccent,
                              size: 36.0,
                            ),
                            const SizedBox(width: 20),
                            Text(S.of(context).humidity(forecastInfo.humidity),
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeContainerDecoration(),
                      child: AnimatedContainer(
                        //margin: EdgeInsets.all(margin),
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorC, colorD],
                          ),
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: colorBorder),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cloud,
                              color: Colors.grey,
                              size: 36.0,
                            ),
                            const SizedBox(width: 20),
                            Text(
                                S.of(context).rain +
                                    "${forecastInfo.rain ?? "0"}%",
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeContainerDecoration(),
                      child: AnimatedContainer(
                        //margin: EdgeInsets.all(margin),
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorC, colorD],
                          ),
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: colorBorder),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.air,
                              color: Colors.white70,
                              size: 36.0,
                            ),
                            const SizedBox(width: 20),
                            Text(S.of(context).wind(forecastInfo.wind_speed),
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeContainerDecoration(),
                      child: AnimatedContainer(
                        //margin: EdgeInsets.all(margin),
                        duration: const Duration(milliseconds: 600),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorC, colorD],
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.wb_sunny,
                              color: Colors.yellow,
                              size: 36.0,
                            ),
                            const SizedBox(width: 20),
                            Text(S.of(context).uv(forecastInfo.uvi),
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}