import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rigel_application/helpers/database_helper_cat.dart';
import 'package:rigel_application/models/cat_model.dart';
import 'package:rigel_application/screens/taken_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

//ctrl+. para convertir a statefulwidget
class HomeScreen2 extends StatefulWidget {
  final CameraDescription passCamara;
  final String imgapath;
  HomeScreen2({Key? key, required this.passCamara, required this.imgapath})
      : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  int? catid;
  //variables para guardar los datos de los text form fields
  final textControllerRace = TextEditingController();
  final textControllerName = TextEditingController();

  //acept integers and nulls
  //int? catId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Example with Cats"),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          //que la lista sea scrollable con un pequeño numero de hijos
          shrinkWrap: true,
          children: [
            //Raza
            TextFormField(
                controller: textControllerRace,
                decoration: const InputDecoration(
                    icon: Icon(Icons.view_comfortable),
                    labelText: "Input the race of the cat")),
            //Nombre
            TextFormField(
                controller: textControllerName,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_format_outlined),
                    labelText: "Input the cat's name")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TakenPictureScreen(camera: widget.passCamara)));
                },
                child: const Text("Take a picture")),
            //ClipRRect(
            //  borderRadius: BorderRadius.circular(8.0),
            //  child: const Image(
            //    image: NetworkImage(
            //        "https://i.pinimg.com/236x/bc/3e/3d/bc3e3de9ca839288c7779965afb5c17c.jpg"),
            //   width: 100,
            //),
            //),
            Center(
              child: (
                  //Ideal guardar lo siguiente en un widget independiente
                  FutureBuilder<List<Cat>>(
                //data source del widget
                future: DatabaseHelper.instance.getCats(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Cat>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text("Loading..."),
                      ),
                    );
                  } else {
                    //snapshot no esta vacio?
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Container(
                              child: const Text("No cats in the list"),
                            ),
                          )
                        : ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.map((cat) {
                              return Column(children: [
                                SizedBox(
                                  width: 100,
                                  child: Image.file(File(cat.imagepath)),
                                ),
                                Center(
                                    child: Card(
                                  color: catid == cat.id
                                      ? Colors.amberAccent
                                      : Colors.white,
                                  child: ListTile(
                                    textColor: catid == cat.id
                                        ? Colors.white
                                        : Colors.black,
                                    title: Text(
                                        'Name: ${cat.name} | Race: ${cat.race}'),
                                    onLongPress: () {
                                      setState(() {
                                        DatabaseHelper.instance.delete(cat.id!);
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        if (catid == null) {
                                          textControllerName.text = cat.name;
                                          textControllerRace.text = cat.race;
                                          catid = cat.id;
                                        } else {
                                          textControllerName.clear();
                                          textControllerRace.clear();
                                          catid = null;
                                        }
                                      });
                                    },
                                  ),
                                )),
                              ]);
                            }).toList());
                  }
                },
              )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (catid == null) {
            await DatabaseHelper.instance.update(Cat(
                race: textControllerRace.text,
                name: textControllerName.text,
                imagepath: widget.imgapath,
                id: catid));
            //print(widget.imgapath);
          } else {
            DatabaseHelper.instance.add(Cat(
                race: textControllerRace.text,
                name: textControllerName.text,
                imagepath: widget.imgapath));
          }
          DatabaseHelper.instance.add(Cat(
              race: textControllerRace.text,
              name: textControllerName.text,
              imagepath: widget.imgapath));
          setState(() {
            textControllerName.clear();
            textControllerRace.clear();
          });
        },
      ),
    );
  }
}
