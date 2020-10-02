import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/screens/company_screens/product_details.dart';
import 'package:company/screens/doctor_screens/product_view.dart';
import 'package:company/services/company_services/product_info.dart';
import 'package:company/widgets/doctor_title_card.dart';
import 'package:company/widgets/product_card_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  String _iddoc = '';
  String _docsp = '';
  final _firestore = FirebaseFirestore.instance;

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iddoc = prefs.getString('iddoc');
    SharedPreferences pref = await SharedPreferences.getInstance();
    _docsp = prefs.getString('docsp');
    //print(Constants.myName);

    setState(() {
      _iddoc = (prefs.getString('iddoc') ?? '');
      _docsp = (prefs.getString('docsp') ?? '');
      print('Checking');
      print(_iddoc);
      print(_docsp);
    });
  }

  int _index = 3;
  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0, bottom: 10.0),
        color: Color(0xFFE7EFFA),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find what\'s',
                      style: TextStyle(
                          color: kDoctorPrimaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Ubuntu'),
                    ),
                    Text(
                      'Latest',
                      style: TextStyle(
                          color: kDoctorPrimaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'CarterOne'),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.search,
                            size: 30.0, color: kDoctorPrimaryColor),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.chat_bubble_outline,
                            size: 30.0, color: kDoctorPrimaryColor)
                      ],
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 170.0,
              width: double.infinity,
              color: Color(0xFFE7EFFA),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('news_feed').snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    List<ProductInfo> productList = [];
                    print('check');
                    print(snapshot.data.docs.length != 0);
                    try {
                      if (snapshot.data.docs.length != 0) {
                        final products = snapshot.data.docs.reversed;
                        for (var product in products) {
                          final title = product.data()['Name'].toString();
                          final tagline =
                              product.data()['TagLine'].toString();
                          final description =
                              product.data()['Description'].toString();
                          final uses =
                              product.data()['Usage_Features'].toString();
                          final webLink =
                              product.data()['WebLink'].toString();
                          final tags = product.data()['Tags'];
                          final images = product.data()['images'];
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
                        return PageView.builder(
                          itemCount: productList.length,
                          allowImplicitScrolling: false,
                          controller: PageController(viewportFraction: 0.85),
                          onPageChanged: (int index) => setState(() => _index = index),
                          itemBuilder: (_, i) {
                            return Transform.scale(
                              scale: i == _index ? 1 : 0.9,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return ProductDetails(
                                              title: productList[_index]
                                                  .title,
                                              tagLine:
                                              productList[_index]
                                                  .tagLine,
                                              uses: productList[_index]
                                                  .uses,
                                              tags: productList[_index]
                                                  .tags,
                                              description: productList[_index]
                                                  .description,
                                              webLink:
                                              productList[_index]
                                                  .webLink,
                                              imageUrl:
                                              productList[_index]
                                                  .imageUrl,
                                            );
                                          }));
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Card(
                                    color: Colors.blue,
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                AutoSizeText(
                                                  productList[_index].title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                AutoSizeText(
                                                  productList[_index].tagLine,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 14.0,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Opacity(
                                                opacity: 0.88,
                                                child: Image(
                                                  image: NetworkImage(productList[_index].imageUrl[0]),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }else{
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
                    } catch (e) {
                      print(e);
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
                  }),
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              children: [
                DoctorTitle(category: 'Cardiology'),
                ProductCardView(
                  category: 'Cardiology',
                  sender: _iddoc,
                ),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Diabetology'),
                ProductCardView(category: 'Diabetology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Rheumatology'),
                ProductCardView(category: 'Rheumatology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Endocrinology'),
                ProductCardView(category: 'Endocrinology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),

                DoctorTitle(category: 'Genral&laparascopic_surgy'),
                ProductCardView(
                    category: 'Genral&laparascopic_surgy', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Odontology'),
                ProductCardView(category: 'Odontology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Neurology'),
                ProductCardView(category: 'Neurology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Ophthalmolopgy'),
                ProductCardView(category: 'Ophthalmolopgy', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Orthopedics'),
                ProductCardView(category: 'Orthopedics', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),
                DoctorTitle(category: 'Urology'),
                ProductCardView(category: 'Urology', sender: _iddoc),
                SizedBox(
                  height: 10.0,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}





