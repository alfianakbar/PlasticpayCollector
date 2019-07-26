import 'package:flutter/material.dart';
import 'package:plasticpay/service/UserService.dart';
import 'package:plasticpay/model/ProfileModel.dart';
import 'DashboardView.dart';
import 'package:flutter/services.dart';
import 'MyTheme.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _passwordConfirmController =
      new TextEditingController();

  ProfileModel _user;

  @override
  void initState() {
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    _user = await getProfile();
    if (_user == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error"),
              content: new Text("Edit Profile Gagal"),
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
          });
    } else {
      _nameController.text = _user.content.user.name;
      _emailController.text = _user.content.user.email;
      _phoneController.text = _user.content.user.phoneNumber;
    }
  }

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
                            //prefixIcon: Icon(Icons.phone),
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
                      'EDIT PROFILE',
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
                      Navigator.of(context).pop();
                    },
                    color: Colors.grey,
                    child: Text(
                      'Batal',
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

  void _showDialog(bool isSukses, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return isSukses
            ? AlertDialog(
                title: new Text("Edit akun berhasil!"),
                content: new Text("Klik untuk menuju dashboard"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardView(_user)),
                      );
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: new Text("Registrasi akun gagal!"),
                content: new Text("$message . Silakan ulangi kembali"),
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
        '"regency_id": "22","district_id": "1","village_id": "1","pin": "${_pinController.text}",'
        '"phone_number": "${_phoneController.text}","password_confirmation": "${_passwordConfirmController.text}"}';
    _user = await editProfile(
        input, _emailController.text, _passwordController.text);
    if (_user.status != 'error') {
      _showDialog(true, _user.message);
    } else {
      _showDialog(false, _user.message);
    }
  }
}
