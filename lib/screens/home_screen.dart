import 'package:flutter/material.dart';
import 'package:payment_test/widgets/firebase_method.dart';
import '../widgets/service_tile.dart';
import '../modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'Logout',
                ),
              ],
              onChanged: (itemIndentifier) {
                if (itemIndentifier == 'Logout') {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                }
              })
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ServiceTile(
            title: productList[index].title,
            des: productList[index].description,
            amount: productList[index].amount,
            quantity: productList[index].quantity,
          );
        },
      ),
    );
  }
}
