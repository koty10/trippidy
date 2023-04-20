import 'package:flutter/material.dart';

class TrippidyTextFormField extends StatelessWidget {
  const TrippidyTextFormField({
    super.key,
    required this.controller,
    this.requiredMessage = "Pole je povinné",
    this.placeholder = "Zadejte název",
    this.focusNode,
    this.padding = 0,
    this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final String requiredMessage;
  final String placeholder;
  final FocusNode? focusNode;
  final double padding;
  final void Function()? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted != null
            ? (String? value) {
                onFieldSubmitted!();
              }
            : null,
        // The validator receives the text that the user has entered.
        focusNode: focusNode,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return requiredMessage;
          }
          return null;
        },
      ),
    );
  }
}
