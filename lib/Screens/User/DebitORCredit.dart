import 'package:flutter/material.dart';

class debit_credit extends StatefulWidget {
  debit_credit({super.key});

  @override
  State<debit_credit> createState() => _debit_creditState();
}

class _debit_creditState extends State<debit_credit> {
  final TextEditingController CardNumcontroller =TextEditingController();
  final TextEditingController CVVcontroller =TextEditingController();
  final TextEditingController Namecontroller =TextEditingController();


  String dropdownvalue = 'Month';
  String dropdownvalue1 = 'Year';
  // List of items in our dropdown menu
  var items = [
    'Month',
    'January (01)',
    'February (02)',
    'March (03)',
    'April (04)',
    'May (05)',
    'June (06)',
    'July (07)',
    'August (08)',
    'September (09)',
    'October (10)',
    'November (11)',
    'December (12)',
  ];

  var items1 = [
    'Year',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031','2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debit/Credit Card Details'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Card Number'),flex: 4,),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Colors.grey.shade500,
                                width: 1.5
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                          // validator: (value){
                          //   if(value!.isEmpty || !RegExp(regexp).hasMatch(value)){
                          //     return "Enter valid $name";
                          //   }
                          //   else{
                          //     return null;
                          //   }
                          // },
                          controller: CardNumcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                                            ),
                        ),
                      ),flex: 6,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 4,child: Text('Month')),
                    Expanded(
                      flex: 6,
                        child: DropdownButton(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex:4,
                child: Text('Year')),
                    Expanded(
                      flex: 6,
                      child:DropdownButton(

                        // Initial Value
                        value: dropdownvalue1,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items1.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue1 = newValue!;
                          });
                        },
                      ),  )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: [
                  Expanded(child: Text('CVV'),flex: 4,),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.grey.shade500,
                              width: 1.5
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          obscureText: true,
                          // validator: (value){
                          //   if(value!.isEmpty || !RegExp(regexp).hasMatch(value)){
                          //     return "Enter valid $name";
                          //   }
                          //   else{
                          //     return null;
                          //   }
                          // },
                          controller: CVVcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),flex: 6,)
                ],
              ),),
              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Name as on Card'),flex: 4,),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Colors.grey.shade500,
                                width: 1.5
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            obscureText: true,
                            // validator: (value){
                            //   if(value!.isEmpty || !RegExp(regexp).hasMatch(value)){
                            //     return "Enter valid $name";
                            //   }
                            //   else{
                            //     return null;
                            //   }
                            // },
                            controller: Namecontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),flex: 6,)
                  ],
                ),),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red
                  ),
                  onPressed: (){
                    //TODO Animation for the Completion for New Connection and Cyclinder Booking and also this Page
                    // Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext)=>patmentOption()));
                  },
                  child: const Text('Proceed'))
            ],
          ),
        ),
      ),
    );
  }
}
