import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/LoginPage.dart';

import 'Dashboard.dart';

class admin_login extends StatelessWidget {
  admin_login({super.key});

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Form(
        key: formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Admin Login',style: TextStyle(
                  fontSize: 24
                ),),
                SizedBox(height: 10,),
                user_login_page().customTextForm(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}", _emailController,'Email',false),

                user_login_page().customTextForm(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$", _passwordController,'Password',true),

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
                          if(_emailController.text=='leewanfdo@gmail.com' && _passwordController.text=='Ignatius@1304'){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>admin_dashboard()));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  content: Text('Invalid Email or Password',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                                )
                            );
                          }
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
                    Text('I\'m not an admin '),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>user_login_page()));
                      },
                      child: Text('User Login',style: TextStyle(
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
}
