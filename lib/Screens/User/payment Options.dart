import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/DebitORCredit.dart';
import 'package:gas_booking_system/Screens/User/Payment.dart';

class patmentOption extends StatelessWidget {
  const patmentOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("Payment Options"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20,right: 8,left: 8,bottom: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>debit_credit()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // Optional: Gives rounded corners
                  side: BorderSide(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: ListTile(
                  title: Text('   Debit/Credit Card'),
                  leading: Icon(Icons.payment_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,right: 8,left: 8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>payment()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // Optional: Gives rounded corners
                  side: BorderSide(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: ListTile(
                  title: Text('UPI'),
                  leading: Image.asset('images/Upi_final.png',width: 40,height: 40,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  }
  

