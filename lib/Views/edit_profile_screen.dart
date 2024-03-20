import 'package:flutter/material.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:rosheta_ui/Views/profile_screen.dart';
import 'package:rosheta_ui/services/edit_profile_service.dart';

class EditBasicInfoScreen extends StatefulWidget {
  final Profile user; // Define a property to hold the user object

  EditBasicInfoScreen({required this.user});
  @override
  _EditBasicInfoPageState createState() => _EditBasicInfoPageState();
}

class _EditBasicInfoPageState extends State<EditBasicInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late DateTime _dateOfBirth;
  late TextEditingController _idController;

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
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dateOfBirth) {
      setState(() {
        _dateOfBirth = pickedDate;
      });
    }
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
            icon: Icon(Icons.message),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon1 onPressed action
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon2 onPressed action
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
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
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      S.of(context).editInfor,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    S.of(context).name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextname,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    S.of(context).email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextemail,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    S.of(context).Phone,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextphonenumber,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    S.of(context).birthDate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    S.of(context).NationalId,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextID,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        EditProfileApi editrequest = new EditProfileApi();
                        bool check = await editrequest.editprofile(
                          email: _emailController.text,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          ssn: _idController.text,
                          birthdate: _dateOfBirth,
                        );
                        check = true;
                        if (check) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ProfileScreen()));
                        } else {
                          print('Failed to signup');
                        }
                      },
                      child: Text(
                        S.of(context).savechanges,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
