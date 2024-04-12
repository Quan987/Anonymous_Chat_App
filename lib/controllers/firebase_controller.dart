import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hw4/models/add_user_model.dart';
import 'package:intl/intl.dart';

class FirebaseController {
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Singleton class
  FirebaseController._privateConstructor();
  static final FirebaseController instance =
      FirebaseController._privateConstructor();

  // Get user method
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get user uid method
  String getCurrentUserUid() {
    return _auth.currentUser!.uid;
  }

  // Get user snapshot document
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersCollection() {
    return _db.collection("users").snapshots();
  }

  // Login method
  Future<void> loginController(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Logout method
  Future<void> logout() async {
    return await _auth.signOut();
  }

  // User registration
  Future<void> addUserController(String fname, String lname, String username,
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String currentUserId = getCurrentUser()!.uid;
      final String currentDate =
          DateFormat("yyyy-MM-dd").format(DateTime.now());
      AddUser newUser = AddUser(
        firstName: fname,
        lastName: lname,
        userName: username,
        email: email,
        password: password,
        uid: currentUserId,
        dateTime: currentDate,
      );

      // Create a users collection with each doc correspond to one user each
      var db = _db.collection("users");
      // Get all document snapshot
      QuerySnapshot querySnapshot = await _db.collection("users").get();
      int count = querySnapshot.docs.length;
      String newDoc = "user-${count + 1}";

      // Add new user to database
      await db.doc(newDoc).set(newUser.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Send Message Method
  Future<void> sendMessage(String receiverID, String message) async {
    final Timestamp timestamp = Timestamp.now();
    final String senderID = getCurrentUserUid();
    late String email;
    late String firstName;
    Stream<QuerySnapshot> snapshot = getUsersCollection();
    snapshot.listen((event) async {
      for (var doc in event.docs) {
        if (senderID == await doc.get("id")) {
          email = await doc.get("email");
          firstName = await doc.get("fname");
          break;
        }
      }

      // Add message to database
      List<String> chatID = [senderID, receiverID];
      chatID.sort();
      String chatRoom = chatID.join("-");
      await _db
          .collection("chatRoom")
          .doc(chatRoom)
          .collection("messages")
          .add({
        "senderID": senderID,
        "senderEmail": email,
        "senderName": firstName,
        "receiverID": receiverID,
        "time": timestamp,
        "message": message,
      });
      return;
    });
  }

  // Get Message Method
  Stream<QuerySnapshot> getMessage(String senderID, String receiverID) {
    List<String> chatID = [senderID, receiverID];
    chatID.sort();
    String chatRoom = chatID.join("-");
    return _db
        .collection("chatRoom")
        .doc(chatRoom)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots();
  }
}
