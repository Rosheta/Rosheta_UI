import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import "package:rosheta_ui/generated/l10n.dart";

class ShowFileScreen extends StatelessWidget {
  Uint8List? serverData;

  Future<void> _fetchattachments() async {
    try {
      print("login");
      await login();
      return;
    } catch (e) {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<bool> login() async {
    final url = 'http://192.168.1.8:5000/ipfs/get?hash=QmPmWNY9icXLfoFiLqjge8RVFszVH4CU7qXR2XzDbhtkgz';

    try {
      print("enterr");
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        serverData = response.bodyBytes;
        return true;
      } else {
        print('Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  @override
@override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: _fetchattachments(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Show loading indicator while fetching data
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Show error message if fetch failed
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else {
        // Data fetched successfully, build PDFView widget
        Uint8List image = Uint8List.fromList(serverData!);
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
          ),
          body: Center(
            child: PDFView(
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              pageSnap: true,
              pdfData: image,
            ),
          ),
        );
      }
    },
  );
}
}
