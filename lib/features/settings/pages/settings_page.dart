import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:salvavidas_app/core/shared_preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String phonepipipi = 'Seleccionar fono';
  final prefs = Preferences();

  Future<void> getNewPhoneNumber() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final PhoneContact? contact = await FlutterContactPicker.pickPhoneContact();
    if (contact != null) {
      final newContact =
          contact.phoneNumber!.number!.replaceAll(RegExp(r'\D+'), '');
      final newNameContact = contact.fullName ?? "Sin Nombre";
      prefs.phoneNumbers =
          newContact.contains("591") ? ["+$newContact"] : ["+591$newContact"];
      prefs.contactsNames = [newNameContact];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      body: Column(
        children: [
          const Text(
            "Contactos para Salvavidas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: prefs.phoneNumbers.length,
              itemBuilder: (context, index) {
                final phone = prefs.phoneNumbers[index];
                final name = prefs.contactsNames[index];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .withOpacity(0.4),
                      radius: 40,
                      child: const Icon(Icons.person_4_rounded, size: 40)),
                  title: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    phone,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await prefs.deleteContact(index);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                  ),
                );
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     getNewPhoneNumber();
          //     setState(() {});
          //   },
          //   child: const Text("Agregar numero telefonico"),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[700],
        onPressed: () {
          getNewPhoneNumber();
          setState(() {});
        },
        child: const Icon(Icons.person_add_alt, size: 30, color: Colors.white),
      ),
    );
  }
}
