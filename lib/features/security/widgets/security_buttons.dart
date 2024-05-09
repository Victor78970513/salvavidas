import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:salvavidas_app/core/shared_preferences/preferences.dart';
import 'package:salvavidas_app/features/security/provider/security_provider.dart';

class SecurityButtons extends StatelessWidget {
  const SecurityButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomSecurityButton(
          title:
              "Presiona si siente que su integridad y/o vida están en riesgo.",
          smsText:
              "¡Necesito auxilio urgente! mi vida está en riesgo, estoy en la ubicación señalada",
          path: "assets/icons/security_red.png",
        ),
        CustomSecurityButton(
          title: "Presiona si necesita ayuda.",
          smsText: "¡Necesito ayuda! estoy en la ubicación señalada",
          path: "assets/icons/security_yellow.png",
        ),
        CustomSecurityButton(
          title:
              "Presiona si está bien, en una zona de desastre natural o conflicto social.",
          smsText:
              "estoy en una zona de desastre natural o conflicto social en la ubicación señalada",
          path: "assets/icons/security_green.png",
        ),
        CustomSecurityButton(
          title: "Presiona para avisar que llegó bien a su destino.",
          smsText: "Llegué bien a destino, estoy en la ubicación señalada",
          path: "assets/icons/security_blue.png",
        ),
      ],
    );
  }
}

class CustomSecurityButton extends StatelessWidget {
  final String title;
  final String smsText;
  final String path;
  const CustomSecurityButton({
    super.key,
    required this.title,
    required this.path,
    required this.smsText,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<SecurityProvider>();
    final prefs = Preferences();
    String locationText =
        'https://www.google.com/maps?q=${homeProvider.userPosition.latitude},${homeProvider.userPosition.longitude}';

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: homeProvider.permisionIsGranted
            ? () async {
                try {
                  await sendSMS(
                      message: "$smsText: $locationText",
                      recipients: prefs.phoneNumbers,
                      sendDirect: true);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Se envio el mensaje")));
                } catch (e) {
                  log("ERRORRR: ${e.toString()}");
                }
              }
            : () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height * 0.08,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(path))),
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
