import 'package:company/constants.dart';
import 'package:company/widgets/message_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWindow extends StatefulWidget {
  ChatWindow({this.reciever, this.sender});
  final String reciever;
  final String sender;

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow>
    with SingleTickerProviderStateMixin {
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  String reciever;
  String sender;
  String messageText;

  @override
  void initState() {
    reciever = widget.reciever;
    sender = widget.sender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EFFA),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kDoctorPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
        centerTitle: true,
        title: Text(
          reciever,
          style: TextStyle(color: Colors.black, fontFamily: 'Viga'),
        ),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQuIM2Kwi_1IOCBHfB3z2CZWpjl7igvaMpYZw&usqp=CAU'),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ignore: missing_return
          Expanded(
            child: StreamBuilder(
                stream: _firestore
                    .collection('hosptial')
                    .doc('chats')
                    .collection(sender)
                    .doc(reciever)
                    .collection(reciever)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  print('Yes');
                  print(snapshot.hasData);
                  try {
                    if (snapshot.data.docs.length != 0) {
                      final messages = snapshot.data.docs;
                      List<MessageBuilder> messageWidgets = [];
                      for (var message in messages.reversed) {
                        final messageText = message.data()['text'].toString();
                        final messageSender =
                            message.data()['sender'].toString();
                        MessageBuilder build = MessageBuilder(
                          sender: messageSender,
                          text: messageText,
                          currentProfile: sender,
                        );
                        messageWidgets.add(build);
                        print('$messageSender $messageText');
                      }
                      return Expanded(
                        child: ListView(
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          children: messageWidgets.reversed.toList(),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Text('No messages found'),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                    return Expanded(
                      child: Center(
                        child: Text('No messages found'),
                      ),
                    );
                  }
                }),
          ),
//          Expanded(
//            child: ListView(
//              reverse: true,
//              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//              children: [
//                MessageBuilder(),
//
//              ],
//            ),
//          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore
                        .collection('hosptial')
                        .doc('chats')
                        .collection(sender)
                        .doc(reciever)
                        .collection(reciever)
                        .add({
                      'text': messageText,
                      'timestamp':
                          DateTime.now().toUtc().millisecondsSinceEpoch,
                      'sender': sender
                    });
                    _firestore
                        .collection('hosptial')
                        .doc('chats')
                        .collection(reciever)
                        .doc(sender)
                        .collection(sender)
                        .add({
                      'text': messageText,
                      'timestamp':
                          DateTime.now().toUtc().millisecondsSinceEpoch,
                      'sender': sender
                    });
                    _firestore
                        .collection('hosptial')
                        .doc('chats')
                        .collection(sender)
                        .doc(reciever)
                        .set({'name': reciever, 'final_text': messageText});
                    _firestore
                        .collection('hosptial')
                        .doc('chats')
                        .collection(reciever)
                        .doc(sender)
                        .set({'name': sender, 'final_text': messageText});


                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
