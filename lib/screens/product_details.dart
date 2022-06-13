import 'package:businessmanagementsoftware/models/product.dart';
import 'package:businessmanagementsoftware/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
int _totalProducts = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _totalProducts = _totalProducts +1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection("products");

    Widget _buildListView() {
      return StreamBuilder<QuerySnapshot>(
          stream: _collectionReference.orderBy("timeStamp",  descending: true).snapshots().asBroadcastStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went Wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('Empty'),
              );
            } else {

              final List storedocs = [];
              snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
                a['id'] = document.id;
              }).toList();


              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Last updated',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Price',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.brown.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),


                        for(var i = 0 ; i< storedocs.length; i++)...[
                          TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (storedocs[i]["timeStamp"] != null)
                                              ? DateFormat('dd-MMM-yyyy').format(
                                              storedocs[i]["timeStamp"]
                                                  .toDate())
                                              : "Loading...",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                              color: Colors.brown
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["name"],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                              color: Colors.brown
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["quantity"],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                              color: Colors.brown
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["price"],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                              color: Colors.brown
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["category"],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.brown
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:    IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context)=>AlertDialog(
                                                  title: Text("Confirm"),
                                                  content: Text("Do you want to delete it?"),
                                                  actions: [
                                                    IconButton(
                                                        icon: new Icon(Icons.close),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }),
                                                    IconButton(
                                                        icon: new Icon(Icons.delete),
                                                        onPressed: () {
                                                          FirebaseFirestore.instance
                                                              .collection('products')
                                                              .get()
                                                              .then((QuerySnapshot querySnapshot) {
                                                            for (var doc in querySnapshot.docs) {
                                                              if(doc["docID"] == storedocs[i]["docID"]){
                                                                setState(() {
                                                                  doc.reference.delete();
                                                                  Navigator.pop(context);
                                                                });
                                                              }
                                                            }
                                                          });
                                                        })
                                                  ],
                                                )
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.brown,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                        ]
                      ],
                    )
                ),
              );
            }
          });
    }



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
      ),
      drawer: drawerWidget(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown
              ),
              child: Text(
                "Total Products : $_totalProducts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 10,),
            _buildListView(),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }
}
