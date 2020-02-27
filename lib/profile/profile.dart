import 'package:flutter/material.dart';
import 'package:furniturestreet/profile/webviewpage.dart';
import 'package:furniturestreet/services/logInGoogle.dart';
import 'package:furniturestreet/signin/signup.dart';
import '../shared/style.dart';
import 'address.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 6,
          child: Container(
            height: 220,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [primary,Colors.indigo, primary])),
                  width: double.maxFinite,
                  height: 100,
                ),
                Positioned(
                    right: 0,
                    top: 100,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text('Test')
//                          StreamBuilder(
//                              stream: Firestore.instance
//                                  .collection('users')
//                                  .document(user.uid)
//                                  .snapshots(),
//                              builder: (context, snapshot) {
//                                return snapshot.hasData
//                                    ? Text(
//                                  snapshot.data.data['name'],
//                                  style: TextStyle(
//                                    fontSize: 20,
//                                    fontWeight: FontWeight.w500,
//                                  ),
//                                )
//                                    : Container();
//                              }),
                            ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'test@test.com',
//                            user.email,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    )),
                Positioned(
                  top: 20,
                  right: 0,
                  child: FlatButton(
                      child: Text("Sign Out"),
                      onPressed: () {
                        if (this.mounted) {
                          setState(() {
                            SignIn().handleSignOut().whenComplete((){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));
                            });

                          });
//                      }
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => HomePage(),),);
                        }
                      }),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
//                      child: CachedNetworkImage(imageUrl:(
//                        'https://images.unsplash.com/photo-1554780336-390462301acf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
//                        fit: BoxFit.cover,
//                      )
//                      child: user.photoUrl == null
//                          ? Image.asset(
//                          'assets/user_placeholder.jpeg')
//                          : CachedNetworkImage(imageUrl:(user.photoUrl)
                      ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateAddress(false, [], 0.0)));
                      },
                      title: Text("Phone Number and Address"),
                      subtitle: Text(
                          "Save your contact details for hassle-free checkout"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Orders"),
                      subtitle: Text("Check your previous orders"),
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => Orders()));
                      },
                    ),
                    ListTile(
                      title: Text("Wishlist"),
                      subtitle: Text("Yours most loved dishes"),
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => WishList()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('About'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewPage(
                              title: 'About',
                              url:
                                  'https://furniturestreet.in/index.php/MobileApi/webview/about_us',
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Terms & Conditions'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewPage(
                              title: 'Terms & Conditions',
                              url:
                                  'https://furniturestreet.in/index.php/MobileApi/webview/terms',
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Privacy Policy'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      title: 'Privacy Policy',
                                      url:
                                          'https://furniturestreet.in/index.php/MobileApi/webview/policy',
                                    )));
                      },
                    ),
                    ListTile(
                      title: Text('FAQ'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      title: 'FAQ',
                                      url:
                                          'https://furniturestreet.in/index.php/MobileApi/webview/faq',
                                    )));
                      },
                    ),
                    ListTile(
                      title: Text('Terms of use'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewPage(
                              title: 'Terms of use',
                              url:
                                  'https://furniturestreet.in/index.php/MobileApi/webview/terms_of_use',
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Contact'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewPage(
                              title: 'Contact',
                              url:
                                  'https://furniturestreet.in/index.php/MobileApi/webview/contact',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
