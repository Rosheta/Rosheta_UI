import 'package:flutter/material.dart';
import 'package:rosheta_ui/services/search_service.dart';
import 'package:provider/provider.dart';

// import 'package:rosheta_ui/Views/profile_screen.dart';

class SearchProvider extends ChangeNotifier {
  String selectedSpecialization = 'Any';
  String selectedLocation = 'Any';
  String selectedOrganization = 'Any';

  void updateSpecialization(String specialization) {
    selectedSpecialization = specialization;
    notifyListeners(); // Notify listeners that the state has changed
  }

  void updateLocation(String location) {
    selectedLocation = location;
    notifyListeners(); 
  }

  void updateOrganization(String organization){
    selectedOrganization = organization;
    notifyListeners();
  }
}

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

class SearchPeople extends SearchDelegate<String>{
  String selectedUserId = "";

  List<String> specializations = [
    'Any',
    'Anesthesiology',
    'Cardiology',
    'Dentistry',
    'Dermatology',
    'Emergency Medicine',
    'Endocrinology',
    'ENT - Ear, Nose, Throat',
    'Family Medicine',
    'Gastroenterology',
    'General Surgery',
    'Internal Medicine',
    'Neurology',
    'Neurosurgery',
    'Obstetrics and Gynecology',
    'Oncology',
    'Ophthalmology',
    'Orthopedics',
    'Pathology',
    'Pediatrics',
    'Physical Therapy',
    'Plastic Surgery',
    'Psychiatry',
    'Radiology',
    'Urology'
  ];

  List<String> locations = [
    'Any',
    'Alexandria',
    'Aswan',
    'Asyut',
    'Beheira',
    'Beni Suef',
    'Cairo',
    'Dakahlia',
    'Damietta',
    'Faiyum',
    'Gharbia',
    'Giza',
    'Ismailia',
    'Kafr El Sheikh',
    'Luxor',
    'Matruh',
    'Minya',
    'Monufia',
    'New Valley',
    'North Sinai',
    'Port Said',
    'Qalyubia',
    'Qena',
    'Red Sea',
    'Sharqia',
    'Sohag',
    'South Sinai',
    'Suez'
  ];

  List<String> organizations = [
    'Any',
    'Doctor',
    'Patient',
    'Lab'
  ];

  // to be called from l10n for arabic
  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 233, 255, 255),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 233, 255, 255), // Background color of search page
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color.fromARGB(10, 0, 0, 0), // Background color of the search box
        filled: true,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 172, 172, 172), fontSize: 18.0), // Text color of search box hint
        isCollapsed: false, // Allow the search box to expand horizontally
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none, // No border
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      ),
    );
  }

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
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black, // Customize circle background color
          ),
          child: const Icon(
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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black, // Customize circle background color
        ),
        child: const Center(
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
    final searchProvider = Provider.of<SearchProvider>(context);

    Map<String, dynamic> requestData = {
      'query': query,
      'location': searchProvider.selectedLocation,
      'specialization': searchProvider.selectedSpecialization,
      'organization' : searchProvider.selectedOrganization,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildFilterBox(context, 'Organization', organizations),
              ),
              SizedBox(width: 5.0),
              if(searchProvider.selectedOrganization == 'Doctor')
              Expanded(
                child: buildFilterBox(context, 'Specialization', specializations),
              ),
              SizedBox(width: 5.0),
              if(searchProvider.selectedOrganization == 'Lab' || searchProvider.selectedOrganization == 'Doctor')
              Expanded(
                child: buildFilterBox(context, 'Location', locations),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
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
                    String specialization = item?['department'] ?? "";
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30.0,
                        backgroundImage: item?['profile_picture'] != null
                            ? NetworkImage(item?['profile_picture'])
                            : null,
                      ),
                      title: Text(
                        item?['name'] ?? "",
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (specialization.isNotEmpty)
                            Text(
                              specialization,
                              style: TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                          if (location.isNotEmpty)
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
          ),
        ),
      ],
    );
  }

  Widget buildFilterBox(BuildContext context, String title, List<String> items) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select $title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: items.map((String item) {
                    return GestureDetector(
                      onTap: () {
                        if (title == 'Specialization') {
                          searchProvider.updateSpecialization(item);
                        } else if (title == 'Location') {
                          searchProvider.updateLocation(item);
                        }
                        else if(title == 'Organization'){
                          searchProvider.updateOrganization(item);
                        }
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(item),
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
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16.0, color: Colors.grey),overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title == 'Specialization'
                        ? searchProvider.selectedSpecialization
                        : title == 'Location'
                        ? searchProvider.selectedLocation
                        : searchProvider.selectedOrganization,    
                    style: const TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
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


