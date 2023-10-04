// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/components/trippidy_text_form_field.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/future_transaction.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:trippidy/extensions/build_context_extension.dart';

import '../../model/item.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  final Trip currentTrip;
  final bool shared;
  final bool private;
  final Item? item;

  const AddItemScreen({super.key, required this.currentTrip, this.shared = false, this.private = true, this.item});

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
  Item? item;
  late List<FutureTransaction> futureTransactions;
  final newItemId = const Uuid().v4();
  late Iterable<String> result;

  @override
  void initState() {
    super.initState();
    _private = widget.private;
    _shared = widget.shared;
    if (widget.item != null) {
      _private = widget.item!.isPrivate;
      _shared = widget.item!.isShared;
      categoryTextController.text = widget.item!.categoryName;
      nameTextController.text = widget.item!.name;
      if (widget.item!.price != 0) priceTextController.text = widget.item!.price.toString();
      item = widget.item;
      futureTransactions = item!.futureTransactions;
    } else {
      futureTransactions = ref
          .read(tripDetailControllerProvider)
          .members
          .map(
            (m) => FutureTransaction(id: const Uuid().v4(), payerId: m.id, itemId: newItemId),
          )
          .toList();
    }
    final loggedInUser = ref.read(authControllerProvider).userProfile;
    result = ref.read(tripDetailControllerProvider).getCategoriesFromTrip(userProfileId: loggedInUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(tripDetailControllerProvider).members;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: item == null ? const Text("Přidat položku") : const Text("Upravit položku"),
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
                onFieldSubmitted: () => submit(),
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
                      onFieldSubmitted: () => submit(),
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
                          height: 50.0 * (options.length > 8 ? 8 : options.length),
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
                                  padding: const EdgeInsets.all(8.0),
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
                onFieldSubmitted: () => submit(),
                required: false,
                keyboardType: TextInputType.number,
              ),
              Wrap(
                spacing: 12.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: members.map((Member member) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              if (futureTransactions.any((element) => element.payerId == member.id)) {
                                futureTransactions = futureTransactions.where((element) => element.payerId != member.id).toList();
                              } else {
                                futureTransactions =
                                    futureTransactions + [FutureTransaction(id: const Uuid().v4(), itemId: item?.id ?? newItemId, payerId: member.id)];
                              }
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                member.userProfileImage!,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            if (futureTransactions.any((element) => element.payerId == member.id))
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.onPrimaryContainer,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.colorScheme.primaryContainer,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(Icons.check, color: context.colorScheme.primaryContainer, size: 12),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        "${member.userProfileFirstname} ${member.userProfileLastname.characters.first}.",
                        style: context.txtTheme.bodySmall,
                      ),
                    ],
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
                        onPressed: () => submit(),
                        child: Text(
                          item == null ? "Přidat" : "Uložit",
                          style: const TextStyle(fontSize: 16),
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

  Future<void> submit() async {
    log("submit debug");
    if (_formKey.currentState!.validate()) {
      if (item == null) {
        await ref.read(memberControllerProvider.notifier).addItem(
              newItemId,
              widget.currentTrip.id,
              nameTextController.text,
              category: categoryTextController.text,
              price: int.tryParse(priceTextController.text) ?? 0,
              shared: _shared,
              private: _private,
              futureTransactions: futureTransactions,
            );
      } else {
        item!.name = nameTextController.text;
        item!.categoryName = categoryTextController.text;
        item!.isPrivate = _private;
        item!.isShared = _shared;
        item!.price = int.tryParse(priceTextController.text) ?? 0;
        item!.futureTransactions = futureTransactions;
        await ref.read(memberControllerProvider.notifier).updateItem(
              widget.currentTrip.id,
              item!,
            );
      }

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
