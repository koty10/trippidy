import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/user_profile.dart';
import 'package:trippidy/providers/queried_user_profiles_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

import '../../providers/selected_queried_user_profile_provider.dart';

class AddMemberScreen extends ConsumerStatefulWidget {
  const AddMemberScreen({super.key});

  @override
  ConsumerState<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends ConsumerState<AddMemberScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.addListener(() {
      ref.read(queriedUserProfilesProviderProvider(textController.text));
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  static String _displayStringForOption(UserProfile option) => option.firstname;

  static final List<UserProfile> _userOptions = <UserProfile>[
    UserProfile(firstname: "aaa", id: "", image: "", lastname: "bbb", members: []),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedUserProfile = ref.watch(selectedQueriedUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Přidat uživatele"),
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
                optionsBuilder: (TextEditingValue textEditingValue) {
                  
                  if (textEditingValue.text == '') {
                    return const Iterable<UserProfile>.empty();
                  }
                  return _userOptions.where((UserProfile option) {
                    return option.toString().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (UserProfile selection) {
                  ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => selection);
                  log('You just selected ${_displayStringForOption(selection)}');
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  // create your custom text field here
                  return TextField(
                    onChanged: (text) {
                      // call your method here, passing in the new text value
                      // set null while typing
                      ref.read(selectedQueriedUserProfileProvider.notifier).update((state) => null);
                    },
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (value) {
                      // handle the submitted value here
                      null;
                    },
                  );
                },
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
                      onPressed: selectedUserProfile == null
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await ref.read(tripDetailControllerProvider.notifier).addMember(
                                      textController.text, // TODO pass userId
                                    );
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            },
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
}
