import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                              cubit.getIcon(
                                  cubit.weatherData!.current!.condtion!.code!)!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
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
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          cubit.weatherData!.location!.name!,
                                          style: TextStyle(
                                            color: cubit.weatherData!.current!
                                                    .isDay!
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                                    ],
                                  ),
                                ),
                                Image.network(
                                  "http:${cubit.weatherData?.current!.condtion!.icon}",
                                ),
                                Text(
                                  cubit.weatherData!.current!.condtion!.text!,
                                  style: TextStyle(
                                      color: cubit.weatherData!.current!.isDay!
                                          ? Colors.black
                                          : Colors.white),
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
