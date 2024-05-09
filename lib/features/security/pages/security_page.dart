import 'package:flutter/material.dart';
import 'package:salvavidas_app/features/security/widgets/map_widget.dart';
import 'package:salvavidas_app/features/security/widgets/security_buttons.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/header_banner.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.3,
            child: const MapWidget(),
          ),
          const SecurityButtons(),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 40;

    final path = Path();

    path.moveTo(size.width * 0.6, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0.5, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}
