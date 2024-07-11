import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'Connection Details.dart';

class admin_connections extends StatefulWidget {
  const admin_connections({super.key});

  @override
  State<admin_connections> createState() => _admin_connectionsState();
}

String? userId =FirebaseAuth.instance.currentUser?.uid.toString();

class _admin_connectionsState extends State<admin_connections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Connections',style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref('Connections'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return GestureDetector(
                    onTap: (){
                      String name = snapshot.child('Personal Details').child('Name').value.toString();
                      String connectionNumber = snapshot.child('Connection Ref Number').value.toString();
                      String mobile=snapshot.child('Personal Details').child('Phone').value.toString();
                      String gender=snapshot.child('Personal Details').child('Gender').value.toString();
                      String maritalStatus=snapshot.child('Personal Details').child('Marital Status').value.toString();
                      String dob=snapshot.child('Personal Details').child('DOB').value.toString();
                      String address=snapshot.child('Personal Details').child('Address').value.toString();
                      String approve=snapshot.child('Is Connection Approved').value.toString();
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>details_screen(
                        Name:name,
                        Gender: gender,
                        DOB: dob,
                        MaritalStatus: maritalStatus,
                        Mobile: mobile,
                        Address: address,
                        ConnectionNum: connectionNumber,
                        Approved: approve,
                        uid: snapshot.key.toString(),
                      )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 5,right: 10,left: 10,bottom: 5),
                      child: Card(
                        color: Colors.grey.shade100,
                        child: ListTile(
                          title: Text('Name : '+snapshot.child('Personal Details').child('Name').value.toString()),
                          subtitle: Text('Connection Number : '+snapshot.child('Connection Ref Number').value.toString()),
                        ),
                      ),
                    ),
                  );
                },

              ))
        ],
      ),
    );
  }
}
