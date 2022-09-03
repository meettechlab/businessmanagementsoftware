import 'dart:async';

import 'package:businessmanagementsoftware/screens/manage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool? _process;
  int? _count;

  @override
  void initState() {
    super.initState();
    _process = false;
    _count = 1;
  }

  @override
  Widget build(BuildContext context) {
    final userField = Container(
        width: MediaQuery.of(context).size.width / 4,
        child: TextFormField(
            cursorColor: Colors.brown,
            autofocus: false,
            controller: userEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Field cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              userEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.brown),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.brown),
              ),
            )));
    final passwordField = Container(
        width: MediaQuery.of(context).size.width / 4,
        child: TextFormField(
            obscureText: true,
            cursorColor: Colors.brown,
            autofocus: false,
            controller: passwordEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Field cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              passwordEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.brown),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.brown),
              ),
            )));

    final addButton = Material(
      elevation: (_process!) ? 0 : 5,
      color: (_process!) ? Colors.brown.shade800 : Colors.brown,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          150,
          25,
          150,
          25,
        ),
        minWidth: MediaQuery.of(context).size.width / 4,
        onPressed: () {
          setState(() {
            _process = true;
            _count = (_count! - 1);
          });
          (_count! < 0)
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red, content: Text("Wait Please!!")))
              : AddData();
        },
        child: (_process!)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Processing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ))),
                ],
              )
            : Text(
                'Login',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
      Center(
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/demo.jpg"), fit: BoxFit.cover,opacity: 0.7),
      ),
    ),
    ),
       Center(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               width: MediaQuery.of(context).size.width/2,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Form(
                 key: _formKey,
                 child: Column(
                   children: [
                     // Center(
                     //   child: Image.asset(
                     //     'assets/images/logo.png',
                     //     fit: BoxFit.contain,
                     //     width: MediaQuery.of(context).size.width / 2,
                     //     height: MediaQuery.of(context).size.height / 2,
                     //   ),
                     // ),
                     SizedBox(height: 50,),
                     Center(
                       child: Container(
                         width: MediaQuery.of(context).size.width/5,
                         // height: MediaQuery.of(context).size.height/15,
                         padding: EdgeInsets.fromLTRB(10, 7, 10,7),
                         decoration: BoxDecoration(
                           color: Colors.brown,
                           borderRadius: BorderRadius.circular(5),
                         ),
                         child: Center(
                           child: Text(
                             'Camera Square',
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white,
                                 fontSize: 30),
                           ),
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 30,
                     ),
                     userField,
                     SizedBox(
                       height: 10,
                     ),
                     passwordField,
                     SizedBox(
                       height: 20,
                     ),
                     addButton,
                     SizedBox(
                       height: 10,
                     ),
                     Center(
                       child: Column(
                         children: [
                           Text(
                             'developed by',
                             style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                           Image.asset(
                             'assets/images/company.png',
                             fit: BoxFit.fitHeight,
                             width: MediaQuery.of(context).size.width / 7,
                             height: MediaQuery.of(context).size.height / 7,
                           ),
                           Text(
                             'MEETTECH LAB',
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.pinkAccent),
                           ),
                           SizedBox(
                             height: 10,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 'Contact : ',
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Colors.blueAccent),
                               ),
                               Text(
                                 'meettechlab@gmail.com | ',
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Colors.purpleAccent),
                               ),
                               Text(
                                 '+8801755460159',
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Colors.blueAccent),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 50,
                     )
                   ],
                 ),
               ),
             ),
           ),
         ),
       ),
    ]
      ),
    );
  }

  void AddData() {
    if (_formKey.currentState!.validate()) {
      if (userEditingController.text == "admin" &&
          passwordEditingController.text == "admin") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Manage()),
                (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Login Successful!!")));
        setState(() {
          _process = false;
          _count = 1;
        });
      } else {
        setState(() {
          _process = false;
          _count = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Username or Password missmatch!!")));
      }
    } else {
      setState(() {
        _process = false;
        _count = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something Wrong!!")));
    }
  }
}
