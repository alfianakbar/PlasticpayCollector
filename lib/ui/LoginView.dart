import 'package:flutter/material.dart';
import 'package:plasticpaycoll/service/UserService.dart';
import 'package:plasticpaycoll/model/ProfileModel.dart';
import 'DashboardView.dart';
import 'MyTheme.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

enum LoginState { sukses, gagal, waiting }

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  ProfileModel _user;
  LoginState _loginState;

  bool _hidePassword = true;

  @override
  void initState() {
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    if (await isLogin()) {
      print('Login SUKSES');
      _user = await getProfile();
      if (_user != null) {
        setState(() {
          _loginState = LoginState.sukses;
        });
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardView(_user)),
        );
      }
//      else {
//        print('User NULL');
//        setState(() {
//          _loginState = LoginState.gagal;
//        });
//      }
    }
//    else {
//      print('Login GAGAL');
//      setState(() {
//        _loginState = LoginState.gagal;
//      });
//    }
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
                Center(
                  child: Text(
                    'collector',
                    textScaleFactor: 2,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                      Icons.lock,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        obscureText: _hidePassword,
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
                    InkWell(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: _hidePassword ? Colors.grey : Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    )
                  ],
                ),
                _loginState == null
                    ? Container()
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          _loginState == LoginState.sukses
                              ? 'Login Sukses'
                              : _loginState == LoginState.gagal
                                  ? 'Login Gagal'
                                  : 'cek login..',
                          style: TextStyle(
                              color: _loginState == LoginState.sukses
                                  ? Colors.green
                                  : _loginState == LoginState.gagal
                                      ? Colors.red
                                      : Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 20),
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
                      setState(() {
                        _loginState = LoginState.waiting;
                      });
                      _loginPressed();
                    },
                    color: MyColors.primaryColor,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    launch(
                        'https://collector.plasticpay.net/collector/password/email');
                  },
                  child: Center(
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
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

  void _loginPressed() async {
    await login(_emailController.text, _passwordController.text);
    if (await isLogin()) {
//      print('Login SUKSES');
      getProfile().then((res) {
        _user = res;
//        print(_user.content.user.name);
        setState(() {
          _loginState = LoginState.sukses;
        });
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardView(_user)),
        );
      });
    } else {
//      print('Login GAGAL');
      setState(() {
        _loginState = LoginState.gagal;
      });
    }
  }
}
