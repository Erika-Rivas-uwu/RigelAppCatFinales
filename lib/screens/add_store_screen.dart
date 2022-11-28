import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/reusable_widgets/card_stores.dart';
import 'package:rigel_application/screens/international_screen.dart';

import 'home_screen.dart';

class AddStore extends StatefulWidget {
  AddStore({Key? key}) : super(key: key);

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  
  final txtname = TextEditingController();
  final txtimage = TextEditingController();
  String _dropdownValue = "México";
  
  void dropDownCall(String? selectedValue){
    if (selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
        print(_dropdownValue);
      });
    }
  }

  Future addNewStore(String name, String image, String country) async {
    await FirebaseFirestore.instance.collection('stores').add({
      'name': name,
      'country':country,
      'image':image,
      'favorite':false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black,),
          iconSize: 30,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => InternationalScreen()));
          },
        ),
        title: Text("Add a new Store", style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            DropdownButtonFormField(
              items: const[
              DropdownMenuItem(child: Text('México'), value: "México"),
              DropdownMenuItem(child: Text('United States'), value: "United States"),
              DropdownMenuItem(child: Text('Spain'), value: "Spain"),
              DropdownMenuItem(child: Text('Canada'), value: "Canada"),
              DropdownMenuItem(child: Text('China'), value: "China"),
            ],
            value: _dropdownValue,
            onChanged: dropDownCall),
            TextFormField(
                controller: txtname,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc_sharp),
                    labelText: "Input the store name")),
                    TextFormField(
                controller: txtimage,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc_sharp),
                    labelText: "Input the store image (link)")),
            SizedBox(height: 20,),
          FloatingActionButton.extended
          (label: const Text("Save the new store", 
          style: TextStyle(color: Colors.white, fontSize: 15,)),
          backgroundColor: Colors.orange[300],
          icon: const Icon(Icons.save_alt_rounded, size: 25.0, color: Colors.white,), 
          onPressed: () {
            addNewStore(
              txtname.text.trim(),
              txtimage.text.trim(),
              _dropdownValue.trim(),);
              setState(() {
              txtname.clear();
              txtimage.clear();
             
              });
             final snackBar = SnackBar(
            content: const Text('Store Added'),
            action: SnackBarAction(
              label: '',
              onPressed: () {              
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);},)
      ]),
    ));
  }
}