import 'package:flutter/material.dart';
import '../screens/amount_screen.dart';

class ServiceTile extends StatefulWidget {
  late final title;
  late final des;
  late final amount;
  late final quantity;

  ServiceTile({required this.title, required this.des,required this.amount,required this.quantity});

  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => AmountScreen(
                      title: widget.title,
                      des: widget.des,
                      amount: widget.amount,
                      quantity: widget.quantity,
                    )));
      },
      child: Container(
        height: 100,
        //padding: EdgeInsets.all(10),
        child: Card(
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.des,
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Quantity: " + widget.quantity.toString(),
                  ),
                ],
              ),
              Text(
                widget.amount + '₹',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
