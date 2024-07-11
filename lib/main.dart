import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/Admin/AdminLogin.dart';
import 'Screens/User/LoginPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas Booking',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.light(
          primary: Colors.red.shade500,
          background: Colors.white,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            User? user =snapshot.data;
            if(user==null){
              return adminOrUser();
            }
            else{
              return user_login_page();
            }
          }
          return adminOrUser();
        },
      ),
    );
  }
}

class adminOrUser extends StatelessWidget {
  const adminOrUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gas Booking System',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 60,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext)=>admin_login()));
                }, child: Text('Admin',
            style: TextStyle(
              fontSize: 16,
            ),)),
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    )
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext)=>user_login_page()));
                }, child: Text('User',
              style: TextStyle(
                fontSize: 16,
              ),)),
          ],
        ),
      ),
    );
  }
}
