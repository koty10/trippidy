// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/components/trippidy_text_form_field.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  final Trip currentTrip;
  final bool shared;
  final bool private;

  const AddItemScreen({super.key, required this.currentTrip, this.shared = false, this.private = true});

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
  final priceTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();
  late bool _private;
  late bool _shared;

  @override
  void initState() {
    super.initState();
    _private = widget.private;
    _shared = widget.shared;
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = ref.watch(authControllerProvider).userProfile;
    final result = ref.watch(tripDetailControllerProvider).getCategoriesFromTrip(userProfileId: loggedInUser!.id);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Přidat položku"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TrippidyTextFormField(
                controller: nameTextController,
                placeholder: "Zadejte název položky",
                requiredMessage: "Název je povinný",
                padding: 20,
                onFieldSubmitted: () => submit(_shared, _private),
                length: 128,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: RawAutocomplete<String>(
                  textEditingController: categoryTextController,
                  focusNode: _focusNode,
                  key: _autocompleteKey,
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    log(textEditingValue.text);
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    log(result.where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())).toString());
                    return result.where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                    // create your custom text field here
                    log("message");

                    return TrippidyTextFormField(
                      controller: textEditingController,
                      placeholder: "Zadejte název kategorie",
                      requiredMessage: "Kategorie je povinná",
                      focusNode: focusNode,
                      onFieldSubmitted: () => submit(_shared, _private),
                      length: 128,
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    log("option");
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                        ),
                        elevation: 4.0,
                        child: SizedBox(
                          height: 54.0 * options.length,
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            shrinkWrap: false,
                            separatorBuilder: (context, i) {
                              return const Divider();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final String option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Sdílené"),
                      Switch(
                        value: _shared,
                        //activeColor: Colors.red,
                        onChanged: (bool value) {
                          setState(() {
                            _shared = value;
                            if (value) _private = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 128,
                  ),
                  Column(
                    children: [
                      const Text("Tajné"),
                      Switch(
                        value: _private,
                        //activeColor: Colors.red,
                        onChanged: _shared
                            ? null
                            : (bool value) {
                                setState(() {
                                  _private = value;
                                });
                              },
                      ),
                    ],
                  ),
                ],
              ),
              TrippidyTextFormField(
                controller: priceTextController,
                placeholder: "Zadejte cenu",
                padding: 20,
                onFieldSubmitted: () => submit(_shared, _private),
                required: false,
                keyboardType: TextInputType.number,
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
                        onPressed: () => submit(_shared, _private),
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
      ),
    );
  }

  Future<void> submit(bool shared, bool private) async {
    log("submit debug");
    log(categoryTextController.text);
    if (_formKey.currentState!.validate()) {
      await ref.read(memberControllerProvider.notifier).addItem(
            widget.currentTrip.id,
            nameTextController.text,
            category: categoryTextController.text,
            price: int.tryParse(priceTextController.text) ?? 0,
            shared: shared,
            private: private,
          );
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
