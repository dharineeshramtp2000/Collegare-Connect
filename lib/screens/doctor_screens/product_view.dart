import 'package:company/services/company_services/product_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductView extends StatefulWidget {

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductInfo info = ProductInfo();
  List<dynamic> tags;
  String title;
  String tagLine;
  String description;
  String uses;
  String webLink;
  List<dynamic> imageUrl;
  List<NetworkImage> sliderImages = [];
  List<String> displayTags = [];
  Widget slidingImages(List<NetworkImage> sliderImages){
    return Container(
      height: 300.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('image/oro.jpg'),
          AssetImage('image/or1.jpg'),
          AssetImage('image/or2.png'),
          AssetImage('image/or3.jpg'),
          AssetImage('image/or4.jpg'),
        ],
        autoplay: true,
        dotSize: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(seconds: 1),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
//        leading: Icon(Icons.chevron_left),
        backgroundColor: Colors.blue,
        title: Text('Collegare',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Viga'),),
      ),
      body: Container(
//      color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  slidingImages(sliderImages),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                ),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oropharyngeal Airway',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AutoSizeText(
                          'Airway adjunct used to maintain or open a patient\'s airway.',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontFamily: 'Ubuntu',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Description',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AutoSizeText(
                          'An oropharyngeal airway (also known as an oral airway, OPA or Guedel pattern airway) is a medical device called an airway adjunct used to maintain or open a patient\'s airway. It does this by preventing the tongue from covering the epiglottis, which could prevent the person from breathing.Oropharyngeal airways are indicated only in unconscious people, because of the likelihood that the device would stimulate a gag reflex in conscious or semi-conscious persons.\n This could result in vomit and potentially lead to an obstructed airway. Nasopharyngeal airways are mostly used instead as they do not stimulate a gag reflex. \n In general, oropharyngeal airways need to be sized and inserted correctly to maximize effectiveness and minimize possible complications, such as oral trauma.',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontFamily: 'Ubuntu',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Uses',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AutoSizeText(
                          'Use of an OPA does not remove the need for the recovery position and ongoing assessment of the airway and it does not prevent obstruction by liquids (blood, saliva, food, cerebrospinal fluid) or the closing of the glottis. It can, however, facilitate ventilation during CPR (cardiopulmonary resuscitation) and for persons with a large tongue.',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontFamily: 'Ubuntu',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Tags',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 4.0, // gap between lines
                            children: <Widget>[
                              for (var i in ['Diabetes','Lungs','Stage 1'])//displayTags)
                                Chip(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 5),
                                    label: Text(i,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
//                  color: Color(0xFF3649AE)
                                      ),
                                    )
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Visit Product',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 3,
                          child: InkWell(
                            child: Text('Click here to know more about the Product',style: TextStyle(
                                color: Colors.blue
                            ),),
                            onTap: (){
                              launch('https://www.youtube.com/watch?v=Hzc_T4QBp4E');
                            },
                          ),
                        )
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
