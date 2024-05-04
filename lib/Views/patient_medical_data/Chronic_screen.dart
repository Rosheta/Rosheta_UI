import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/services/patient_medical_data/Chronic_service.dart';

import '../search/search_screen.dart'; // Import your ChronicDiseaseApi service

class ChronicDiseaseListScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const ChronicDiseaseListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChronicDiseaseListScreenState createState() =>
      _ChronicDiseaseListScreenState();
}

class _ChronicDiseaseListScreenState extends State<ChronicDiseaseListScreen> {
  late Future<List<ChronicDisease>> _chronicDiseasesFuture;

  @override
  void initState() {
    super.initState();
    _chronicDiseasesFuture = _fetchChronicDiseases();
  }

  Future<List<ChronicDisease>> _fetchChronicDiseases() async {
    try {
      ChronicDiseaseListApi chronicDiseaseApi = ChronicDiseaseListApi();
      return await chronicDiseaseApi.fetchChronicDiseaseList();
    } catch (e) {
      throw Exception('Failed to fetch chronic diseases');
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
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.message),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const FriendsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
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
      body: FutureBuilder<List<ChronicDisease>>(
        future: _chronicDiseasesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ChronicDisease> chronicDiseases = snapshot.data!;

            return ListView.builder(
              itemCount: chronicDiseases.length,
              itemBuilder: (context, index) {
                ChronicDisease disease = chronicDiseases[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 5.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius for circular edges
                      ),
                      child: Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 8.0),
                          title: Text(
                            disease.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          initiallyExpanded: false,
                          children: [
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              title: getTitle(S.of(context).assignDate),
                              subtitle: Text(
                                disease.date,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              title: getTitle(S.of(context).Notes),
                              subtitle: Text(
                                disease.notes,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Row getTitle(T) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensure the Row takes minimum space required
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 4, horizontal: 8), // Padding around the text
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 13, 122, 134), // Background color of the rectangle
            borderRadius: BorderRadius.circular(
                10), // Border radius to make it rectangular
          ),
          child: Text(
            T,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 254, 255),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
