import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/screens/add_store_screen.dart';

import '../reusable_widgets/card_currency.dart';
import '../reusable_widgets/card_stores.dart';
import 'countries_screen.dart';
import 'currency_screen.dart';
import 'home_screen.dart';

class InternationalScreen extends StatelessWidget {
  InternationalScreen({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(),
      drawer: StoresDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStore())); },
        backgroundColor: Colors.orange[300],
        child: const Icon(Icons.add),),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,),
          ],
        ),
      )      
    );
  }
}

class FavoriteStores extends StatelessWidget {
 FavoriteStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('favorite', isEqualTo: true).get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class MexicoStores extends StatelessWidget {
MexicoStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'México').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class UnitedStores extends StatelessWidget {
  UnitedStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'United States').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class ChinaStores extends StatelessWidget {
  ChinaStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'China').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class CanadaStores extends StatelessWidget {
  CanadaStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'Canada').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class SpainStores extends StatelessWidget {
  SpainStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'Spain').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}