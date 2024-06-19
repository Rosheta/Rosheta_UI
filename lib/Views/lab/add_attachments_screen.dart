import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/components/shared/appbar.dart';
import 'package:rosheta_ui/services/lab/add_attachment_service.dart';

class AddAttachments extends StatefulWidget {
  const AddAttachments({super.key});

  @override
  _AddAttachmentsState createState() => _AddAttachmentsState();
}

class _AddAttachmentsState extends State<AddAttachments> {
  TextEditingController usernameController = TextEditingController();
  FilePickerResult? filePickerResult;
  final _formKey = GlobalKey<FormState>();
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    List<String>? tmp= _selectedFile?.path.split('/');
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _selectFile,
                    child: Text(
                      S.of(context).uploadFile,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Text(
                    _selectedFile != null
                        ? '${tmp?.last}'
                        : 'No File Selected',
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Container(
                      width: double.infinity,
                      color: Colors.cyan,
                      child: MaterialButton(
                          child: Text(
                            S.of(context).SUBMIT,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (_selectedFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please select a file to upload')),
                              );
                            }
                            if (_formKey.currentState!.validate() &&
                                _selectedFile != null) {
                              AddAttachmentApi tmp = AddAttachmentApi();
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 20),
                                        Text('Uploading...'),
                                      ],
                                    ),
                                  );
                                },
                              );
                              try {
                                String check = await tmp.addAttachment(
                                  userame: usernameController.text,
                                  selectedFile: _selectedFile!,
                                );
                                Navigator.of(context).pop();
                                if (check == 'true') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Successfully uploaded')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Not uploaded, please try again later")),
                                  );
                                }
                              } catch (e) {
                                Navigator.of(context).pop();
                              }
                            }
                          })),
                ],
              ),
            ),
          )),
    );
  }

  void _selectFile() async {
    // Open file picker to select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? '');
      setState(() {
        _selectedFile = file;
      });
    }
  }
}
