import 'package:clima_certo_639/constants.dart';
import 'package:clima_certo_639/src/core/widgets/weather_item.dart';
import 'package:clima_certo_639/src/modules/home/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Constants myConstants = Constants();
  late final HomeStore _homeStore;

  String currentDate = 'Carregando...';
  String imageUrl = '';

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF3F51B5), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();

    _homeStore = Modular.get<HomeStore>();
    _homeStore.fetchWeatherData();

    reaction((_) => _homeStore.hasError, (bool hasError) {
      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(_homeStore.errorMessage),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    currentDate = DateFormat('E, d MMMM', 'pt_BR').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(size),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Observer(builder: (_) {
          if (_homeStore.weatherData == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/app/pin.png',
                      width: 20,
                      color: myConstants.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _homeStore.weatherData!.results.city,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                tempCard(size),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      weatherItem(
                        text: 'Vento',
                        value:
                            _homeStore.weatherData?.results.windSpeedy ?? "0",
                        unit: 'km/h',
                        imageUrl: 'assets/app/windspeed.png',
                      ),
                      weatherItem(
                          text: 'Umidade',
                          value: _homeStore.weatherData!.results.humidity
                              .toString(),
                          unit: '',
                          imageUrl: 'assets/app/humidity.png'),
                      weatherItem(
                        text: 'Temp. Máx',
                        value: _homeStore
                                .weatherData?.results.forecast.first.max
                                .toString() ??
                            "0",
                        unit: 'C',
                        imageUrl: 'assets/app/max-temp.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Próximos 7 Dias',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }
        }),
      ),
    );
  }

  appBar(Size size) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/app/profile.png',
                width: 40,
                height: 40,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  tempCard(Size size) {
    return Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(
          color: myConstants.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: myConstants.primaryColor.withOpacity(.5),
              offset: const Offset(0, 25),
              blurRadius: 10,
              spreadRadius: -12,
            )
          ]),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              _homeStore.weatherData!.results.currently.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _homeStore.weatherData!.results.temp.toString(),
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient,
                    ),
                  ),
                ),
                Text(
                  'o',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
