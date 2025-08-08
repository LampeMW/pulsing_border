import 'package:flutter/material.dart';
import 'package:pulsing_border/pulsing_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulsing Border Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final PulsingBorderController controller = PulsingBorderController(
    isPulsing: true,
  );

  double spreadRadius = 8;
  double blurRadius = 1;
  double borderRadius = 8;
  Duration pulseDuration = Duration(milliseconds: 850);
  Duration delayBetweenPulses = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: PulsingBorder(
                  color: Colors.lightBlueAccent,
                  borderRadius: borderRadius,
                  controller: controller,
                  spreadRadius: spreadRadius,
                  blurRadius: blurRadius,
                  pulseDuration: pulseDuration,
                  pulseDelay: delayBetweenPulses,
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        controller.togglePulsing();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ValueListenableBuilder(
                              valueListenable: controller,
                              builder: (context, isPulsing, child) {
                                return Text(
                                  // isPulsing ? 'Stop Pulsing' : 'Start Pulsing',
                                  'Pulsing Border',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Text(
                      'Spread Radius: ${spreadRadius.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: spreadRadius,
                      min: 1,
                      max: 20,
                      onChanged: (value) {
                        setState(() {
                          spreadRadius = value;
                        });
                      },
                    ),

                    Text(
                      'Blur Radius: ${blurRadius.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: blurRadius,
                      min: 0.1,
                      max: 5,
                      onChanged: (value) {
                        setState(() {
                          blurRadius = value;
                        });
                      },
                    ),
                    Text(
                      'Border radius: ${borderRadius.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: borderRadius,
                      min: 0,
                      max: 25,
                      onChanged: (value) {
                        setState(() {
                          borderRadius = value;
                        });
                      },
                    ),
                    Text(
                      'Pulse duration: ${pulseDuration.inMilliseconds.toInt()} milliseconds',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: pulseDuration.inMilliseconds.toDouble(),
                      min: 0,
                      max: 3000,
                      onChanged: (value) {
                        setState(() {
                          pulseDuration = Duration(milliseconds: value.toInt());
                        });
                      },
                    ),
                    Text(
                      'Delay between pulses: ${delayBetweenPulses.inMilliseconds.toInt()} milliseconds',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: delayBetweenPulses.inMilliseconds.toDouble(),
                      min: 0,
                      max: 3000,
                      onChanged: (value) {
                        setState(() {
                          delayBetweenPulses = Duration(
                            milliseconds: value.toInt(),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
