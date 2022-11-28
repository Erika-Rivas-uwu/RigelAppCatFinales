import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/reusable_widgets/card_country.dart';

import 'home_screen.dart';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final doc1 = db.doc("/countries/co01");
    final doc2 = db.doc("/countries/co02");
    final doc3 = db.doc("/countries/co03");
    final doc4 = db.doc("/countries/co04");
    final doc5 = db.doc("/countries/co05");
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
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            //CountryCard(docs:doc1),
            //CountryCard(docs:doc2),
            //CountryCard(docs:doc3),
            //CountryCard(docs:doc4),
            //CountryCard(docs:doc5)
            StreamBuilder(
              stream: readData(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Something went wrong! ${snapshot.connectionState}');
                } else if (snapshot.hasData) {
                  final country = snapshot.data!;

                  return ListView(
                 //   children: country.map(buildCountry).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            )
          ],
        ));
  }
}

Widget buildCountry(Country country) =>
//CountryCard(image: country.flag, name: country.name, language: country.language, continent: country.continent, stores: country.strores
    ListTile(
      title: Text(country.name),
    );
//);

Future createCountry({required String name}) async {
  final docCountry = FirebaseFirestore.instance.collection('countries').doc();

  final country = Country(
      id: docCountry.id,
      name: name,
      flag: 'flag',
      language: 'language',
      strores: 'stores',
      continent: 'America');

  final json = country.toMap();

  await docCountry.set(json);
}

Stream<List<Country>> readData() => FirebaseFirestore.instance
    .collection('countries')
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Country.fromMap(doc.data())).toList());

class Country {
  String id;
  final String name;
  final String continent;
  final String flag;
  final String language;
  final String strores;

  Country(
      {this.id = '',
      required this.name,
      required this.continent,
      required this.flag,
      required this.language,
      required this.strores});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'continent': continent,
      'language': language,
      'flag': flag,
      'stores': strores
    };
  }

  factory Country.fromMap(Map<String, dynamic> json) => Country(
      name: json['name'],
      continent: json['continent'],
      flag: json['flag'],
      language: json['language'],
      strores: json['strores']);
}
