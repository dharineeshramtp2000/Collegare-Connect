import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("students").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addUserInfowithsec(year,userData) async {
    Firestore.instance.collection(year).add(userData).catchError((e) {
      print(e.toString());
    });
  }

  Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('teachers')
        .where('userEmail', isEqualTo: name)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }
getUserInfo(String id) async {
    // ignore: deprecated_member_use
    return Firestore.instance
        .collection("hosptial")
        .where("id", isEqualTo: id)
        .limit(1)
        // ignore: deprecated_member_use
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfoS(String email) async {
    return Firestore.instance
        .collection("hosptial")
        .where("id", isEqualTo: email)
        .limit(1)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  getIdInfo(String id) async {
    return Firestore.instance
        .collection("teachers")
        .where("userid", isEqualTo: id)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }
get(String email)async {
  return await Firestore.instance.collection('hospital').where(
      "id",
      isEqualTo: email
  ).getDocuments().catchError((e) => print("error fetching data: $e"));
}

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){

    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("techers")
        .where('userEmail', isEqualTo: itIsMyName)

        .snapshots();
  }

}


