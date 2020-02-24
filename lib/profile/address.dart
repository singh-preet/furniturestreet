import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:flutter_razorpay_sdk/flutter_razorpay_sdk.dart';

class UpdateAddress extends StatefulWidget {
  final bool addressVerify;
  final List cartList;
  final double price;
  UpdateAddress(this.addressVerify, this.cartList, this.price);

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  bool editAddress = false;
  bool addAnotherAddress = false;
  int selectedIndex;
  String userName = '';
  TextEditingController line1 = TextEditingController();
  TextEditingController line2 = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController phone = TextEditingController();
  Map<String, String> address = {};
  List addressList = [];
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
//    fetchAddressList();
    super.initState();
  }

  List temp = List();
//  fetchAddressList() {
//    Firestore.instance
//        .collection('users')
//        .document(user.uid)
//        .snapshots()
//        .listen((snapshot) {
//      if (this.mounted) {
//        setState(() {
//          addressList = snapshot.data['address'].toList();
//          userName = snapshot.data['name'];
//        });
//      }
//    });
//  }

  deleteAddressFromDatabase(int index) {
    addressList.removeAt(index);
    if (this.mounted) {
      setState(() {
        updateAddress();
      });
    }
  }

  Widget getEditForm(int index) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Address line 1"),
          controller: line1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Address line 2"),
          controller: line2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Pin Code"),
          controller: pin,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Phone Number"),
          controller: phone,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: Row(
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                if (this.mounted) {
                  setState(() {
                    addressList[index] = {
                      'house': line1.text,
                      'street': line2.text,
                      'pin': pin.text,
                      'phone': phone.text
                    };
                  });
                }
                updateAddress();
                if (this.mounted) {
                  setState(() {
                    editAddress = false;
                  });
                }
              },
              color: primary,
              elevation: 5,
              child: Text("Submit"),
            ),
            SizedBox(
              width: 15,
            ),
            MaterialButton(
              color: primary,
              elevation: 5,
              child: Text("Cancel"),
              onPressed: () {
                if (this.mounted) {
                  setState(() {
                    editAddress = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    ]);
  }

  Widget getAddForm() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Address line 1"),
          controller: line1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Address line 2"),
          controller: line2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Pin Code"),
          controller: pin,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: TextField(
          decoration: InputDecoration(hintText: "Phone Number"),
          controller: phone,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
        child: Row(
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                if (this.mounted) {
                  setState(() {
                    addressList.add({
                      'house': line1.text,
                      'street': line2.text,
                      'pin': pin.text,
                      'phone': phone.text
                    });
                  });
                }
                updateAddress();
                if (this.mounted) {
                  setState(() {
                    addAnotherAddress = false;
                  });
                }
              },
              color: primary,
              elevation: 5,
              child: Text("Submit"),
            ),
            SizedBox(
              width: 15,
            ),
            MaterialButton(
              color: primary,
              elevation: 5,
              child: Text("Cancel"),
              onPressed: () {
                if (this.mounted) {
                  setState(() {
                    addAnotherAddress = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    ]);
  }

  Future updateAddress() async {
    Map<String, dynamic> users;
    if (this.mounted) {
      setState(() {
        users = {
          'name': userName,
          'uid': 'userid',
          'address': addressList,
        };
      });
    }

//    Firestore.instance.collection('users').document(user.uid).setData(users);
    line1.clear();
    line2.clear();
    pin.clear();
    phone.clear();
  }

  startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Furniture Street");
    options.putIfAbsent(
        "image", () => "https://www.73lines.com/web/image/12427");
    options.putIfAbsent("description", () => "This is a real transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => 'baani.sunpreet@gmail.com');
    options.putIfAbsent("contact", () => "9988776655");
    options.putIfAbsent("theme", () => "#3c70e6");
    options.putIfAbsent("api_key", () => "rzp_live_aHf2cXNfGrYKZi");
    Map<dynamic, dynamic> paymentResponse = new Map();
    paymentResponse = await FlutterRazorpaySdk.openPaymentDialog(options);
    print("response $paymentResponse");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Details",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 18.0, left: 20),
                        child: Text(
                          "Saved Details:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      !snapshot.data.exists
                          ? Container()
                          : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.data['address'] !=
                              null
                              ? snapshot.data.data['address'].length
                              : 0,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(5),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        60,
                                    height: 200,
                                    color: Colors.grey[100],
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.data['name'],
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          '\n' +
                                              snapshot.data
                                                  .data['address']
                                              [index]['house'] +
                                              '\n' +
                                              snapshot.data
                                                  .data['address']
                                              [index]['street'] +
                                              '\n' +
                                              snapshot.data
                                                  .data['address']
                                              [index]['pin'] +
                                              '\n\n' +
                                              snapshot.data
                                                  .data['address']
                                              [index]['phone'],
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    )),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        line1 = TextEditingController(
                                            text: snapshot.data
                                                .data['address']
                                            [index]['house']);
                                        line2 = TextEditingController(
                                            text: snapshot.data
                                                .data['address']
                                            [index]['street']);
                                        pin = TextEditingController(
                                            text: snapshot.data
                                                .data['address']
                                            [index]['pin']);
                                        phone = TextEditingController(
                                            text: snapshot.data
                                                .data['address']
                                            [index]['phone']);
                                        if (this.mounted) {
                                          setState(() {
                                            selectedIndex = index;
                                            if (editAddress ==
                                                false) {
                                              editAddress = true;
                                            } else {
                                              editAddress = false;
                                            }
                                          });
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteAddressFromDatabase(
                                            index);
                                        print(addressList);
                                      },
                                    )
                                  ],
                                )
                              ],
                            );
                          }),
                      editAddress == true
                          ? getEditForm(selectedIndex)
                          : Container(),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(8.0, 25.0, 0, 0),
                        child: MaterialButton(
                          child: Text("Add address"),
                          color: primary,
                          elevation: 10,
                          onPressed: () {
                            if (this.mounted) {
                              setState(() {
                                addAnotherAddress = true;
                              });
                            }
                          },
                        ),
                      ),
                      editAddress == true
                          ? Container()
                          : addAnotherAddress == true
                          ? getAddForm()
                          : Container(),
                      Text(widget.cartList.toString()),
                      Text(widget.price.toString())

//                      Padding(
//                        padding: const EdgeInsets.only(top:25.0),
//                        child: Center(
//                          child: MaterialButton(
//                            child: Text('Place Order'),
//                            color: primary,
//                            onPressed: () {
//                              startPayment();
//                            },
//                          ),
//                        ),
//                      ):Container()
                    ],
                  ),
                )
              ),
              widget.addressVerify == true
                  ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: FlatButton(
                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => PaymentMethod(
//                                  cartList: widget.cartList,
//                                  price: widget.price,
//                                  addressList: addressList)));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: primary, boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0, -5),
                            blurRadius: 10)
                      ]),
                      height: 50,
                      child: Center(
                        child: Text(
                          'PROCEED',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ))
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
