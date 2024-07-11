import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Service/authenticate.dart';

class search_connection extends StatefulWidget {
  const search_connection({super.key});

  @override
  State<search_connection> createState() => _search_connectionState();
}

class _search_connectionState extends State<search_connection> {

  List<String> customerdetails = [];
  List<String> personalDetails = [];
  String? Name = '';
  String? Email = '';
  String? Mobile = '';
  String? DOB = '';
  String? Gender = '';
  String? Mstatus = '';
  String? Address = '';

  final DatabaseReference reference =FirebaseDatabase.instance.ref('Connections');

  @override

  void fetchdata() async{
    String searchValue =_searchController.text;
    reference.orderByChild('Connection Ref Number')
        .equalTo(searchValue).once().then((DatabaseEvent snap) {
      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic>? data = snap.snapshot.value as Map<dynamic, dynamic>?;
        if(data!=null) {
          data.forEach((key, value) {
            customerdetails.add(value.toString());
          });
          String data1 =customerdetails[0].toString();
          // Extract 'Personal Details' section from the data
          String personalDetailsText = data1.split('Personal Details: ')[1];

          // Remove the closing curly brace at the end
          personalDetailsText = personalDetailsText.substring(0, personalDetailsText.length - 1);

          // Split the 'Personal Details' text into lines
          List<String> lines = personalDetailsText.split(', ');

          // Add each line to the personalDetails list
          personalDetails.addAll(lines);

          // Print the list of personal details

          setState(() {
            Email=personalDetails[0].substring(8);
            Address=personalDetails[1].substring(9);
            DOB=personalDetails[2].substring(5,15);
            Mobile=personalDetails[3].substring(7);
            Gender=personalDetails[4].substring(8);
            Mstatus=personalDetails[5].substring(16);
            String name =personalDetails[6].substring(6);
            Name=name.substring(0,name.length-1);
          });

        }

      } else {
        try {
          print('No data found for Connection: $searchValue');
        } catch (e, s) {
          print(s);
        }
      }
    });


  }

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Connection',style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children :[
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            color: Colors.grey.shade500,
                            width: 2.5
                        )
                    ),
                    padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 10),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none
                      ),
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red
                    ),
                    onPressed: (){
                      fetchdata();
                    },
                    child: const Text('Search')),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Customer Details',style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold,fontSize: 15),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(flex:4,child: Text('Name',style:TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 6,child: Text(':  '+Name.toString()))
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Mobile',style:TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 6,child: Text(':  '+Mobile.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Email',style:TextStyle(fontWeight: FontWeight.bold)),),
                          Expanded(flex: 6,child: Text(':  '+Email.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Date of Birth',style:TextStyle(fontWeight: FontWeight.bold)),),
                          Expanded(flex:6,child: Text(':  '+DOB.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Gender',style:TextStyle(fontWeight: FontWeight.bold)),),
                          Expanded(flex:6,child: Text(':  '+Gender.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Marital Status',style:TextStyle(fontWeight: FontWeight.bold)),),
                          Expanded(flex:6,child: Text(':  '+Mstatus.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:4,child: Text('Address',style:TextStyle(fontWeight: FontWeight.bold)),),
                          Expanded(flex:6,child: Text(':  '+Address.toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );

  }
}
// Container connectionSearch (){
//   return Container(
//     child: ,
//   );
// }

