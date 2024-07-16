import 'package:flutter/material.dart';
import 'package:myapp/usar_correo.dart'; // Importa la pantalla de login

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrate en TikTok',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Gestiona tu cuenta, lee notificaciones, comenta sobre videos y más.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),
            IntrinsicHeight(
              child: Column(
                children: [
                  LoginButton(
                    icon: Icons.qr_code,
                    text: 'Usar código QR',
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  LoginButton(
                    icon: Icons.person,
                    text: 'Usar teléfono/correo/nombre de usuario',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginCorreo(), // Navega a la nueva pantalla
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  LoginButton(
                    icon: Icons.facebook,
                    text: 'Continuar con Facebook',
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  LoginButton(
                    icon: Icons.g_translate,
                    text: 'Continuar con Google',
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  LoginButton(
                    icon: Icons.alternate_email,
                    text: 'Continuar con Twitter',
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  LoginButton(
                    icon: Icons.apple,
                    text: 'Continuar con Apple',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¿No tienes cuenta?'),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const LoginButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(icon, size: 24, color: Colors.black),
      label: Text(text, style: TextStyle(color: Colors.black)),
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        side: BorderSide(color: Colors.black),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
