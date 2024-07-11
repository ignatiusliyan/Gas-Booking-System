import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../User/Dashboard.dart';
import 'AdminLogin.dart';

class admin_dashboard extends StatelessWidget {
  admin_dashboard({super.key});

  // final FirebaseAuth _auth = FirebaseAuthentication().getFirebaseInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Admin Dashboard',style: TextStyle(
            color: Colors.white
        ),
          textAlign: TextAlign.center,),
        actions: [
          IconButton(onPressed: (){
            // _auth.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Text('Logged Out Successfully',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                )
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>admin_login()));
          }, icon:Icon(Icons.logout_sharp,color: Theme.of(context).colorScheme.background,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                const Spacer(),

                user_dashboard().customContainer(context, Icons.person, 'Registered\n    Users', 'ADMINregisteredusers'),

                const Spacer(),

                user_dashboard().customContainer(context, Icons.link_outlined, 'Connections', 'ADMINconnection'),

                const Spacer()
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Spacer(),

                user_dashboard().customContainer(context, Icons.list, 'Bookings', 'ADMINbooking'),
                const Spacer(),

                user_dashboard().customContainer(context, Icons.search, '     Search\nConnections', 'ADMINsearch'),

                const Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
