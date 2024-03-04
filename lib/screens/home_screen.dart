import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_cloud/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        //thunder
        return "assets/thunder.json";
      case > 300 && <= 400:
        //rain
        return "assets/rain.json";
      case > 500 && <= 600:
        //heavier rain
        return "assets/rain.json";
      case > 600 && <= 700:
        //snowing
        return "assets/rain.json";
      case > 700 && <= 800:
        //cloudy
        return "assets/cloud.json";
      case == 800:
        //sunnny
        return "assets/sunny.json";
      case > 800 && <= 804:
        //sun+cloud
        return "assets/cloud.json";
      default:
        //sun+cloud
        return "assets/cloud.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 18, 18, 18),
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Color.fromARGB(255, 18, 18, 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                if (state is WeatherBlocSuccess) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Center(
                          child: Icon(
                            Icons.location_pin,
                            color: Color.fromARGB(255, 149, 148, 148),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Center(
                          child: Text(
                            "${state.weather.areaName}".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 149, 148, 148),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Center(
                            child: Lottie.asset(
                                getWeatherIcon(
                                    state.weather.weatherConditionCode!),
                                height: 400,
                                width: 400)),
                        const SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Text(
                              "${state.weather.temperature!.celsius!.round()}°",
                              style: const TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 149, 148, 148),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
