import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pulsing_border/src/pulsing_border_controller.dart';

class PulsingBorder extends StatefulWidget {
  /// The widget to be wrapped with the pulsing border.
  final Widget child;

  /// The color of the pulsing border.
  final Color color;

  /// The radius of the pulsing border.
  final double borderRadius;

  /// The final spread radius of the pulsing border.
  ///
  /// Defaults to [8].
  final double spreadRadius;

  /// The final blur radius of the pulsing border.
  ///
  /// Defaults to [1].
  final double blurRadius;

  /// The duration of the pulse.
  ///
  /// Defaults to 850ms.
  final Duration pulseDuration;

  /// The delay between pulses.
  ///
  /// Defaults to 150ms.
  final Duration pulseDelay;

  /// The controller for the pulsing border.
  ///
  /// If no controller is provided, the pulsing border will start pulsing automatically.
  final PulsingBorderController? controller;

  /// Creates a new [PulsingBorder].
  ///
  /// The [child] parameter is the widget to be wrapped with the pulsing border.
  ///
  /// The [color] parameter is the color of the pulsing border.
  ///
  /// The [borderRadius] parameter is the radius of the pulsing border.
  /// It is recommended to keep the [borderRadius] value the same as the child
  /// widget's border radius.
  ///
  /// The [controller] parameter is the controller for the pulsing border.
  ///
  /// The [spreadRadius] parameter is the final spread radius of the pulsing
  /// border. Defaults to [8].
  ///
  /// The [blurRadius] parameter is the final blur radius of the pulsing border.
  /// Defaults to [1].
  const PulsingBorder({
    super.key,
    required this.child,
    required this.color,
    required this.borderRadius,
    this.spreadRadius = 8,
    this.blurRadius = 1,
    this.pulseDuration = const Duration(milliseconds: 850),
    this.pulseDelay = const Duration(milliseconds: 150),
    this.controller,
  });

  @override
  State<PulsingBorder> createState() => _PulsingBorderState();
}

class _PulsingBorderState extends State<PulsingBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> colorOpacityAnimation;
  late Animation<double> blurRadiusAnimation;
  late Animation<double> spreadRadiusAnimation;
  late double borderRadius;
  late Duration pulseDuration;
  late Duration pulseDelay;
  bool _isAnimating = false;
  late PulsingBorderController controller;

  @override
  void initState() {
    super.initState();

    controller =
        widget.controller ?? (PulsingBorderController()..startPulsing());

    pulseDuration = widget.pulseDuration;

    pulseDelay = widget.pulseDelay;

    borderRadius = widget.borderRadius + (widget.spreadRadius / 2);
    animationController = AnimationController(
      vsync: this,
      duration: pulseDuration,
    );

    colorOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    spreadRadiusAnimation = Tween<double>(begin: 0, end: widget.spreadRadius)
        .animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 0.75, curve: Curves.easeOut),
          ),
        );

    blurRadiusAnimation = Tween<double>(begin: 0, end: widget.blurRadius)
        .animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 0.75, curve: Curves.easeOut),
          ),
        );

    controller.addListener(_onControllerChanged);

    if (controller.value) {
      _startRepeatingAnimation();
    }
  }

  void _onControllerChanged() {
    if (controller.value && !_isAnimating) {
      _startRepeatingAnimation();
    } else if (!controller.value && _isAnimating) {
      _stopRepeatingAnimation();
    }
  }

  void _startRepeatingAnimation() {
    _isAnimating = true;
    animationController.forward().then((_) {
      Future.delayed(pulseDelay, () {
        if (mounted && controller.value) {
          animationController.reset();
          _startRepeatingAnimation();
        } else {
          _isAnimating = false;
        }
      });
    });
  }

  void _stopRepeatingAnimation() {
    _isAnimating = false;
    animationController.stop();
    animationController.reset();
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PulsingBorder oldWidget) {
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_onControllerChanged);
      controller =
          widget.controller ?? (PulsingBorderController()..startPulsing());
      controller.addListener(_onControllerChanged);
    }
    if (oldWidget.borderRadius != widget.borderRadius ||
        oldWidget.spreadRadius != widget.spreadRadius) {
      borderRadius = widget.borderRadius + (widget.spreadRadius / 2);
    }

    if (oldWidget.spreadRadius != widget.spreadRadius) {
      spreadRadiusAnimation = Tween<double>(begin: 0, end: widget.spreadRadius)
          .animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval(0, 0.75, curve: Curves.easeOut),
            ),
          );
    }

    if (oldWidget.blurRadius != widget.blurRadius) {
      blurRadiusAnimation = Tween<double>(begin: 0, end: widget.blurRadius)
          .animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval(0, 0.75, curve: Curves.easeOut),
            ),
          );
    }
    if (oldWidget.pulseDuration != widget.pulseDuration) {
      pulseDuration = widget.pulseDuration;
      animationController.duration = pulseDuration;
    }

    if (oldWidget.pulseDelay != widget.pulseDelay) {
      pulseDelay = widget.pulseDelay;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        colorOpacityAnimation,
        spreadRadiusAnimation,
      ]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(
                  alpha: 1.0 - colorOpacityAnimation.value,
                ),
                spreadRadius: spreadRadiusAnimation.value,
                blurRadius: blurRadiusAnimation.value,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
