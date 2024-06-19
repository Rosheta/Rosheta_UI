import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile/profile_model.dart';
import 'package:rosheta_ui/Views/profile/profile_screen.dart';
import 'package:rosheta_ui/services/profile/edit_profile_service.dart';

class EditBasicInfoScreen extends StatefulWidget {
  final Profile user; // Define a property to hold the user object
  const EditBasicInfoScreen({super.key, required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _EditBasicInfoPageState createState() => _EditBasicInfoPageState();
}

class _EditBasicInfoPageState extends State<EditBasicInfoScreen> {
  final List<String> governments = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia',
    'Beheira',
    'Matrouh',
    'Dakahlia',
    'Kafr El-Sheikh',
    'Gharbia',
    'Menoufia',
    'Damietta',
    'Port Said',
    'Ismailia',
    'Suez',
    'Sharqia',
    'North Sinai',
    'South Sinai',
    'Fayoum',
    'Beni Suef',
    'Minya',
    'Asyut',
    'New Valley',
    'Sohag',
    'Qena',
    'Luxor',
    'Aswan',
    'Red Sea',
  ];
  final List<String> departments = [
    'Neurology',
    'Facial Plastic Surgery',
    'Dermatology',
    'Neurosurgery',
    'Otology',
    'Ophthalmology',
    'Rhinology',
    'Oral Health',
    'Cardiology',
    'Hepatology',
    'Pulmonology',
    'Gastroenterology',
    'Urology',
    'Plastic Surgery',
    'Orthopedics',
    'Gynecology'
  ];

  var nameController = TextEditingController();
  var ssnController = TextEditingController();
  var emailController = TextEditingController();
  var birthDateController = TextEditingController();
  var phoneController = TextEditingController();
  var positionController = TextEditingController();
  String selectedGovernment = "Aswan";
  String selectedDepartments = "Gynecology";
  String selectedUserGender = "m";
  late bool viewemail;
  late bool viewphone;
  late bool viewdate;
  late DateTime dateOfBirth;

  @override
  void initState() {
    super.initState();
    if (widget.user.date != '') {
      dateOfBirth = DateTime(
          int.parse(widget.user.date.substring(0, 4)),
          int.parse(widget.user.date.substring(5, 7)),
          int.parse(
              widget.user.date.substring(8, 10))); // Initial date of birth
    } else {
      dateOfBirth = DateTime(int.parse("2003"), int.parse("03"),
          int.parse("08")); // Initial date of birth
    }

    nameController = TextEditingController(text: widget.user.name);
    ssnController = TextEditingController(text: widget.user.ID);
    emailController = TextEditingController(text: widget.user.email);
    birthDateController.text =
        DateFormat('yyyy/MM/dd', 'en_US').format(dateOfBirth);
    phoneController = TextEditingController(text: widget.user.phone);
    positionController = TextEditingController(text: widget.user.location);

    widget.user.government != ""
        ? selectedGovernment = widget.user.government
        : selectedGovernment = "Aswan";

    widget.user.department != ""
        ? selectedDepartments = widget.user.department
        : selectedDepartments = "Gynecology";
    widget.user.gender != ""
        ? selectedUserGender = widget.user.gender
        : selectedUserGender = "m";

    viewemail = widget.user.viewemail;
    viewphone = widget.user.viewphone;
    viewdate = widget.user.viewdate;
  }

  @override
  void dispose() {
    nameController.dispose();
    ssnController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    positionController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    DateTime? birthdate = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (birthdate != null) {
      setState(() {
        birthDateController.text =
            DateFormat('yyyy-MM-dd', 'en_US').format(birthdate);
      });
    }
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
        ],
      ),
      drawer: select_drawer(context),
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
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hintTextname,
                    ),
                  ),
                  // Email
                  Visibility(
                    visible: widget.user.email != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).email,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextField(
                        controller: emailController,
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
                    ]),
                  ),
                  // Phone
                  Visibility(
                    visible: widget.user.phone != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).Phone,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextField(
                        controller: phoneController,
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
                    ]),
                  ),
                  // Date
                  Visibility(
                    visible: widget.user.date != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                S.of(context).birthDate,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
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
                    ]),
                  ),
                  // ID
                 
                  // Location
                  Visibility(
                    visible: widget.user.location != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).location,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextField(
                        controller: positionController,
                        decoration: InputDecoration(
                          hintText: S.of(context).hintTextphonenumber,
                        ),
                      ),
                    ]),
                  ),
                  //Government
                  Visibility(
                    visible: widget.user.government != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).government,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: selectedGovernment,
                        onChanged: (newValue) {
                          setState(() {
                            selectedGovernment = newValue.toString();
                          });
                        },
                        items: governments.map((String government) {
                          return DropdownMenuItem<String>(
                            value: government,
                            child: Text(government),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                      ),
                    ]),
                  ),

                  Visibility(
                    visible: widget.user.gender != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).gender,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: selectedUserGender,
                        onChanged: (newValue) {
                          setState(() {
                            selectedUserGender = newValue.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'm',
                            child: Text(S.of(context).male),
                          ),
                          DropdownMenuItem(
                            value: 'f', // Unique value for Doctor
                            child: Text(S.of(context).female),
                          ),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                      ),
                    ]),
                  ),

                  Visibility(
                    visible: widget.user.department != "",
                    child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            S.of(context).department,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: selectedDepartments,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDepartments = newValue.toString();
                          });
                        },
                        items: departments.map((String department) {
                          return DropdownMenuItem<String>(
                            value: department,
                            child: Text(department),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                      ),
                    ]),
                  ),

                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String dt = widget.user.date;
                        if (dt != '') {
                          setState(() {
                            dt = birthDateController.text.substring(0, 9) +
                                (int.parse(birthDateController.text[9]))
                                    .toString();
                          });
                        }
                        String gover = '';
                        String dep = '';
                        String gen = '';

                        widget.user.government != ""
                            ? gover = selectedGovernment
                            : gover = "";

                        widget.user.department != ""
                            ? dep = selectedDepartments
                            : dep = "";
                        widget.user.gender != ""
                            ? gen = selectedUserGender
                            : gen = "";

                        Profile pr = Profile(
                          profileImage: "",
                          userName: widget.user.userName,
                          name: nameController.text,
                          gender: gen,
                          government: gover,
                          email: emailController.text,
                          phone: phoneController.text,
                          date: dt,
                          ID: ssnController.text,
                          viewemail: viewemail,
                          viewphone: viewphone,
                          viewdate: viewdate,
                          department: dep,
                          location: positionController.text,
                        );
                        EditProfileApi editrequest = EditProfileApi();
                        bool check = await editrequest.editprofile(pr: pr);
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
