import 'package:company/constants.dart';
import 'package:company/screens/company_screens/product_details.dart';
import 'package:company/services/company_services/product_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
String _idpat = '';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  final _firestore = FirebaseFirestore.instance;

  int flag = 0;
//  bool initialized = false;
//  bool showSpinner = true;
   getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idpat = prefs.getString('idpat');
    //print(Constants.myName);

    setState(() {
      _idpat = (prefs.getString('idpat') ?? '');

    });

  }
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      getUserInfogetChats();
      setState(() {});
    });

print(_idpat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('hosptial')
              .doc('patients')
              .collection(_idpat).doc(_idpat).collection('recommend_products')
              .snapshots(),
          builder: (context, snapshot) {
            List<ProductInfo> productList = [];
            print('check');
            try {
              print(_idpat);

              print(snapshot.data.docs.length != 0);
              if (snapshot.data.docs.length != 0) {
                final products = snapshot.data.docs.reversed;
                for (var product in products) {
                  final title = product.data()['name'].toString();
                  final tagline = product.data()['tagline'].toString();
                  final description = product.data()['description'].toString();
                  final uses = product.data()['uses'].toString();
                  final webLink = product.data()['weblink'].toString();
                  final tags = product.data()['tags'];
                  final images = product.data()['image'];
                  print(webLink);
                  ProductInfo info = ProductInfo(
                      title: title,
                      tagLine: tagline,
                      description: description,
                      uses: uses,
                      webLink: webLink,
                      tags: tags,
                      imageUrl: images);

                  productList.add(info);
                }
                print(productList.length);
                return ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue,
                      height: 170.0,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProductDetails(
                                                          title: productList[index]
                                                              .title,
                                                          tagLine:
                                                          productList[index]
                                                              .title,
                                                          uses: productList[index]
                                                              .uses,
                                                          tags: productList[index]
                                                              .tags,
                                                          description: productList[index]
                                                              .description,
                                                          webLink:
                                                          productList[index]
                                                              .webLink,
                                                          imageUrl:
                                                          productList[index]
                                                              .imageUrl,
                                                        );
                                                      }));
                                            },
                                            child: Icon(
                                              Icons.explore,
                                              color: Colors.blueGrey,
                                            )),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            productList[index].title,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    AutoSizeText(
                                      productList[index].tagLine,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 14.0,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image: NetworkImage(productList[index]
                                        .imageUrl[0]
                                        .toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              else {
                return Container(
                  child: Center(
                    child: Text(
                      'No products added yet.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white),
                    ),
                  ),
                );
              }
            }
            catch(e){
              return Container(
                child: Center(
                  child: Text(
                    'No products added yet.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white),
                  ),
                ),
              );
            }
          },
        ));
  }
}
