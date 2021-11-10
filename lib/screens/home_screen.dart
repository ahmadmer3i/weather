import 'dart:io';

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
          listener: (context, state) {
            if (state is WeatherSuccessState) {
              cubit.getTodayData();
              cubit.getThreeDaysData();
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: state is WeatherLoadingState ||
                        state is WeatherLocationLoadingState
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/sunny.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator(
                                    radius: 20,
                                  )
                                : const CircularProgressIndicator()),
                      )
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
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    CupertinoIcons
                                                        .location_fill,
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
                                                Flexible(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        cubit.dioData(
                                                            locationController
                                                                .text);
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.search,
                                                      color: cubit.weatherData!
                                                              .current!.isDay!
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.apartment),
                                            isDense: true,
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            errorBorder: OutlineInputBorder(
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
                                            "min: ${cubit.weatherData!.forecastData!.forecastDay![0].dayData!.minTempC!.toStringAsFixed(0)}º",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "max: ${cubit.weatherData!.forecastData!.forecastDay![0].dayData!.maxTempC!.toStringAsFixed(0)}º",
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
                                Expanded(
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Card(
                                          color: Colors.black.withOpacity(0.2),
                                          elevation: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              index == 0
                                                  ? const Text(
                                                      "now",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      DateFormat.jm().format(
                                                        cubit
                                                            .today[index].time!,
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                              Text(
                                                "${cubit.today[index].tempC!.toStringAsFixed(0)}º",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Icon(
                                                cubit.getIcon(
                                                  isDay:
                                                      cubit.today[index].isDay!,
                                                  weatherCode: cubit
                                                      .today[index]
                                                      .dayHourCondition!
                                                      .code!,
                                                ),
                                                color: Colors.white,
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
                                    itemCount: cubit.today.length,
                                  ),
                                ),
                                Card(
                                  color: Colors.black.withOpacity(0.2),
                                  elevation: 0,
                                  child: ListView.separated(
                                    itemCount: cubit.threeDays.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            index == 0
                                                ? SizedBox(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            3,
                                                    child: const Text(
                                                      "Today",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            3,
                                                    child: Text(
                                                      DateFormat.EEEE().format(
                                                        DateTime.parse(
                                                          cubit
                                                              .threeDays[index]!
                                                              .date!,
                                                        ),
                                                      ),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80) /
                                                  3,
                                              child: Center(
                                                child: Icon(
                                                  cubit.getIcon(
                                                    weatherCode: cubit
                                                        .threeDays[index]!
                                                        .dayData!
                                                        .dayCondition!
                                                        .code!,
                                                    isDay: true,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      60) /
                                                  3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${cubit.threeDays[index]!.dayData!.minTempC!.toStringAsFixed(0)}º",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "-",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${cubit.threeDays[index]!.dayData!.maxTempC!.toStringAsFixed(0)}º",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  ),
                                ),
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
