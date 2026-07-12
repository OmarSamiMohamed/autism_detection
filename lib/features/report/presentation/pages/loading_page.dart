import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/routing/app_router.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, AppRouter.report);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              painter: BarLoaderPainter(_controller.value),
              size: const Size(120, 120),
            );
          },
        ),
      ),
    );
  }
}

class BarLoaderPainter extends CustomPainter {
  final double rotationValue;

  BarLoaderPainter(this.rotationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade800
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final int barCount = 12;
    final double radius = size.width / 2;
    final double angle = 2 * math.pi / barCount;

    for (int i = 0; i < barCount; i++) {
      final double rotate = i * angle + (rotationValue * 2 * math.pi);
      final double startX = radius + (radius - 20) * math.cos(rotate);
      final double startY = radius + (radius - 20) * math.sin(rotate);
      final double endX = radius + radius * math.cos(rotate);
      final double endY = radius + radius * math.sin(rotate);

      paint.color = Colors.grey.shade800.withOpacity((i + 1) / barCount);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
