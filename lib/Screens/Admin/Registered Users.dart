import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Service/authenticate.dart';

class registered_user extends StatefulWidget {
  const registered_user({super.key});

  @override
  State<registered_user> createState() => _registered_userState();
}
String? userId =FirebaseAuth.instance.currentUser?.uid.toString();

class _registered_userState extends State<registered_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Registered Users',
            style: TextStyle(
                color: Colors.white
            ),),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref('SignUp'), itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text('Name : ${snapshot.child('Name').value.toString()}',style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text('Email : ${snapshot.child('Email').value.toString()}'),
                      ),
                    ),
                  ),
                );
              },),
            ),
          ],
        )
    );
  }
}
