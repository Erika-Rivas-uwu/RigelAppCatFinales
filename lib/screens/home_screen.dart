import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rigel_application/helpers/database_helper_products.dart';
import 'package:rigel_application/screens/add_cat_screen.dart';
import 'package:rigel_application/screens/add_product_screen.dart';
import 'package:rigel_application/screens/product_details_screen.dart';
import '../models/product_model.dart';
import 'currency_screen.dart';
import 'international_screen.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription passCamara;
  const HomeScreen(
      {Key? key,
      this.passCamara = const CameraDescription(
          name: "0",
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 90)})
      : super(key: key);
  const HomeScreen.wCameraUsage({super.key, required this.passCamara});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String SelectedCategory = "Cookies";
  String ProductName = "Galletas Solidarias";

  //var text = widget.passCamara;

  @override
  Widget build(BuildContext context) {
    var text = widget.passCamara;
    return Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.orange[300]),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
              const DrawerHeader(
                  child: Text("Menu",
                      style: TextStyle(color: Colors.black, fontSize: 20))),
              ListTile(
                title: const Text("Add cat"),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => HomeScreen2(
                            passCamara: text,
                            imgapath: "",
                          ));
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                title: const Text("International Stores"),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => InternationalScreen());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                title: const Text("Currency"),
                onTap: () {
                  final route =
                      MaterialPageRoute(builder: (context) => CurrencyScreen());
                  Navigator.push(context, route);
                },
              )
            ])),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("Hello"),
                const Text("What today's taste?",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              SelectedCategory = "Cookies";
                            });
                          },
                          child: Icon(
                            Icons.cookie_sharp,
                            color: Colors.grey[200],
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.orange[200],
                          ),
                        ),
                        Text("Cookies"),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              SelectedCategory = "Fruit";
                              print(SelectedCategory);
                            });
                          },
                          child: Icon(
                            Icons.apple_sharp,
                            color: Colors.grey[200],
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.orange[200],
                          ),
                        ),
                        const Text("Fruit"),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      size: 40,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange[300]),
                      child: FutureBuilder<List<Product>>(
                          future: DatabaseHelper.instance
                              .getOneProduct(ProductName),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text("Loading...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ),
                              );
                            } else {
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Container(
                                          child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://cdn.shopify.com/s/files/1/2531/9922/articles/70968265_562897317789221_8160954985052372992_n_600x.jpg?v=1569606497"),
                                              height: 200,
                                            )),
                                        const Text("Select a Product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    )))
                                  : ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: snapshot.data!.map(
                                        (product) {
                                          return Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image(
                                                      image: NetworkImage(
                                                          product.imagepath),
                                                      height: 250.0,
                                                      width: 180,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            product.title
                                                                .replaceAll(
                                                                    " ", "\n"),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22)),
                                                        Text(
                                                            product.price
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20)),
                                                        const SizedBox(
                                                            height: 10),
                                                        RatingBar.builder(
                                                            itemSize: 25,
                                                            initialRating:
                                                                product.ranking
                                                                    .toDouble(),
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.0),
                                                            itemBuilder: (context,
                                                                    _) =>
                                                                const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .white),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              print(rating);
                                                            }),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        FloatingActionButton
                                                            .extended(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProductDetails(productTitle: product.title)));
                                                                },
                                                                label: const Text(
                                                                    "Add to the car",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                    )),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .shopping_cart,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .black,
                                                                ))
                                                      ]))
                                            ],
                                          );
                                        },
                                      ).toList());
                            }
                          }),
                    ),
                  ],
                ),
                //SizedBox(
                //  height: 30,
                //),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FutureBuilder<List<Product>>(
                          future: DatabaseHelper.instance
                              .getProductsCategory(SelectedCategory),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text("Loading...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20)),
                                ),
                              );
                            } else {
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Container(
                                          child: const Text("No products",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20))))
                                  : Container(
                                      height: 120,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: snapshot.data!.map(
                                            (product) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Colors.orange[300]),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          ProductName =
                                                              product.title;
                                                        });
                                                        print(product.category);
                                                      },
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image(
                                                            image: NetworkImage(
                                                                product
                                                                    .imagepath),
                                                            width: 110,
                                                          )),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: CircleBorder(),
                                                        shadowColor:
                                                            Colors.transparent,
                                                        primary:
                                                            Colors.transparent,
                                                      ),
                                                    )),
                                              );
                                            },
                                          ).toList()),
                                    );
                            }
                          }),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProductScreen()));
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.white,
                            side: BorderSide(width: 3.0, color: Colors.grey)),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }
}
