import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniturestreet/main.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:http/http.dart' as http;
import '../services/logInGoogle.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  TabController _signUpPageController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Map data;
  Future getLoginData() async{
    http.Response response= await http.post('https://furniturestreet.in/MobileApi/users/login');
  }

  Widget signInForm() {
    return Form(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 12.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value.isEmpty ? 'Password can\'t be empty' : null,
              )),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            minWidth: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 2, fontSize: 23),
            ),
            onPressed: () {
              print(mobileController.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            },
            color: primary,
          ),
          FlatButton(
            child: Text('Forgot Password'),
          ),
          SizedBox(
            child: Divider(
              color: primary,
            ),
            width: MediaQuery.of(context).size.width - 50,
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              height: 50,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              elevation: 10.0,
              minWidth: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.indigo,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    'Continue with facebook',
                    style: TextStyle(color: Colors.indigo, letterSpacing: 3),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              height: 50,
              onPressed: () {
                SignIn().handleSignIn().whenComplete((){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );

                });


                },
              elevation: 10.0,
              minWidth: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/google.png',
                    height: 30,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.indigo, letterSpacing: 3),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpForm() {
    return Form(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 12.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value.isEmpty ? 'Password can\'t be empty' : null,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
            child: TextField(
              controller: mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Mobile Number"),
            ),
          ),
          MaterialButton(
            elevation: 5,
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
//              handleSignUp().then((_){
//                if(user!=null){
//                  print("Successful");
//                }
//              });
//              print(mobileController.text);
            },
            color: primary,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _signUpPageController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 150,
          child: Image.asset('assets/icon.png'),
        ),
        preferredSize: Size(100, double.maxFinite),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Login',
                ),
                Tab(
                  text: 'Signup',
                )
              ],
              controller: _signUpPageController,
              labelColor: primary,
              indicatorColor: primary,
              indicatorWeight: 3,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              width: double.maxFinite,
              child: TabBarView(
                controller: _signUpPageController,
                children: <Widget>[
                  signInForm(),
                  signUpForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
