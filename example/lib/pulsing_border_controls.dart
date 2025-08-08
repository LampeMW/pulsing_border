import 'package:flutter/material.dart';

class PulsingBorderControls extends StatelessWidget {
  final double spreadRadius;
  final double blurRadius;
  final double borderRadius;
  final Duration pulseDuration;
  final Duration delayBetweenPulses;
  final ValueChanged<double> onSpreadRadiusChanged;
  final ValueChanged<double> onBlurRadiusChanged;
  final ValueChanged<double> onBorderRadiusChanged;
  final ValueChanged<Duration> onPulseDurationChanged;
  final ValueChanged<Duration> onDelayBetweenPulsesChanged;

  const PulsingBorderControls({
    super.key,
    required this.spreadRadius,
    required this.blurRadius,
    required this.borderRadius,
    required this.pulseDuration,
    required this.delayBetweenPulses,
    required this.onSpreadRadiusChanged,
    required this.onBlurRadiusChanged,
    required this.onBorderRadiusChanged,
    required this.onPulseDurationChanged,
    required this.onDelayBetweenPulsesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onChanged: onSpreadRadiusChanged,
          ),
          Text(
            'Blur Radius: ${blurRadius.toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: blurRadius,
            min: 0.1,
            max: 5,
            onChanged: onBlurRadiusChanged,
          ),
          Text(
            'Border radius: ${borderRadius.toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.white),
          ),
          Slider(
            value: borderRadius,
            min: 0,
            max: 25,
            onChanged: onBorderRadiusChanged,
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
              onPulseDurationChanged(Duration(milliseconds: value.toInt()));
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
              onDelayBetweenPulsesChanged(
                Duration(milliseconds: value.toInt()),
              );
            },
          ),
        ],
      ),
    );
  }
}
