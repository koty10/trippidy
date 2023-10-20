import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/dto/user_profile.dart';
import 'package:trippidy/providers/queried_user_profiles_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

import '../../providers/selected_queried_user_profile_provider.dart';

class AddMemberScreen extends ConsumerStatefulWidget {
  const AddMemberScreen({super.key});

  @override
  ConsumerState<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends ConsumerState<AddMemberScreen> {
  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  static String _displayStringForOption(UserProfile option) => "${option.firstname} ${option.lastname}";

  @override
  Widget build(BuildContext context) {
    var selectedUserProfile = ref.watch(selectedQueriedUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Add member"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Autocomplete<UserProfile>(
                displayStringForOption: _displayStringForOption,
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text == '') {
                    return const Iterable<UserProfile>.empty();
                  }
                  final result = await ref.watch(queriedUserProfilesProviderProvider(textEditingValue.text, ref.read(tripDetailControllerProvider).id).future);
                  return result;
                },
                onSelected: (UserProfile selection) {
                  ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => selection);
                  log('User just selected ${_displayStringForOption(selection)}');
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    onChanged: (text) {
                      // set null while typing
                      ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => null);
                    },
                    controller: textEditingController,
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: "Find user",
                    ),
                  );
                },
                optionsViewBuilder: (context, onSelected, options) => Align(
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
                          final UserProfile option = options.elementAt(index);
                          return InkWell(
                            onTap: () => onSelected(option),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${option.firstname} ${option.lastname}"),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
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
                      "Cancel",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => null);
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
                      onPressed: selectedUserProfile == null ? null : submit,
                      child: const Text(
                        "Add",
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
      await ref.read(tripDetailControllerProvider.notifier).addMember(
            ref.read(selectedQueriedUserProfileProvider)?.id ?? "",
          );
      ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => null);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
