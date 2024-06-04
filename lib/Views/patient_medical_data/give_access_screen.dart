import 'package:flutter/material.dart';
import 'package:rosheta_ui/components/shared/appbar.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/patient_medical_data/user_model.dart';
import 'package:rosheta_ui/services/patient_medical_data/give_access_service.dart';

class GiveAccessScreen extends StatelessWidget {
  GiveAccessScreen({super.key});

  TextEditingController usernameController = TextEditingController();
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
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.cyan),
                    border: const OutlineInputBorder(),
                    labelText: S.of(context).username,
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
                      value!.isEmpty ? S.of(context).enterYourName : null,
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
                        GiveAccessApi tmp = GiveAccessApi();
                        User data = await tmp.getUser(usernameController.text);
                        if (data.flag == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Successfully giving access to the user')),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failure, please try again later")),
                          );
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 600,
                                    child: Column(
                                      children: [
                                        Text(S.of(context).giveaccess),
                                        Image.network(data.profileImage),
                                        const SizedBox(height: 10),
                                        Text(data.name),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                try {
                                                  bool check =
                                                      await tmp.giveAccess(
                                                          usernameController
                                                              .text);
                                                  if (check) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Successfully giving access to the user')),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              "Failure, please try again later")),
                                                    );
                                                  }
                                                } catch (e) {}
                                              },
                                              child: Text(S.of(context).Yes),
                                            ),
                                            const SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(S.of(context).No),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        
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
