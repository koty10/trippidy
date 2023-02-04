import 'package:flutter/material.dart';

class TrippidyTextFormField extends StatelessWidget {
  const TrippidyTextFormField({super.key, required this.controller, this.requiredMessage = "Pole je povinné", this.placeholder = "Zadejte název"});
  final TextEditingController controller;
  final String requiredMessage;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return requiredMessage;
          }
          return null;
        },
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          hintText: placeholder,
        ),
      ),
    );
  }
}
