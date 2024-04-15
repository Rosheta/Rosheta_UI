import 'package:flutter/material.dart';
import 'package:rosheta_ui/services/search_service.dart';
// import 'package:provider/provider.dart';

// import 'package:rosheta_ui/Views/profile_screen.dart';



class searchWidget extends StatefulWidget {
  const searchWidget({Key? key}) : super(key: key);

  @override
  State<searchWidget> createState() => _searchWidgetState();
}

class _searchWidgetState extends State<searchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rosheta",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: SearchPeople()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

// class SearchData extends ChangeNotifier {
//   String selectedSpecialization = 'Any';
//   String selectedHospital = 'Any';

//   void setSpecialization(String specialization) {
//     selectedSpecialization = specialization;
//     notifyListeners(); // Notify listeners of the change
//   }

//   void setHospital(String hospital) {
//     selectedHospital = hospital;
//     notifyListeners(); // Notify listeners of the change
//   }
// }

class SearchPeople extends SearchDelegate<String>{
  String selectedUserId = "";

  List<String> specializations = [
    'أمراض القلب والأوعية الدموية (Cardiology)',
    'جراحة العظام (Orthopedics)',
    'طب الأطفال (Pediatrics)',
    'أمراض الجلدية (Dermatology)',
    'أمراض الأعصاب (Neurology)',
    'طب العيون (Ophthalmology)',
    'أمراض الجهاز الهضمي (Gastroenterology)',
    'أمراض الغدد الصماء (Endocrinology)',
    'طب الأورام (Oncology)',
    'طب المسالك البولية (Urology)',
    'طب النساء والتوليد (Obstetrics and Gynecology)',
    'طب النفسي (Psychiatry)',
    'الأشعة التشخيصية (Radiology)',
    'تخدير (Anesthesiology)',
    'علم الأمراض (Pathology)',
    'طب الطوارئ (Emergency Medicine)',
    'طب العائلة (Family Medicine)',
    'طب الباطنة (Internal Medicine)',
    'جراحة عامة (General Surgery)',
    'جراحة تجميلية (Plastic Surgery)',
    'جراحة الأعصاب (Neurosurgery)',
    'أنف وأذن وحنجرة (ENT - Ear, Nose, Throat)',
    'طب الأسنان (Dentistry)',
    'علاج طبيعي (Physical Therapy)',
  ];
  String selectedSpecialization = 'Any';

  List<String> hospitals = ['None'];
  String selectedHospital = 'Any';
  // to be called from l10n for arabic
  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 233, 255, 255),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 233, 255, 255), // Background color of search page
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color.fromARGB(10, 0, 0, 0), // Background color of the search box
        filled: true,
        hintStyle: TextStyle(color: Color.fromARGB(255, 172, 172, 172), fontSize: 18.0), // Text color of search box hint
        isCollapsed: false, // Allow the search box to expand horizontally
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none, // No border
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => SearchData(),
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Search People'),
  //       ),
  //       body: Column(
  //         children: [
  //           buildFilters(),
  //           Expanded(
  //             child: buildSuggestions(context),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildFilters() {
  //   return Consumer<SearchData>(
  //     builder: (context, searchData, _) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   showSpecializationDialog(context, searchData);
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(10.0),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         searchData.selectedSpecialization.isEmpty ? 'Select Specialization' : searchData.selectedSpecialization,
  //                         style: TextStyle(fontSize: 16.0),
  //                       ),
  //                       Icon(Icons.arrow_drop_down),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 10.0),
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   showHospitalDialog(context, searchData);
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(10.0),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         searchData.selectedHospital.isEmpty ? 'Select Hospital Name' : searchData.selectedHospital,
  //                         style: TextStyle(fontSize: 16.0),
  //                       ),
  //                       Icon(Icons.arrow_drop_down),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void showSpecializationDialog(BuildContext context, SearchData searchData) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Select Specialization'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: specializations.map((String specialization) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   searchData.setSpecialization(specialization);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                   child: Text(specialization),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void showHospitalDialog(BuildContext context, SearchData searchData) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Select Hospital Name'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: hospitals.map((String hospital) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   searchData.setHospital(hospital);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                   child: Text(hospital),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ""; // Clear the search query
        },
        icon: Container(
          // width: 30.0, // Adjust the width to fit the IconButton
          // height: 60.0, // Adjust the height to fit the IconButton
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black, // Customize circle background color
          ),
          child: Icon(
            Icons.clear,
            color: Colors.white, // Customize icon color
          ),
        ),
      ),
    ];
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black, // Customize circle background color
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white, // Customize icon color
          ),
        ),
      ),
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    // Return an empty container for now
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    search_service s = search_service();
    Map<String, dynamic> requestData = {
      'query': query,
      'hospitalName': selectedHospital,
      'specialization': selectedSpecialization,
    };
    return FutureBuilder<List<dynamic>>(
      future: s.fetchSuggestions(requestData),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = snapshot.data?[index];
              String location = item?['location'] ?? "";
              String specialization = item?['specialization'] ?? "";
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30.0,
                  backgroundImage: item?['image'] != null
                      ? NetworkImage(item?['image'])
                      : null,
                ),
                title: Text(
                  item?['username'] ?? "",
                  style: const TextStyle(fontSize: 16.0),
                ),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (location.isNotEmpty)
                  Text(
                    specialization,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  if (specialization.isNotEmpty)
                  Text(
                    location,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
                onTap: () {
                  selectedUserId = item?['_id'];
                  showResults(context);
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0), // Adjust the preferred height as needed
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First filter box (Location)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Open a dropdown menu to choose from the list of Specialization
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Specialization'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: specializations.map((String specialization) {
                              return GestureDetector(
                                onTap: () {
                                  // Set the selected specialization
                                  selectedSpecialization = specialization;
                                  print(selectedSpecialization);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(specialization),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ٍSpecialization', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(selectedSpecialization.isEmpty ? 'Select Specialization' : selectedSpecialization,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0), // Add spacing between filter boxes

            // Second filter box (Another filter)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Open a dropdown menu to choose from the list of Specialization
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Hospital Name'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: hospitals.map((String hospital) {
                              return GestureDetector(
                                onTap: () {
                                  // Set the selected hospital
                                  selectedHospital = hospital;
                                  print(selectedHospital);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(hospital),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hospital Name', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedHospital.isEmpty ? 'Select Hospital Name' : selectedHospital, style: TextStyle(fontSize: 16.0)),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  




    // @override
// void showResults(BuildContext context) {
//   // Push the user profile screen with userID as arguments
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => ViewProfileScreen(userID: selectedUserId),
//     ),
//   );
// }

  
}


