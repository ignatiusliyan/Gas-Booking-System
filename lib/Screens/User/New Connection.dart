import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gas_booking_system/Screens/User/Dashboard.dart';

import '../../Service/authenticate.dart';
import 'SpouseOrFather.dart';

class new_connection extends StatefulWidget {
  new_connection({super.key});

  @override
  State<new_connection> createState() => _new_connectionState();
}
final databaseReference =FirebaseDatabase.instance.ref("Connections");
final FirebaseAuth auth =  FirebaseAuthentication().getFirebaseInstance();
final User? currentUser = auth.currentUser;

class _new_connectionState extends State<new_connection> {
  final formKey=GlobalKey<FormState>();

  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _phoneController =TextEditingController();
  final TextEditingController _addressController =TextEditingController();



  int selectedGenderValue=-1;
  int selectedSpouseORFather=-1;
  List gender=['Male','Female'];
  DateTime selectedDate =DateTime.now();
  int selectedMatrialStatus=-1;

  String? uniqueid=user_dashboard.generateUniqueId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('New Connection',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New Connection Registeration',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
                const SizedBox(height: 10,),
                Center(
                  child: Text('Connection Number : $uniqueid ',style: const TextStyle(
                      color: Colors.red
                  ),),
                ),
                const SizedBox(height: 10,),
                const Text('Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: _nameController,
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r'^[ . a-z A-Z a-z A-Z a-z A-Z. ]+$').hasMatch(value))
                    {
                      return "Enter valid name";
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 5,),
                Text('Email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _emailController,
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(value!))
                    {
                      return "Enter valid email";
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Mobile Number',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: _phoneController,
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value))
                    {
                      return "Enter valid phone";
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 5,),
                    const Text('Gender',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    const SizedBox(width: 30,),
                    Radio(
                        value: 0,
                        groupValue: selectedGenderValue,
                        onChanged:(value){
                          setState(() {
                            selectedGenderValue=value!;
                          });
                        }
                    ),
                    const Text('Male'),
                    Radio(
                        value: 1,
                        groupValue: selectedGenderValue,
                        onChanged:(value){
                          setState(() {
                            selectedGenderValue=value!;
                          });
                        }
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 5,),
                    const Text('Date of Birth',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 28,),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        controller: TextEditingController(
                          text: DateFormat.yMMMd().format(selectedDate),
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          suffixIcon: Icon(Icons.calendar_month_sharp,color: Colors.red,),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Text('Marital Status',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 5,),
                    Radio(
                        value: 0,
                        groupValue:selectedMatrialStatus,
                        onChanged: (value){
                          setState(() {
                            selectedMatrialStatus=value!;
                          });
                        }
                    ),
                    const Text('Maried'),
                    Radio(
                        value: 1,
                        groupValue:selectedMatrialStatus,
                        onChanged: (value){
                          setState(() {
                            selectedMatrialStatus=value!;
                          });
                        }
                    ),
                    const Text('UnMaried')
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    SizedBox(width: 5,),
                    Text('Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red
                        ),
                        onPressed: (){

                          if(formKey.currentState!.validate()) {
                            databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).child('Personal Details').set({
                              'Name': _nameController.text,
                              'Email':_emailController.text,
                              'Phone':_phoneController.text,
                              'Gender':selectedGenderValue==0 ? 'Male' : 'Female',
                              'DOB':selectedDate.toString(),
                              'Marital Status':selectedMatrialStatus==0 ? 'Maried' : 'UnMaried',
                              'Address':_addressController.text
                            });

                            FirebaseDatabase.instance.ref("Bookings")
                                .child(FirebaseAuthentication().currentuser()!.uid.toString())
                                .set({
                              'IsApproved':'false',
                              'AmountHasToPay':0.toString(),
                            });

                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext) => const spouseOrFather()));
                          }
                        },
                        child: const Text('Next'))
                  ],)

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      // Do something with the selected date
      setState(() {
        selectedDate=picked;
      });
    }
  }
}
