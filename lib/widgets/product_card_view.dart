import 'package:company/constants.dart';
import 'package:company/screens/chat_window.dart';
import 'package:company/screens/company_screens/product_details.dart';
import 'package:company/screens/doctor_screens/patients_filtering.dart';
import 'package:company/services/doctor_services/doctor_products_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  ProductCardView({this.category,this.sender});
  final String category;
  final String sender;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: StreamBuilder(
        stream: _firestore
            .collection('hosptial')
            .doc('medicine_products')
            .collection(category)
            .snapshots(),
        builder: (context, snapshot) {
          List<DoctorProductInfo> productList = [];
          print(snapshot.data.docs.length != 0);
          try {
            if (snapshot.data.docs.length != 0) {
              final products = snapshot.data.docs.reversed;
              for (var product in products) {
                final title = product.data()['Name'].toString();
                final tagline = product.data()['TagLine'].toString();
                final description = product.data()['Description'].toString();
                final uses = product.data()['Usage_Features'].toString();
                final webLink = product.data()['WebLink'].toString();
                final tags = product.data()['Tags'];
                final images = product.data()['images'];
                final company = product.data()['Company'].toString();
                final sender = product.data()['Sender'].toString();
                DoctorProductInfo info = DoctorProductInfo(
                    title: title,
                    tagLine: tagline,
                    description: description,
                    uses: uses,
                    webLink: webLink,
                    tags: tags,
                    imageUrl: images,
                    sender: sender,
                    companyName: company);
                productList.add(info);
              }
              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: new Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xff7c94b6),
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.dstATop),
                          image: new NetworkImage(
                              productList[index].imageUrl[0].toString()),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.explore,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ProductDetails(
                                          title: productList[index].title,
                                          tagLine: productList[index].title,
                                          uses: productList[index].uses,
                                          tags: productList[index].tags,
                                          description:
                                              productList[index].description,
                                          webLink: productList[index].webLink,
                                          imageUrl: productList[index].imageUrl,
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(productList[index].companyName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w600)),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatWindow(
                                                    reciever: productList[index]
                                                        .sender,
                                                    sender: sender,
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.question_answer,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              productList[index].tagLine,
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientsFilter(selectedproductinfo: productList[index],)));
                                  },
                                  child: Expanded(
                                      child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20.0,
                                  )),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    productList[index].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              );
            } else {
              return Container(
                color: Colors.black,
                height: 20.0,
                width: 20.0,
              );
            }
          } catch (e) {
            return Container(
              color: Colors.black,
              height: 20.0,
              width: 20.0,
            );
          }
        },
      ),
    );
  }
}
