import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

showMessageError({
  required BuildContext context,
  required dynamic error,
  required String defaultActionText,
  bool onlyDefault = false,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  if (error.runtimeType == DioError &&
      !onlyDefault &&
      (error as DioError).response != null) {
    switch ((error).response!.statusCode.toString()) {
      case "401":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuário não autorizado."),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case "400":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Operação inválida."),
            backgroundColor: Colors.red,
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red,
          ),
        );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(defaultActionText),
        backgroundColor: Colors.red,
      ),
    );
  }
}
