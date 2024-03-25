import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/Views/friends_screen.dart';
import 'package:rosheta_ui/Views/search_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:rosheta_ui/Views/profile_screen.dart';
import 'package:rosheta_ui/services/edit_profile_service.dart';

class EditBasicInfoScreen extends StatefulWidget {
  final Profile user; // Define a property to hold the user object
  const EditBasicInfoScreen({super.key, required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _EditBasicInfoPageState createState() => _EditBasicInfoPageState();
}

class _EditBasicInfoPageState extends State<EditBasicInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late DateTime _dateOfBirth;
  late TextEditingController _idController;
  late bool viewemail;
  late bool viewphone;
  late bool viewdate;
  late bool viewID;
  late TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.userName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _dateOfBirth = DateTime(
        int.parse(widget.user.date.substring(0, 4)),
        int.parse(widget.user.date.substring(5, 7)),
        int.parse(widget.user.date.substring(8, 10))); // Initial date of birth
    _idController = TextEditingController(text: widget.user.ID);
    viewemail = widget.user.viewemail;
    viewphone = widget.user.viewphone;
    viewdate = widget.user.viewdate;
    viewID = widget.user.viewID;
    birthDateController.text = DateFormat('yyyy/MM/dd').format(_dateOfBirth);
    print(birthDateController);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    DateTime? birthdate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (birthdate != null) {
      setState(() {
        birthDateController.text = DateFormat('yyyy/MM/dd').format(birthdate);
      });
    }
  }

  Icon getViewIDIcon() {
    if (viewID) return const Icon(Icons.visibility);
    return const Icon(Icons.visibility_off);
  }

  Icon getViewPhoneIcon() {
    if (viewphone) return const Icon(Icons.visibility);
    return const Icon(Icons.visibility_off);
  }

  Icon getViewDateIcon() {
    if (viewdate) return const Icon(Icons.visibility);
    return const Icon(Icons.visibility_off);
  }

  Icon getViewEmailIcon() {
    if (viewemail) return const Icon(Icons.visibility);
    return const Icon(Icons.visibility_off);
  }

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
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon3 onPressed action
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 255, 255),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      S.of(context).editInfor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    S.of(context).name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextname,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    S.of(context).email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextemail,
                      suffix: IconButton(
                        icon:
                            getViewEmailIcon(), // You can replace with any desired icon
                        onPressed: () {
                          setState(() {
                            viewemail = !viewemail;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    S.of(context).Phone,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextphonenumber,
                      suffix: IconButton(
                        icon:
                            getViewPhoneIcon(), // You can replace with any desired icon
                        onPressed: () {
                          setState(() {
                            viewphone = !viewphone;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    S.of(context).birthDate,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller:
                        birthDateController, // Use the birthDateController
                    readOnly: true, // Make the field read-only

                    onTap: () => _datePicker(),
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon:
                            getViewDateIcon(), // You can replace with any desired icon
                        onPressed: () {
                          setState(() {
                            viewdate = !viewdate;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    S.of(context).NationalId,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextID,
                      suffix: IconButton(
                        icon:
                            getViewIDIcon(), // You can replace with any desired icon
                        onPressed: () {
                          setState(() {
                            viewID = !viewID;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        EditProfileApi editrequest = EditProfileApi();
                        bool check = await editrequest.editprofile(
                          email: _emailController.text,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          ssn: _idController.text,
                          birthdate: birthDateController.text.substring(0, 9) +
                              (int.parse(birthDateController.text[9]) + 1)
                                  .toString(),
                          viewdate: viewdate,
                          viewID: viewID,
                          viewemail: viewemail,
                          viewphone: viewphone,
                        );
                        // check = true;
                        if (check) {
                          Navigator.pushReplacement(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const ProfileScreen()));
                        }
                      },
                      child: Text(
                        S.of(context).savechanges,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text(' We serve you with tender , care and love '),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
