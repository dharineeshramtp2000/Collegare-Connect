import 'package:company/constants.dart';
import 'package:company/screens/company_screens/home_dart.dart';
import 'package:company/services/company_services/compnay_firebase_services.dart';
import 'package:company/widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _comp = '';
String _companyname = '';

class AddProduct extends StatefulWidget {


  @override
  _AddProductState createState() => _AddProductState();
}

Future saveImage(Asset asset, String name, String companyName) async {
  ByteData byteData =
      await asset.getByteData(); // requestOriginal is being deprecated
  List<int> imageData = byteData.buffer.asUint8List();
  StorageReference ref = FirebaseStorage().ref().child(
      "companies/${companyName}/$name.jpg"); // To be aligned with the latest firebase API(4.0)
  StorageUploadTask uploadTask = ref.putData(imageData);
  return await (await uploadTask.onComplete).ref.getDownloadURL();
}

class _AddProductState extends State<AddProduct> {
  String selectedSpecialization = 'Cardiology';
  CompanyFirebaseServices companyFirebaseServices = CompanyFirebaseServices();
  double containerHeight = 310.0;
  List<Asset> images = List<Asset>();
  String _error;
  List<String> _tags = [];
  String title;
  String tagLine;
  String description;
  String uses;
  String webLink;
  List<String> imageUrl = [];
  bool showSpinner = false;
  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _comp = prefs.getString('comp');
    _companyname = prefs.getString('company_name');
    //print(Constants.myName);

    setState(() {
      _comp = (prefs.getString('comp') ?? '');
      _companyname = (prefs.getString('company_name') ?? '');
      print('companyyy');
      print(_companyname);
    });
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  void initState() {

    super.initState();
    getUserInfogetChats();
    _tags.addAll([]);
  }

  List<PopupMenuEntry> _popupMenuBuilder(String tag) {
    return <PopupMenuEntry>[
      PopupMenuItem(
        child: Text(tag, style: TextStyle(color: Colors.blueGrey)),
        enabled: false,
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Icon(Icons.content_copy),
            Text("Copy text"),
          ],
        ),
      ),
    ];
  }

  void _getTags() {
    _tags.forEach((tag) => print(tag));
  }

  List<DropdownMenuItem> getItems(){
    List<DropdownMenuItem<String>> specializationItems = [];
    for(int i =0;i <kSpecializations.length;i++){
      print(kSpecializations[i]);
      var newItem = DropdownMenuItem(
        child: Text(kSpecializations[i]),
        value: kSpecializations[i],
      );
      specializationItems.add(newItem);
    }
    return specializationItems;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
//        leading: Icon(Icons.chevron_left),
          backgroundColor: Colors.blue,
          title: Text(
            'Collegare',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Viga'),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Add Product',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'CarterOne'),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title', style: kFormTitleTextStyle),
                          TextFormField(
                            onChanged: (value) {
                              title = value;
                            },
                            style: simpleTextStyle(),
                            // controller: usernameEditingController,
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Enter Username 3+ characters"
                                  : null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 10),
                                ),
                                hintText: 'Product name',
                                hintStyle: TextStyle(color: Colors.black38),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('Tagline', style: kFormTitleTextStyle),
                          TextFormField(
                            onChanged: (value) {
                              tagLine = value;
                            },
                            style: simpleTextStyle(),
                            // controller: usernameEditingController,
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Enter Username 3+ characters"
                                  : null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 10),
                                ),
                                hintText: 'Tagline',
                                hintStyle: TextStyle(color: Colors.black38),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Description',
                                style: kFormTitleTextStyle,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                'max (250 words)',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF7A8191)),
                              ),
                            ],
                          ),
                          TextFormField(
                            onChanged: (value) {
                              description = value;
                            },
                            style: simpleTextStyle(),
                            // controller: idEditingController,
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Enter UserID 3+ characters"
                                  : null;
                            },
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines: 20,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 10),
                              ),
                              hintText: 'Describe your Product',
                              hintStyle: TextStyle(color: Colors.black38),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6DD8D2))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,

                            children: [
                              Text(
                                'Usage Features',
                                style: kFormTitleTextStyle,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                'max (50 words)',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF7A8191)),
                              ),
                            ],
                          ),
                          TextFormField(
                            onChanged: (value) {
                              uses = value;
                            },
                            style: simpleTextStyle(),
                            // controller: idEditingController,
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Enter UserID 3+ characters"
                                  : null;
                            },
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines: 6,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 10),
                              ),
                              hintText: 'Features',
                              hintStyle: TextStyle(color: Colors.black38),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6DD8D2))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,

                            children: [
                              Text(
                                'Weblink',
                                style: kFormTitleTextStyle,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '(optional)',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF7A8191)),
                              ),
                            ],
                          ),
                          TextFormField(
                            onChanged: (value) {
                              webLink = value;
                            },
                            style: simpleTextStyle(),
                            // controller: idEditingController,
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Enter UserID 3+ characters"
                                  : null;
                            },
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 10),
                              ),
                              hintText: 'Web resource of your product',
                              hintStyle: TextStyle(color: Colors.black38),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6DD8D2))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          InputTags(
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            tags: _tags,
                            suggestionsList: [
                              "Type 1 Diabetes",
                              "Type 2 Diabetes",
                              "Gestational Diabetes",
                              "Hemorrhoid",
                              "Lupus",
                              "Shingles",
                              "Herpes",
                              "Pneumonia",
                              "HPV",
                              "Fibromyalgia",
                              "Scabies",
                              "Bronchitis",
                              "Strep Throat",
                              "Shingles",
                              "Kidney Stones",
                              "Mouth Ulcer"
                            ],
                            popupMenuBuilder: _popupMenuBuilder,
                            popupMenuOnSelected: (int id, String tag) {
                              switch (id) {
                                case 1:
                                  Clipboard.setData(ClipboardData(text: tag));
                                  break;
                                case 2:
                                  setState(() {
                                    _tags.remove(tag);
                                  });
                              }
                            },
                            onDelete: (tag) => print(tag),
                            onInsert: (tag) => print(tag),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20.0),
                            child: DropdownButton<String>(
                              value: selectedSpecialization,
                              items: kSpecializationDropDown,
                              onChanged: (value) {
                                setState(() {
                                  selectedSpecialization = value;
                                });
                                print(value);
                              },
                            ),
                          ),
                          Container(
                            height:
                                (images.length > 0) ? containerHeight : 10.0,
                            child: Expanded(
                              child: buildGridView(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: loadAssets,
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                'Upload Photos',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              print(title);
                              print(tagLine);
                              print(description);
                              print(uses);
                              print(webLink);
                              print(_tags);
                              int count = 0;
                              for (Asset image in images) {
                                var url = await saveImage(image,
                                    title + count.toString(), _companyname);
                                imageUrl.add(url.toString());
                                count += 1;
                              }
                              companyFirebaseServices.addProduct(
                                specialization: selectedSpecialization,
                                  title: this.title,
                                  tagLine: this.tagLine,
                                  description: this.description,
                                  uses: this.uses,
                                  webLink: this.webLink,
                                  tags: this._tags,
                                  imageUrl: this.imageUrl);
                              setState(() {
                                showSpinner = false;
                              });
//                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CompanyHomePage()));
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child: Text(
                                'Add Product',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
