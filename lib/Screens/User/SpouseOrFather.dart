import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/Dashboard.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import '../../Service/authenticate.dart';

class spouseOrFather extends StatefulWidget {
  const spouseOrFather({super.key});

  @override
  State<spouseOrFather> createState() => _spouseOrFatherState();
}

final databaseReference =FirebaseDatabase.instance.ref("Connections");
final FirebaseAuth auth =  FirebaseAuthentication().getFirebaseInstance();
final User? currentUser = auth.currentUser;

class _spouseOrFatherState extends State<spouseOrFather> {

  final TextEditingController _fullNameController =TextEditingController();
  final TextEditingController _lastController =TextEditingController();
  final TextEditingController _sofAddressController =TextEditingController();
  final TextEditingController _ctvController =TextEditingController();
  final TextEditingController _pincodeController =TextEditingController();
  int selectedSpouseORFather=-1;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key:formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Spouse or Father Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),)
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Text('Select Related',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    Radio(
                        value: 0,
                        groupValue:selectedSpouseORFather,
                        onChanged: (value){
                          setState(() {
                            selectedSpouseORFather=value!;
                          });
                        }
                    ),
                    const Text('Spouse'),
                    Radio(
                        value: 1,
                        groupValue:selectedSpouseORFather,
                        onChanged: (value){
                          setState(() {
                            selectedSpouseORFather=value!;
                          });
                        }
                    ),
                    const Text('Father')
                  ],
                ),
                const Text('FullName',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: _fullNameController,
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r'^[ .a-z A-Z. ]+$').hasMatch(value))
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
                // SizedBox(height: 5,),
                // Text('Last Name',
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold
                //   ),),
                // SizedBox(height: 5,),
                // TextFormField(
                //   controller: _lastController,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder()
                //   ),
                // ),
                const SizedBox(height: 5,),
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
                  controller: _sofAddressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Expanded(
                        flex: 4,
                        child: Text('City / Town / Village',style: TextStyle(fontWeight: FontWeight.bold),)),
                    Expanded(
                        flex: 6,
                        child:TextFormField(
                          controller: _ctvController,
                          validator: (value){
                            if(value!.isEmpty ||!RegExp(r'^[a-z A-Z]+$').hasMatch(value))
                            {
                              return "Enter valid City/Town/Village";
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()
                          ),
                        ) )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 5,),
                    const Expanded(
                        flex: 4,
                        child: Text('Pincode',
                          style: TextStyle(
                            //fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),)),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty ||!RegExp(r"^(?:[+0]9)?[0-9]{6}$").hasMatch(value))
                          {
                            return "Enter valid pincode";
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder()
                        ),
                        controller: _pincodeController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                // Row(
                //   children: [
                //     Expanded(
                //         flex: 6,
                //         child: Text('ID Proof')),
                //     Expanded(
                //       flex: 4,
                //       child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //               backgroundColor: Theme.of(context).colorScheme.primary,
                //               foregroundColor: Theme.of(context).colorScheme.background,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(5)
                //               )
                //           ),
                //           child: Text('UPLOAD FILE'),
                //           onPressed: () async {
                //             pickedfile!;
                //           }
                //       ),
                //     )
                //   ],
                // ),
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
                            try {
                              if (selectedSpouseORFather == 1) {
                                databaseReference.child(
                                    FirebaseAuthentication().currentuser()!
                                        .uid.toString()).child(
                                    'Father Details').set({
                                  ' Father Name': _fullNameController.text,
                                  'City & Town & Village': _ctvController.text,
                                  'Pin code': _pincodeController.text,
                                  'Address': _sofAddressController.text
                                });
                                databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).update({
                                  'Is Connection Done' : 'true'
                                });
                              }
                              else {
                                databaseReference.child(
                                    FirebaseAuthentication().currentuser()!
                                        .uid.toString()).child(
                                    'Spouse Details').set({
                                  'Spouse Name': _fullNameController.text,
                                  'City & Town & Village': _ctvController.text,
                                  'Pin code': _pincodeController.text,
                                  'Address': _sofAddressController.text
                                });
                                databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).update({
                                  'Is Connection Done' : 'true'
                                });
                              }
                            }catch(e) {
                              print('___________Firebase Error__________ $e');
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  content: Text('Connection registeration completed successfully',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                                )
                            );

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>AnimatedSplashScreen(
                                    backgroundColor: Theme.of(context).colorScheme.background,
                                    splashIconSize: 300,
                                    splashTransition: SplashTransition.fadeTransition,
                                    duration: 5000,
                                    splash:Column(
                                      children: [
                                        Center(
                                          child: Lottie.network('https://lottie.host/5cbd3001-5215-44cf-8e4f-7e990c5c3adb/FXqJDTpH82.json',
                                              width: 200,
                                              height: 200,
                                              animate: true,
                                              repeat: false
                                          ),
                                        ),
                                        const Center(
                                            child:Text('Your Connection request received successfully',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),)
                                        ),
                                        const SizedBox(height: 10,),
                                        const Center(
                                            child:Text('You can book cylinder after the approval of Connection',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),)
                                        )
                                      ],
                                    ) , nextScreen: user_dashboard())));

                          }
                        },
                        child: const Text('Submit'))
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
