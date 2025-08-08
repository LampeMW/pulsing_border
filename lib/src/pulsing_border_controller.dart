import 'package:flutter/widgets.dart';

class PulsingBorderController extends ValueNotifier<bool> {
  /// Creates a new [PulsingBorderController].
  ///
  /// The [isPulsing] parameter is used to set the initial state of the controller.
  ///
  /// Defaults to [false].
  PulsingBorderController({bool isPulsing = false}) : super(isPulsing);

  /// Gets the current pulsing state.
  bool get isPulsing => value;

  /// Starts the pulsing animation.
  void startPulsing() {
    value = true;
  }

  /// Stops the pulsing animation.
  void stopPulsing() {
    value = false;
  }

  /// Toggles the pulsing animation.
  void togglePulsing() {
    value = !value;
  }
}
