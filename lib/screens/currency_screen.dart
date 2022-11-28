import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/reusable_widgets/card_country.dart';

import '../reusable_widgets/card_currency.dart';
import 'home_screen.dart';

class CurrencyScreen extends StatelessWidget {
  CurrencyScreen({Key? key}) : super(key: key);

   List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('currency').get().then((snapshot) => snapshot.docs.forEach((document) {
    print(document.reference);
    docIDs.add(document.reference.id);})
  );
 }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency"),
        backgroundColor: Color.fromRGBO(255, 183, 77, 1),
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
           
          ),
          iconSize: 30,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
          CurrencyCard(docs: docIDs[index]),
        ],
            );
          },
        );
        })),
    );
  }
}