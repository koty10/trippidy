import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../../components/trippidy_text_form_field.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final firstnameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final bankAccountNumberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstnameTextController.text = ref.watch(authControllerProvider).userProfile!.firstname;
    lastnameTextController.text = ref.watch(authControllerProvider).userProfile!.lastname;
    bankAccountNumberTextController.text = ref.watch(authControllerProvider).userProfile!.bankAccountNumber;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upravit profil"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TrippidyTextFormField(
              controller: firstnameTextController,
              placeholder: "Zadejte jméno",
              requiredMessage: "Jméno je povinné",
              padding: 20,
              length: 128,
            ),
            TrippidyTextFormField(
              controller: lastnameTextController,
              placeholder: "Zadejte příjmení",
              requiredMessage: "Příjmení je povinné",
              padding: 20,
              length: 128,
            ),
            TrippidyTextFormField(
              controller: bankAccountNumberTextController,
              placeholder: "Zadejte číslo účtu",
              required: false,
              padding: 20,
              length: 128,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 55,
                    vertical: 15,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: submit,
                child: const Text(
                  "Uložit",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      var userProfile = ref.read(authControllerProvider).userProfile!.copyWith(
            firstname: firstnameTextController.text.trim().capitalize(),
            lastname: lastnameTextController.text.trim().capitalize(),
            bankAccountNumber: bankAccountNumberTextController.text.trim(),
          );
      await ref.read(authControllerProvider.notifier).updateUserProfile(userProfile);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstnameTextController.dispose();
    lastnameTextController.dispose();
    super.dispose();
  }
}
