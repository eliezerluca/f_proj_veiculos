import 'package:flutter/material.dart';
import 'package:proj_veiculos/ui/core/themes/app_theme.dart';

class CustomInput extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final Color? inputColor; // Nova propriedade para configurar a cor

  const CustomInput({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.inputColor =
        AppTheme.lightPrimaryColor, // Inicializa a nova propriedade
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured =
        widget.isPassword; // Inicializa com base no parâmetro isPassword
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.inputColor,
        ), // Define a cor do label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.inputColor ?? Colors.grey,
          ), // Define a cor da borda
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.inputColor ?? Colors.blue,
          ), // Cor ao focar
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: widget.inputColor, // Define a cor do ícone
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured; // Alterna entre mostrar/ocultar
                  });
                },
              )
            : null,
      ),
      style: TextStyle(color: widget.inputColor), // Define a cor do texto
    );
  }
}
