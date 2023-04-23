import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/auth_controller.dart';
import '../../providers/trips_controller.dart';

class AddTripScreen extends ConsumerStatefulWidget {
  const AddTripScreen({super.key});

  @override
  ConsumerState<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends ConsumerState<AddTripScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final tripNameTextController = TextEditingController();
  DateTimeRange? _dateRange;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    tripNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Přidat výlet"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Název je povinný';
                  }
                  return null;
                },
                controller: tripNameTextController,
                autofocus: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  hintText: 'Zadejte název výletu',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                title: Text(
                  formatDate(_dateRange) ?? 'Zadejte termín',
                  style: const TextStyle(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                shape: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple[200]!,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                trailing: _dateRange == null
                    ? const Icon(Icons.chevron_right)
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _dateRange = null;
                          });
                        },
                        icon: const Icon(Icons.close_sharp),
                      ),
                onTap: () async {
                  DateTimeRange? dateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    _dateRange = dateRange;
                  });
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
                      child: const Text(
                        "Přidat",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(tripsControllerProvider.notifier).addTripForUser(
                                context: context,
                                name: tripNameTextController.text,
                                userId: ref.read(authControllerProvider.notifier).getUserId()!,
                                dateFrom: _dateRange?.start,
                                dateTo: _dateRange?.end,
                              );
                        }
                      },
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

  String? formatDate(DateTimeRange? range) {
    if (range == null) return null;
    return '${DateFormat('dd. MM. yyyy').format(range.start)} - ${DateFormat('dd. MM. yyyy').format(range.end)} ';
  }
}
