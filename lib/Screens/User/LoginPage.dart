import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'SignUpPage.dart';

class user_login_page extends StatelessWidget {
  user_login_page({super.key});

  final FirebaseAuth _auth =FirebaseAuth.instance;

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();

  final formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('User Login',style: TextStyle(
                  fontSize: 24,
                ),),
                SizedBox(height: 10,),
                customTextForm(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",_emailController,'Email',false),
                SizedBox(height: 10,),
                customTextForm(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$",_passwordController,'Password',true),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){
                        if(formkey.currentState!.validate()){
                          signInUser(context);
                        }
                      }, child: Text('Login',
                    style: TextStyle(
                      fontSize: 16,
                    ),)),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I don\'t have an account '),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>signUpPage()));
                      },
                      child: Text('SignUp',style: TextStyle(
                        color: Colors.blue,
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Padding customTextForm(regexp,controller,name,textobscure){
    return Padding(
        padding: EdgeInsets.only(
          right: 15,left: 15,top: 10,bottom: 5,
        ),
      child: TextFormField(
        obscureText: textobscure,
        validator: (value){
          if(value!.isEmpty || !RegExp(regexp).hasMatch(value)){
            return "Enter valid $name";
          }
          else{
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          label: Text(name),
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  void signInUser(BuildContext context) async{
    String email =_emailController.text;
    String password =_passwordController.text;

    UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseAuth.instance.authStateChanges();
    print('User is successfullly SignedIn');
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>user_dashboard()));
  }

}


