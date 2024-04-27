import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.message),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const FriendsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: SearchPeople());
            },
          ),
        ],
      ),
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
                    validator: (value) => value!.isEmpty
                        ? S.of(context).enterYourName
                        : null,
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
                        ? '${_selectedFile?.path}'
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
                            if (_formKey.currentState!.validate() && _selectedFile != null) {
                                AddAttachmentApi tmp = AddAttachmentApi();
                                // Show loading indicator
                                showDialog(
                                  context: context,
                                  barrierDismissible: false, // Prevent dismissing dialog by tapping outside
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
                                  String check = await tmp.Addattachment(
                                    userame: usernameController.text,
                                    selectedFile: _selectedFile!,
                                  );
                                  Navigator.of(context).pop(); // Close loading dialog
                                  if (check != 'false') {
                                    // If the form is valid and attachment added successfully
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Successfully uploaded')),
                                    );
                                  }
                                } catch (e) {
                                  Navigator.of(context).pop(); // Close loading dialog
                                  // Handle error, maybe show an error message
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
