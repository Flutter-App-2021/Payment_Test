import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payment_test/constant/contants.dart';

getUserDetails() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((val) {
    //Constant(email: val['email'], phoneNo: val['phoneNo']);
    Constant.phoneNo = val['phoneNo'];
    Constant.email = val['email'];
    print(Constant.email);
    print(Constant.phoneNo);
    print('This is the data i have');
    print(val['email']);
    print(val['phoneNo']);
  });
}
