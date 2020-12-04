import 'dart:convert';
import 'package:Task/Display/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SharedPreferences _login;

  bool _newuser;
  List _data;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  String _error = ' ';
  bool flag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._jsonData();
    this.check_if_already_login();
  }

  void _showError() {
    setState(
      () {
        _error = 'User not found';
      },
    );
  }

  void check_if_already_login() async {
    _login = await SharedPreferences.getInstance();
    _newuser = (_login.getBool('login') ?? true);
    if (_newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DisplayData(_data)));
    }
  }

  Future<void> _jsonData() async {
    final jsonFile = await rootBundle.loadString('assets/user.json');
    setState(() {
      _data = json.decode(jsonFile);
      print(_data.length);
    });
  }

  Widget _getUser() {
    return TextField(
      controller: _emailcontroller,
      decoration: InputDecoration(
        labelText: 'E-mail',
      ),
    );
  }

  Widget _getPassword() {
    return TextField(
      controller: _passwordcontroller,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                height: _height * 0.23,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                      _getUser(),
                      _getPassword(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.2,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.blue[700],
                  onPressed: () {
                    for (int i = 0; i < _data.length; i++) {
                      if (_emailcontroller.text.toString() ==
                              _data[i]['email'] &&
                          _passwordcontroller.text.toString() == 'Test@123') {
                        flag = true;
                        _login.setBool('login', false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayData(_data),
                          ),
                        );
                      }
                    }
                    if (flag == false) {
                      _showError();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
