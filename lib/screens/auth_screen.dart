import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  Future<void> login(String? email, String? password) async {
    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential;
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

    } on FirebaseAuthException catch (error) {
      String? message = 'An error occured, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> signup(
      String? email, String? phoneNo, String? password,bool isLogin, BuildContext ctx) async{
        UserCredential userCredential;
    
      try {
        setState(() {
           _isLoading = true;
        });

        userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
        

        await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'phoneNo': phoneNo,
        'uid': userCredential.user!.uid,});

        Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      }on FirebaseAuthException catch (error) {
      String? message = 'An error occured, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: AuthForm(signup, _isLoading, login),
    );
  }
}
