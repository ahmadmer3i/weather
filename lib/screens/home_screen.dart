import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/view_model/cubit/weather_cubit.dart';

class HomeScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var cubit = WeatherCubit.get(context);
        return BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: state is WeatherLoadingState ||
                        state is WeatherLocationLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              cubit.getImage(cubit
                                  .weatherData!.current!.condition!.code!)!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          style: TextStyle(
                                            color: cubit.weatherData!.current!
                                                    .isDay!
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          onFieldSubmitted: (value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.dioData(value);
                                            }
                                          },
                                          onTap: () {
                                            locationController.clear();
                                          },
                                          controller: locationController,
                                          validator: (message) {
                                            if (locationController
                                                .text.isEmpty) {
                                              return "* Please type your city name";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                CupertinoIcons.location_fill,
                                                color: cubit.weatherData!
                                                        .current!.isDay!
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              onPressed: () {
                                                cubit.dioData(
                                                    "${cubit.position!.latitude},${cubit.position!.longitude}");
                                              },
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.apartment),
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintStyle: TextStyle(
                                                color: cubit.weatherData!
                                                        .current!.isDay!
                                                    ? Colors.black
                                                        .withOpacity(0.4)
                                                    : Colors.white
                                                        .withOpacity(0.4)),
                                            hintText: "City Name",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit
                                              .dioData(locationController.text);
                                        }
                                      },
                                      child: const Text("Search"),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        cubit.weatherData!.location!.name!,
                                        style: TextStyle(
                                          color:
                                              cubit.weatherData!.current!.isDay!
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${cubit.weatherData!.current!.tempC!.toStringAsFixed(0)}º",
                                        style: TextStyle(
                                          color:
                                              cubit.weatherData!.current!.isDay!
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "min: ${cubit.weatherData!.forecastData!.forecastDay![0].dayData!.minTempC}º",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "max: ${cubit.weatherData!.forecastData!.forecastDay![0].dayData!.maxTempC}º",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Icon(
                                    cubit.getIcon(
                                      isDay: cubit.weatherData!.current!.isDay!,
                                      weatherCode: cubit.weatherData!.current!
                                          .condition!.code!,
                                    ),
                                    color: cubit.weatherData!.current!.isDay!
                                        ? Colors.black
                                        : Colors.white,
                                    size: 100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    cubit
                                        .weatherData!.current!.condition!.text!,
                                    style: TextStyle(
                                      color: cubit.weatherData!.current!.isDay!
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Card(
                                          color: Colors.white.withOpacity(0.04),
                                          elevation: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              index == 0
                                                  ? Text(
                                                      "now",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: cubit
                                                                  .weatherData!
                                                                  .current!
                                                                  .isDay!
                                                              ? Colors.black
                                                              : Colors.white),
                                                    )
                                                  : Text(
                                                      DateFormat.jm().format(
                                                        cubit
                                                            .getTodayData()[
                                                                index]
                                                            .time!,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: cubit
                                                                .weatherData!
                                                                .current!
                                                                .isDay!
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                              Text(
                                                cubit
                                                    .getTodayData()[index]
                                                    .tempC!
                                                    .toStringAsFixed(0),
                                                style: TextStyle(
                                                  color: cubit.weatherData!
                                                          .current!.isDay!
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                              Icon(
                                                cubit.getIcon(
                                                  isDay: cubit
                                                      .getTodayData()[index]
                                                      .isDay!,
                                                  weatherCode: cubit
                                                      .getTodayData()[index]
                                                      .dayHourCondition!
                                                      .code!,
                                                ),
                                                color: cubit.weatherData!
                                                        .current!.isDay!
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 2,
                                    ),
                                    itemCount: cubit.getTodayData().length,
                                  ),
                                ),
                                Card(
                                    child: ListView.separated(
                                  itemCount: cubit.getThreeDaysData().length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    print(cubit.getThreeDaysData().length);
                                    return Row(
                                      children: [
                                        index == 0
                                            ? const Text("Today")
                                            : Text(DateFormat.EEEE().format(
                                                DateTime.parse(cubit
                                                    .getThreeDaysData()[index]!
                                                    .date!))),
                                        Text(cubit
                                            .getThreeDaysData()[index]!
                                            .dayData!
                                            .minTempC!
                                            .toStringAsFixed(0))
                                      ],
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
