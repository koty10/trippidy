import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrippidyTextFormField extends StatelessWidget {
  const TrippidyTextFormField(
      {super.key,
      required this.controller,
      this.requiredMessage = "Pole je povinné",
      this.placeholder = "Zadejte název",
      this.focusNode,
      this.padding = 0,
      this.onFieldSubmitted,
      this.required = true,
      this.keyboardType,
      this.length});
  final TextEditingController controller;
  final String requiredMessage;
  final String placeholder;
  final FocusNode? focusNode;
  final double padding;
  final void Function()? onFieldSubmitted;
  final bool required;
  final TextInputType? keyboardType;
  final int? length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        maxLength: length,
        inputFormatters: keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
        keyboardType: keyboardType,
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
          if (!required && (value == null || value.isEmpty)) return null;
          if (required && (value == null || value.isEmpty)) {
            return requiredMessage;
          }
          if (keyboardType == TextInputType.number) {
            final number = int.tryParse(value!);
            if (number == null) {
              return 'Prosím zadejte číslo';
            }
          }
          return null;
        },
      ),
    );
  }
}
