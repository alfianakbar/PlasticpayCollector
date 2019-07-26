import 'package:flutter/material.dart';
import 'LoginView.dart';
import 'package:plasticpay/service/UserService.dart';
import 'package:flutter/services.dart';
import 'MyTheme.dart';

class RegistrasiView extends StatefulWidget {
  @override
  _RegistrasiViewState createState() => _RegistrasiViewState();
}

class _RegistrasiViewState extends State<RegistrasiView> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _pinController = new TextEditingController();
  final TextEditingController _passwordConfirmController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/bg_bottle.png',
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/logo_text.png',
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _nameController,
                        decoration: new InputDecoration(
                            //prefixIcon: Icon(Icons.phone),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'Nama Lengkap',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            //prefixIcon: Icon(Icons.phone),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'Email',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'No. Handphone',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: _passwordController,
                        decoration: new InputDecoration(
                            //prefixIcon: Icon(Icons.phone),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'Password',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: _passwordConfirmController,
                        decoration: new InputDecoration(
                            //prefixIcon: Icon(Icons.phone),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'Konfirmasi Password',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        controller: _pinController,
                        decoration: new InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'PIN (4 digit)',
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
                  width: double.infinity,
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      _registrasiPressed();
                    },
                    color: MyColors.primaryColor,
                    child: Text(
                      'REGISTRASI',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
                  width: double.infinity,
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                    color: Colors.grey,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(bool isSukses) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return isSukses
            ? AlertDialog(
                title: new Text("Registrasi akun berhasil!"),
                content: new Text("Klik untuk menuju dashboard"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Login"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: new Text("Registrasi akun gagal!"),
                content: new Text("Silakan registrasi kembali"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
      },
    );
  }

  void _registrasiPressed() async {
    String input =
        '{"name": "${_nameController.text}","email": "${_emailController.text}","password": "${_passwordController.text}",'
        '"birth_date": "1995-11-15","address": "Bandung","province_id": "8",'
        '"regency_id": "22","district_id": "1","village_id": "1",'
        '"phone_number": "${_phoneController.text}","password_confirmation": "${_passwordConfirmController.text}","pin":"${_pinController.text}"}';
    if (await registerString(input)) {
      _showDialog(true);
    } else {
      _showDialog(false);
    }
  }
}
