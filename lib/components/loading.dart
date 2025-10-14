import 'package:flutter/material.dart';
import 'dart:math' as math;

class MultiCircleLoader extends StatefulWidget {
  const MultiCircleLoader({super.key});

  @override
  State<MultiCircleLoader> createState() => _MultiCircleLoaderState();
}

class _MultiCircleLoaderState extends State<MultiCircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi + (index * math.pi / 4),
              child: child,
            );
          },
          child: CustomPaint(
            size: const Size(48, 48),
            painter: CircleLoaderPainter(),
          ),
        );
      }),
    );
  }
}

class SingleCircleLoader extends StatefulWidget {
  final double size;

  const SingleCircleLoader({Key? key, this.size = 100}) : super(key: key);

  @override
  State<SingleCircleLoader> createState() => _SingleCircleLoaderState();
}

class _SingleCircleLoaderState extends State<SingleCircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: CircleLoaderPainter(),
          ),
        );
      },
    );
  }
}

class CircleLoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.12;

    // Blue arc
    final bluePaint = Paint()
      ..color = const Color(0xFF00A7E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      math.pi * 1.5,
      false,
      bluePaint,
    );

    // Green arc
    final greenPaint = Paint()
      ..color = const Color(0xFF8DC63F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      math.pi,
      math.pi * 0.5,
      false,
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
