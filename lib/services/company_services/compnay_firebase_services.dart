import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _comp = '';
String _companyname='';
class CompanyFirebaseServices {
  final _firestore = FirebaseFirestore.instance;
  void addProduct(
      {List<String> tags,
      String title,
      String tagLine,
      String description,
      String uses,
      String webLink,
      List<String> imageUrl,
  String specialization}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _comp = prefs.getString('comp');
    _companyname =prefs.getString('company_name');
    _firestore
        .collection('company')
        .doc('all_companies')
        .collection(_companyname).doc('products').collection('${_companyname}_products')
        .add({
      'Name': title,
      'TagLine': tagLine,
      'Description': description,
      'Usage_Features': uses,
      'Weblink': webLink,
      'Tags': tags,
      'images': imageUrl
    });

    _firestore
        .collection('hosptial')
        .doc('medicine_products')
        .collection(specialization)
        .add({
      'Sender' :_comp,
      'Company' : _companyname,
      'Name': title,
      'TagLine': tagLine,
      'Description': description,
      'Usage_Features': uses,
      'Weblink': webLink,
      'Tags': tags,
      'images': imageUrl
    });

    _firestore
        .collection('news_feed')
        .add({
      'Sender' :_comp,
      'Company' : _companyname,
      'Name': title,
      'TagLine': tagLine,
      'Description': description,
      'Usage_Features': uses,
      'Weblink': webLink,
      'Tags': tags,
      'images': imageUrl
    });
  }
}

