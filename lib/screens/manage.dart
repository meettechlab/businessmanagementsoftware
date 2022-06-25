import 'package:businessmanagementsoftware/models/api_sale.dart';
import 'package:businessmanagementsoftware/models/product.dart';
import 'package:businessmanagementsoftware/models/sale.dart';
import 'package:businessmanagementsoftware/models/cash.dart';
import 'package:businessmanagementsoftware/widgets/drawer_widget.dart';
import 'package:businessmanagementsoftware/widgets/pdf_sales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  final _formKey = GlobalKey<FormState>();
  final cashEditingController = new TextEditingController();
  var reasonEditingController;


  bool? _process;
  int? _count;

  int _totalAmount = 0;

  List<String> _cashList = ["Deposit", "Withdraw"];
  String? _chosenCash;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _process = false;
    _count = 1;

    reasonEditingController = new TextEditingController();

    FirebaseFirestore.instance
        .collection('sales')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _totalAmount = _totalAmount + int.parse(doc["price"]);
        });
      }
    });

    FirebaseFirestore.instance
        .collection('cash')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
       if(doc["reasonType"] == "Deposit"){
         setState(() {
           _totalAmount = _totalAmount + int.parse(doc["amount"]);
         });
       }else{
         setState(() {
           _totalAmount = _totalAmount - int.parse(doc["amount"]);
         });
       }
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    DropdownMenuItem<String> buildMenuCash(String item) =>
        DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.brown),
            ));

    final cashDropdown = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 4,
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
            items: _cashList.map(buildMenuCash).toList(),
            hint: Text(
              'Select Deposit/Withdraw',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.brown),
            ),
            value: _chosenCash,
            onChanged: (newValue) {
              setState(() {
                _chosenCash = newValue;
              });
            }));



    final cashField = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 4,
        child: TextFormField(
            cursorColor: Colors.brown,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ],
            autofocus: false,
            controller: cashEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("amount cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              cashEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Amount',
              labelStyle: TextStyle(color: Colors.brown),
              floatingLabelStyle: TextStyle(color: Colors.brown),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.brown),
              ),
            )));

    final reasonField = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 4,
        child: TextFormField(
            cursorColor: Colors.brown,
            autofocus: false,
            controller: reasonEditingController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              reasonEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Reason',
              labelStyle: TextStyle(color: Colors.brown),
              floatingLabelStyle: TextStyle(color: Colors.brown),
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
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          100,
          20,
          100,
          20,
        ),
        minWidth: 20,
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
              'Wait',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
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
          '  Add Entry  ',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white),
        ),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cash Management"),
      ),
      drawer: drawerWidget(context),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown
                  ),
                  child: Text(
                    "Total Amount : $_totalAmount TK",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                cashDropdown,
                SizedBox(height: 10,),
                reasonField,
                SizedBox(height: 10,),
                cashField,
                SizedBox(height: 30,),
                addButton,
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void AddData() async {
    if (_formKey.currentState!.validate() && _chosenCash != null) {
      var ref = FirebaseFirestore.instance.collection("cash")
          .doc();
      Cash cash = Cash();
      cash.timeStamp = FieldValue.serverTimestamp();
      cash.reasonType = _chosenCash;
      cash.reason = reasonEditingController.text;
      cash.amount = cashEditingController.text;
      cash.docID = ref.id;
      ref.set(cash.toMap()).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                "Entry Successful!!")));
        setState(() {
          _process = false;
          _count = 1;
          if(_chosenCash == "Deposit"){
            _totalAmount = _totalAmount + int.parse(cashEditingController.text);
            cashEditingController.clear();
            reasonEditingController.clear();
            _chosenCash = null;
          }else{
            _totalAmount = _totalAmount - int.parse(cashEditingController.text);
            cashEditingController.clear();
            reasonEditingController.clear();
            _chosenCash = null;
          }
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "Something is wrong!!")));
        setState(() {
          _process = false;
          _count = 1;
        });
      });
    }
  }
}
