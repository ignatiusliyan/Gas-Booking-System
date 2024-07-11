import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/LoginPage.dart';

import '../../Service/authenticate.dart';

class signUpPage extends StatelessWidget {
  signUpPage({super.key});

  final DatabaseReference reference =FirebaseDatabase.instance.ref('SignUp');

  final FirebaseAuth _auth =FirebaseAuth.instance;
  final formkey =GlobalKey<FormState>();
  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final TextEditingController _rePasswordController =TextEditingController();
  final TextEditingController _phoneController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text('User Registration',style: TextStyle(
                    fontSize: 24,
                  ),),
                  SizedBox(height: 10,),
                  user_login_page().customTextForm(r"^[.a-z A-Z a-z A-Z.]+$", _nameController,'Name', false),

                  user_login_page().customTextForm(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}", _emailController,'Email', false),

                  user_login_page().customTextForm(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$", _passwordController,'Password', true),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,color: Colors.green,),
                        SizedBox(width: 5,),
                        Text('Password must contain ',style: TextStyle(
                          color: Colors.green
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Text(' • Minimum 8 Characters \n • 1 Upper Case and Lower Case \n • 1 Number and Symbol',style: TextStyle(color: Colors.green),),
                      ],
                    ),
                  ),
                  user_login_page().customTextForm(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$", _rePasswordController,'Re Enter Password', true),

                  user_login_page().customTextForm(r"^(?:[+0]9)?[0-9]{10}$", _phoneController, 'Phone', false),
                  SizedBox(height: 15,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){
                         createUser(context);
                      }, child: Text('SignUp',
                    style: TextStyle(
                      fontSize: 16,
                    ),)),

                ],
              ),
            ),
          )),
    );
  }

  void createUser(BuildContext context)async {
    if(formkey.currentState!.validate()){
      String email =_emailController.text;
      String password =_passwordController.text;

      UserCredential? user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.authStateChanges();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text('User created successfully',style: TextStyle(color: Theme.of(context).colorScheme.background),),
          )
      );
      reference.child(FirebaseAuthentication().currentuser()!.uid.toString()).set(
          {
            'Name':_nameController.text,
            'Email':_emailController.text,
            'Phone':_phoneController.text
          });
      print('User is Successfully created');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>user_login_page()));
    }
  }
}
