import 'package:company/services/company_services/product_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({this.tags,this.title,this.tagLine,this.description,this.uses,this.webLink,this.imageUrl});
  final List<dynamic> tags;
  final String title;
  final String tagLine;
  final String description;
  final String uses;
  final String webLink;
  final List<dynamic> imageUrl;
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
        images: sliderImages,
        autoplay: true,
        dotSize: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(seconds: 1),
      ),
    );
  }
  @override
  void initState() {
    title = widget.title;
    tagLine = widget.tagLine;
    tags = widget.tags;
    uses = widget.uses;
    description = widget.description;
    webLink = widget.webLink;
    imageUrl = widget.imageUrl;
    for(var ele in imageUrl){
      sliderImages.add(NetworkImage(ele.toString()));
    }
    for(var ele in tags){
      displayTags.add(ele.toString());
    }
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: 'Viga',
                            decoration: TextDecoration.none
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontFamily: 'Ubuntu',
                          decoration: TextDecoration.none
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Tag Line',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: 'Viga',
                            decoration: TextDecoration.none
                        ),
                      ),
                      SizedBox(height: 10,),
                      AutoSizeText(
                          tagLine,
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
                        description,
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
                        uses,
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
                            for (var i in displayTags)
                              Chip(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 5),
                                  label: Text(i,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,

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
                            launch(webLink);
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
