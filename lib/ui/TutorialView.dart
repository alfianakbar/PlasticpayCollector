import 'package:flutter/material.dart';
import 'package:plasticpaycoll/model/ProfileModel.dart';
import 'package:plasticpaycoll/service/UserService.dart';
import 'DashboardView.dart';
import 'LoginView.dart';
import 'package:flare_flutter/flare_actor.dart';

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  List<String> images = List(1);
  int pos;

  ScrollController _controller = ScrollController();
  LoginState _loginState;
  ProfileModel _user;

  @override
  void initState() {
    for (int i = 0; i < 1; i++) {
      images[i] = 'assets/images/${i + 1}.png';
    }
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    if (await isLogin()) {
      print('Login SUKSES');
      _user = await getProfile();
      if (_user.content != null) {
        setState(() {
          _loginState = LoginState.sukses;
        });
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardView(_user)),
        );
      } else {
        print('User NULL');
        setState(() {
          _loginState = LoginState.gagal;
        });
      }
    } else {
      print('Login GAGAL');
      setState(() {
        _loginState = LoginState.gagal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(ctxt).size.width,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: FlareActor(
                      'assets/images/plasticzilla.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: 'munch',
                    ),
                  ),
                ),
//                Positioned(
//                  bottom: 10,
//                  left: 0,
//                  right: 0,
//                  child: FlatButton(
//                      color: Colors.transparent,
//                      onPressed: () {},
//                      child: Center(
//                        child: Text('${index + 1}/9',
//                            style: TextStyle(
//                                fontSize: 18,
//                                color: index == images.length - 1
//                                    ? Colors.green
//                                    : Colors.white)),
//                      )),
//                ),
//                Positioned(
//                  bottom: 10,
//                  left: 10,
//                  child: FlatButton(
//                      color: Colors.white30,
//                      onPressed: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => LoginView()),
//                        );
//                      },
//                      child: Text('LEWATI',
//                          style: TextStyle(
//                              color: index == images.length - 1
//                                  ? Colors.green
//                                  : Colors.white))),
//                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _loginState == LoginState.gagal
                      ? FlatButton(
                          color: Colors.black12,
                          onPressed: () {
                            if (index == images.length - 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            } else {
                              _controller.animateTo(
                                  index == images.length - 1
                                      ? 0.0
                                      : MediaQuery.of(context).size.width *
                                          (index + 1),
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300));
                            }
                          },
                          child: Text(
                            index == images.length - 1 ? 'LOGIN' : 'LANJUT',
                            style: TextStyle(
                                color: index == images.length - 1
                                    ? Colors.green
                                    : Colors.white),
                          ))
                      : CircularProgressIndicator(),
                ),
              ],
            );
          }),
    );
  }
}
