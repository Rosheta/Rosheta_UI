import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/view_profile_screen.dart';
import 'package:rosheta_ui/services/search_service.dart';

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
                  delegate: SearchPeople());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class SearchPeople extends SearchDelegate<String> {
  String selectedUserId = "";

  // to be called from l10n for arabic
  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 233, 255, 255),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
   
    return Container();
  }

  // Function to navigate to user profile screen
@override
void showResults(BuildContext context) {
  // Push the user profile screen with userID as arguments
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ViewProfileScreen(userID: selectedUserId),
    ),
  );
}

  @override
  Widget buildSuggestions(BuildContext context) {
    search_service s = search_service();
    return FutureBuilder<List<dynamic>>(
      future: s.fetchSuggestions(query),
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: item?['image'] != null
                      ? NetworkImage(item?['image'])
                      : null,
                ),
                title: Text(
                  item?['username'] ?? "",
                  style: const TextStyle(fontSize: 16.0),
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
}
