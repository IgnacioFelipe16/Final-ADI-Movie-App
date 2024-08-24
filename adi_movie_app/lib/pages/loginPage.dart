import 'package:adi_movie_app/repeatedfunction/buttonLogin.dart';
import 'package:adi_movie_app/repeatedfunction/textField.dart';
import 'package:adi_movie_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  //Llamada al método de iniciar sesión de auth_service
  void login() async {
    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);
    }
    catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.lock_open_rounded,
                  size: 72,
                  color: Colors.white24),
          
                const SizedBox(height: 50),
                Text(
                  "Inicia sesión",
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController, 
                  hintText: "Email", 
                  obscureText: false
                ),
          
                const SizedBox(height: 10),
                MyTextField(
                  controller: pwController, 
                  hintText: "Contraseña", 
                  obscureText: true
                ),

                const SizedBox(height: 30),
                MyButton(
                  text: "Ingresar", 
                  onTap: login,
                ),
                
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes una cuenta?", 
                      style: TextStyle(
                        color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Regístrate",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}