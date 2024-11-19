import 'package:adi_movie_app/repeatedfunction/buttonLogin.dart';
import 'package:adi_movie_app/repeatedfunction/loadingCircle.dart';
import 'package:adi_movie_app/repeatedfunction/textField.dart';
import 'package:adi_movie_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //Registrarse
  void register() async {
    if(pwController.text == confirmPwController.text) {
      showLoadingCircle(context);
      try {
        await _auth.registerEmailPassword(emailController.text, pwController.text);
        if (mounted) hideLoadingCircle(context);
      } catch (e) {
        if (mounted) hideLoadingCircle(context);
        if (mounted) {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Las contraseñas no coinciden"),
        ),
      );
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
          
                const SizedBox(height: 20),
                Text(
                  "Creá tu cuenta",
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
                MyTextField(
                  controller: nameController, 
                  hintText: "Nombre", 
                  obscureText: false
                ),
          
                const SizedBox(height: 10),
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

                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPwController, 
                  hintText: "Repetir contraseña", 
                  obscureText: true
                ),

                const SizedBox(height: 30),
                MyButton(
                  text: "Registrarse", 
                  onTap: register,
                ),
                
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿Ya tienes una cuenta?", 
                      style: TextStyle(
                        color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Inicia sesión",
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