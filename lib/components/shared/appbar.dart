import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';

AppBar appBar(context) {
  return AppBar(
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
          showSearch(context: context, delegate: SearchPeople());
        },
      ),
    ],
  );
}
