import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payment_test/modal.dart';
import 'package:payment_test/screens/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../constant/contants.dart';

class AmountScreen extends StatefulWidget {
  late final amount;
  late final title;
  late final des;
  late final quantity;

  AmountScreen({
    required this.title,
    required this.des,
    required this.amount,
    required this.quantity,
  });

  @override
  _AmountScreenState createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  Razorpay _razorpay = new Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, paymentExternal);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  paymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: widget.title + " Purchase Successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0);

    //Update quantity...
    var index =
        productList.indexWhere((element) => element.title == widget.title);
    productList[index].quantity += 1;
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }

  paymentError(PaymentFailureResponse response) {
    print('Payment not successful');
    Fluttertoast.showToast(
        msg: "ERROR: Payment Unsuccessful.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // String number = Constant.phoneNo;
  // String emailId = Constant.email;
  paymentExternal() {}

  payment() async {
    int amountToPay = int.parse(widget.amount) * 100;
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('rzp_live_AIDprwrvRi4FNB:8numG7sg5lXDQZu10rohOUrD'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(
        utf8.encode(json.encode({"amount": amountToPay, "currency": "INR"})));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      print('ORDERID' + contents);
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);
      print("Here is the orderId: $orderId");
      var options = {
        'key': 'rzp_live_AIDprwrvRi4FNB',
        'amount': amountToPay,
        'name': widget.title,
        "currency": "INR",
        'description': widget.des,
        'order_id': orderId,
        'prefill': {
          'contact': "",
          'email': ""
        },
        'external': {
          "wallets": ["paytm"]
        }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Amount'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Amount: ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.amount,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: payment,
                child: Text('Pay Now'),
              )
            ],
          ),
        ));
  }
}
