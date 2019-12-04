import 'package:flutter/material.dart';
import 'MyTheme.dart';
import 'package:plasticpaycoll/service/ConversionService.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      home: CalculatorView(),
    ));

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
//  List<String> botolKecilTxt = ['Aqua', 'Pocari Sweat'];
//  List<double> botolKecilGrm = [15, 20];
//  List<TextEditingController> botolKecilJml;
//  List<String> botolBesarTxt = ['Aqua', 'Fanta', 'Sprite'];
//  List<double> botolBesarGrm = [28, 37, 37.5];
//  List<TextEditingController> botolBesarJml;
  List<String> botolTxt;
  List<double> botolGrm;
  List<TextEditingController> botolJml;
  String total = '0';

  @override
  void initState() {
    getConversion().then((res) {
      botolTxt = List(res.content.conversions.length);
      botolGrm = List(res.content.conversions.length);
      botolJml = List(res.content.conversions.length);
      for (int i = 0; i < botolJml.length; i++) {
        botolJml[i] = TextEditingController();
        botolJml[i].text = '0';
        botolTxt[i] = res.content.conversions[i].plasticName;
        botolGrm[i] = double.parse(res.content.conversions[i].weight);
      }
      setState(() {});
    });
//    botolKecilJml = List(botolKecilTxt.length);
//    for (int i = 0; i < botolKecilJml.length; i++) {
//      botolKecilJml[i] = TextEditingController();
//      botolKecilJml[i].text = '0';
//    }
//    botolBesarJml = List(botolBesarTxt.length);
//    for (int i = 0; i < botolBesarJml.length; i++) {
//      botolBesarJml[i] = TextEditingController();
//      botolBesarJml[i].text = '0';
//    }
    super.initState();
  }

  refreshTotal() {
    double totalInt = 0;
    for (int i = 0; i < botolJml.length; i++) {
      totalInt += double.parse(botolJml[i].text) * botolGrm[i];
    }
//    for (int i = 0; i < botolKecilJml.length; i++) {
//      totalInt += double.parse(botolKecilJml[i].text) * botolKecilGrm[i];
//    }
//    for (int i = 0; i < botolBesarJml.length; i++) {
//      totalInt += double.parse(botolBesarJml[i].text) * botolBesarGrm[i];
//    }
    setState(() {
      total = '${totalInt / 1000}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (context) => Stack(children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(),
                    child: Image.asset(
                      'assets/images/bg_bottle.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: <Widget>[
                      Image.asset(
                        'assets/images/logo_white.png',
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'PlasticPay Kalkulator',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      headerText('Botol Plastik'),
                      botolTxt != null
                          ? listText(botolTxt, botolJml)
                          : Container(),
//          headerText('Botol Kecil (600ml)'),
//          listText(botolKecilTxt, botolKecilJml),
//          headerText('Botol Besar (~1.5L)'),
//          listText(botolBesarTxt, botolBesarJml),
                      SizedBox(height: 50),
                    ]),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: MyColors.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              BackButton(
                                color: Colors.white,
                              ),
                              Text(
                                'Total',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          InkWell(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '$total kg',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.content_copy,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.pop(context, total);
                              /*
                              Clipboard.setData(new ClipboardData(text: total));
                              final snackBar = SnackBar(
                                content: Text('Total berat: $total kg!'),
                                action: SnackBarAction(
                                  label: 'Copy',
                                  onPressed: () {
                                    Navigator.pop(context, total);
                                  },
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                               */
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 0,
                    child: FlatButton.icon(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18.0,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'kembali',
                        semanticsLabel: 'kembali',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(context, total);
                      },
                    ),
                  )
                ])));
  }

  listText(List<String> listTxt, List<TextEditingController> listJml) {
    List<Widget> items = List(listTxt.length);

    for (int i = 0; i < listTxt.length; i++) {
      items[i] = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              listTxt[i],
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Container(
                width: 100,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: listJml[i],
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'jumlah',
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey))),
                  onChanged: (text) {
                    refreshTotal();
                  },
                )),
          ],
        ),
      );
    }

    return Column(
      children: items,
    );
  }

  headerText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width * 2 / 3,
          color: MyColors.primaryColor,
        )
      ],
    );
  }
}
