import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCode extends StatelessWidget {
  const TextFieldCode({
    Key? key,
    required this.codeController,
    required this.txtIsEmpty,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController codeController;
  final bool txtIsEmpty;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 125),
      child: TextField(
        controller: codeController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: txtIsEmpty ? 'Debe ingresar el código' : null,
        ),
      ),
    );
  }
}
