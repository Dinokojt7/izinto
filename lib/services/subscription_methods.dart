// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// import '../models/user.dart';
//
// class SubscriptionMethods {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final user = Provider.of<UserModel?>(_auth.currentUser);
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   SubscriptionModel? _userFromFirebaseUser(int? status) {
//     return status != null
//         ? SubscriptionModel(
//       uid: status,
//     )
//         : null;
//   }
//
//   //AUTH CHANGE USER STREAM
//   Stream<SubscriptionModel?> get status {
//     return _firebaseFirestore.collection('users').doc(_auth.currentUser).get()
//     //return _firebaseFirestore.authStateChanges().map(_userFromFirebaseUser);
//   }
// }
