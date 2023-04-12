import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/member_provider.dart';
import 'package:trippidy/screens/add_item/components/trippidy_text_form_field.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  final String currentTrip;

  const AddItemScreen({super.key, required this.currentTrip});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameTextController = TextEditingController();
  final categoryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Přidat položku"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TrippidyTextFormField(
              controller: nameTextController,
              placeholder: "Zadejte název položky",
              requiredMessage: "Název je povinný",
            ),
            TrippidyTextFormField(
              controller: categoryTextController,
              placeholder: "Zadejte název kategorie",
              requiredMessage: "Kategorie je povinná",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 55,
                        vertical: 15,
                      ),
                      foregroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Zrušit",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
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
                        "Přidat",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(memberProvider.notifier).addItem(widget.currentTrip, nameTextController.text, category: categoryTextController.text);
      if (!mounted) return; // This makes sure that you are not working with a widget after it has been disposed of
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextController.dispose();
    categoryTextController.dispose();
    super.dispose();
  }
}
