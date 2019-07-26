import 'package:flutter/material.dart';
import 'LoginView.dart';

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  int pos;
  List<String> images = List(1);
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    for (int i = 0; i < 1; i++) {
      images[i] = 'assets/images/${i + 1}.png';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: FlatButton(
                      color: Colors.white30,
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
                        index == images.length - 1 ? 'SELESAI' : 'LANJUT',
                        style: TextStyle(
                            color: index == images.length - 1
                                ? Colors.green
                                : Colors.white),
                      )),
                ),
              ],
            );
          }),
    );
  }
}
