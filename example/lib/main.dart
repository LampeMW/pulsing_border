import 'package:example/pulsing_border_controls.dart';
import 'package:flutter/material.dart';
import 'package:pulsing_border/pulsing_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              PulsingBorderControls(
                spreadRadius: spreadRadius,
                blurRadius: blurRadius,
                borderRadius: borderRadius,
                pulseDuration: pulseDuration,
                delayBetweenPulses: delayBetweenPulses,
                onSpreadRadiusChanged: (value) {
                  setState(() {
                    spreadRadius = value;
                  });
                },
                onBlurRadiusChanged: (value) {
                  setState(() {
                    blurRadius = value;
                  });
                },
                onBorderRadiusChanged: (value) {
                  setState(() {
                    borderRadius = value;
                  });
                },
                onPulseDurationChanged: (value) {
                  setState(() {
                    pulseDuration = value;
                  });
                },
                onDelayBetweenPulsesChanged: (value) {
                  setState(() {
                    delayBetweenPulses = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
