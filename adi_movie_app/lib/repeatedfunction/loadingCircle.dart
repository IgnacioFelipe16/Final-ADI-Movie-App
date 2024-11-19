import 'package:flutter/material.dart';

//Mostrar círculo de carga
void showLoadingCircle(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

//Ocultar círculo de carga
void hideLoadingCircle(BuildContext context) {
  Navigator.pop(context);
}