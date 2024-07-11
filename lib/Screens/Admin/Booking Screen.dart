

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Service/authenticate.dart';

import 'booking_details.dart';

class booking_list extends StatelessWidget {
  booking_list({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Bookings'),
      ),
      body: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('Bookings'),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            return GestureDetector(
              onTap: (){
                String name = snapshot.child('Name').value.toString();
                String email = snapshot.child('Email').value.toString();
                String connectionNumber = snapshot.child('Connection Ref Number').value.toString();
                String mobile=snapshot.child('Mobile').value.toString();
                String type=snapshot.child('Gas Type').value.toString();
                String address=snapshot.child('Shipping Adddress').value.toString();
                String approved=snapshot.child('IsApproved').value.toString();
                String amount=snapshot.child('AmountHasToPay').value.toString();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>booking_details(
                  Name:name,
                  Type:type,
                  Mobile: mobile,
                  Email:email,
                  address: address,
                  ConnectionRefNumber: connectionNumber,
                  uid:snapshot.key.toString(),
                  Approved: approved,
                  Amount:amount
                )));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5,right: 10,left: 10,bottom: 5),
                child: Card(
                  color: Colors.grey.shade100,
                  child:ListTile(
                    title: Text('Name : '+snapshot.child('Name').value.toString()),
                    subtitle: Row(
                      children: [
                        Text('Connection Number : ',),
                        Text(snapshot.child('Connection Ref Number').value.toString(),style: TextStyle(color: Colors.red),)
                      ],
                    ),
                  )
                ),
              ),
            );
          },

        )
        );
  }
}
