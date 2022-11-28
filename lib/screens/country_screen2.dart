import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/helpers/firestore_helper.dart';
import 'package:rigel_application/reusable_widgets/card_country.dart';

import 'home_screen.dart';

class CountryScreen2 extends StatefulWidget {
  CountryScreen2({Key? key}) : super(key: key);

  @override
  State<CountryScreen2> createState() => _CountryScreen2State();
}

class _CountryScreen2State extends State<CountryScreen2> {
 
 List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('countries').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Countries"),
          backgroundColor: Color.fromRGBO(255, 183, 77, 1),
          toolbarHeight: 75,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
            iconSize: 30,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ),
        body: FutureBuilder(
          future: getDocId(),
          builder: ((context, snapshot) {
          return ListView.builder(
          itemCount: docIDs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ListView(
              shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          CountryCard(docs: docIDs[index]),
        ],
            );
          },
        );
        })),
    );
  }
}