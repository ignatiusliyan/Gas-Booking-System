import 'package:flutter/material.dart';

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_booking_system/Screens/Admin/Booking%20Screen.dart';
import 'package:gas_booking_system/Screens/Admin/Search%20Connection.dart';
import 'package:gas_booking_system/Screens/User/Booking%20History.dart';
import '../../Service/authenticate.dart';
import '../../main.dart';
import '../Admin/Admin Connections.dart';
import '../Admin/Registered Users.dart';
import 'Cyclinder Booking.dart';
import 'New Connection.dart';

class user_dashboard extends StatelessWidget {
  user_dashboard({super.key});

  bool isConnectionDone =false;
  String? uniqueid;

  String? userId=FirebaseAuthentication().currentuser()?.uid.toString();
  final databaseReference =FirebaseDatabase.instance.ref('Connections');

  static String generateUniqueId() {
    final random = Random();
    final uniqueId = random.nextInt(999999); // Generates a number between 0 to 999999
    return uniqueId.toString().padLeft(5, '0'); // Ensure it's a 6-digit string
  }


  final FirebaseAuth _auth = FirebaseAuthentication().getFirebaseInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false ,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Dashboard',
          style: TextStyle(
              color: Colors.white
          ),),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Text('Logged Out Successfully',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                )
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>adminOrUser()));
          }, icon:Icon(Icons.logout_sharp,color: Theme.of(context).colorScheme.background,))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            children: [
              const Spacer(),
              customContainer(context, Icons.add, '      New\nConnection', 'newconnection'),
              const Spacer(),
              customContainer(context, Icons.propane_tank_outlined, 'Cylinder\nBooking', 'cylinderbooking'),
              const Spacer()
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              const Spacer(),
              customContainer(context, Icons.history, 'Booking\nHistory', 'bookinghistory'),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
  Container customContainer(BuildContext context,icon,label,page){
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: (){
          if(page=='newconnection') {
            var connid =generateUniqueId().toString();
            databaseReference.child(userId!).set({
              'Connection Ref Number':connid,
              'Is Connection Done':'false'
            });

             Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>new_connection()));
          }else if(page=='cylinderbooking'){
            connectionSetter().then((value){
              if(value=='true'){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext) => cylinder_booking()));
              }else if(value=='false'){
                _dialogBuilder(context);
              }
            });

          }else if(page=='bookinghistory'){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>booking_history()));
          }else if(page=='ADMINregisteredusers'){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>registered_user()));
          } else if(page=='ADMINconnection'){
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>const admin_connections()));
          } else if(page=='ADMINbooking'){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>booking_list()));
          }else if(page=='ADMINsearch'){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>const search_connection()));
          }

        },
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,),
                const SizedBox(height: 10,),
                Text(label,
                  style: const TextStyle(
                      fontSize: 16
                  ),),
              ]
          ),
        ),
      ),
    );
  }

  //     Dialog BOX

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Connection Alert !',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  Divider(thickness: 0.5,)
                ],
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 8,right: 4),
                  child: Text('Please apply for New Connection before Booking Cylinder',
                    style: TextStyle(
                        fontSize: 14
                    )
                    ,)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<String?> connectionSetter() async {
    try{
      DataSnapshot snapshot = await databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).child('Is Connection Done').get();
      if(snapshot.value != null){
        print(snapshot.value.toString());
        return snapshot.value.toString();
      }else{
        print('null');
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }
}
