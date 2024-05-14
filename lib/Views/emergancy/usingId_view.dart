import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/emergancy/showData_view.dart';
import 'package:rosheta_ui/components/shared/appbar.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/doctors/MidicalData_model.dart';
import 'package:rosheta_ui/services/patient_medical_data/get_patientData_service.dart';
import 'package:rosheta_ui/services/patient_medical_data/give_access_service.dart';

class GiveAccessUsingIdScreen extends StatelessWidget {
  GiveAccessUsingIdScreen({super.key});

  TextEditingController userIDController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: select_drawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userIDController,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.credit_card, color: Colors.cyan),
                    border: const OutlineInputBorder(),
                    labelText: S.of(context).userID,
                    labelStyle: const TextStyle(
                      color: Colors.cyan,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.red.shade900, width: 1),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).enterPatientID : null,
                ),
                MaterialButton(
                    child: Text(
                      S.of(context).SUBMIT,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        GetDataApi tmp = GetDataApi();
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent dismissing dialog by tapping outside
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text('loading...'),
                                ],
                              ),
                            );
                          },
                        );
                        try {
                          Navigator.of(context).pop(); // Close loading dialog
                          String token =
                              await tmp.getData(userIDController.text);
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        EmergencyView(token: token)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Failure, please enter valid patient national ID")),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
