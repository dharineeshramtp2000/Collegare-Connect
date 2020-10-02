import 'package:company/constants.dart';
import 'package:company/screens/chat_window.dart';
import 'package:company/services/chat_list_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat_screen.dart';

String _idpat = '';
class ChatListPatient extends StatefulWidget {

  @override
  _ChatListPatientState createState() => _ChatListPatientState();
}

class _ChatListPatientState extends State<ChatListPatient> {
  final _firestore = FirebaseFirestore.instance;
  String currentProfile;
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
    getUserInfogetChats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFE7EFFA),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('hosptial')
                .doc('chats')
                .collection(_idpat)
                .snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              List<ChatListDetails> contactsList = [];

              try {
                if (snapshot.data.docs.length != 0) {
                  final documents = snapshot.data.docs.reversed;
                  for (var document in documents) {
                    final name = document.data()['name'].toString();
                    final finalText = document.data()['final_text'].toString();

                    ChatListDetails details = ChatListDetails(name, finalText);
                    contactsList.add(details);
                  }
                  print(contactsList.length);
                  return ListView.builder(
                      itemCount: contactsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatWindow(sender: _idpat, reciever: contactsList[index].contact,)));
                          },
                          child: Container(
                            height: 80.0,
                            color: Color(0xFFE7EFFA),
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQuIM2Kwi_1IOCBHfB3z2CZWpjl7igvaMpYZw&usqp=CAU'),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          contactsList[index].contact,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Viga'),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          contactsList[index].finalText,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.black54,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                else {
                  return Container(
                    child: Center(
                      child: Text(
                        'Not connected with anyone. Just Collegare!!',style: TextStyle(color: kDoctorPrimaryColor),),
                    ),
                  );
                }
              }catch(e){
                return Container(
                  child: Center(
                    child: Text(
                      'Not connected with anyonw. Just Collegare!!',style: TextStyle(color: kDoctorPrimaryColor),),
                  ),
                );
              }
            }));
  }
}
