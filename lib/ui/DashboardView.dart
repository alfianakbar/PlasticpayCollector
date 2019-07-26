import 'package:flutter/material.dart';
import 'package:plasticpay/model/ProfileModel.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'EditProfileView.dart';
import 'package:plasticpay/service/UserService.dart';
import 'LoginView.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'CalculatorView.dart';
import 'MyTheme.dart';
import 'package:plasticpay/model/TransactionModel.dart';
import 'package:plasticpay/service/TransactionService.dart';

class DashboardView extends StatefulWidget {
  final ProfileModel user;

  DashboardView(this.user);

  @override
  _DashboardViewState createState() => _DashboardViewState(this.user);
}

enum StateView { showNewTransaction, showHistory, showQR }

class _DashboardViewState extends State<DashboardView> {
  ProfileModel user;
  TransactionModel transaction;
  String barcode = "";
  ScrollController scrollController;
  TextEditingController _totalPlastikController = TextEditingController();
  GlobalKey _scaffold = GlobalKey();
  Timer timer;
  StateView _state = StateView.showNewTransaction;

  Future refreshTransaction() async {
    TransactionModel tmp = await getNewTransaction();
    ProfileModel tmpUser = await getProfile();
    setState(() {
      transaction = tmp;
      user = tmpUser;
    });
  }

  Future refreshHistory() async {
    TransactionModel tmp = await getHistory();
    ProfileModel tmpUser = await getProfile();
    setState(() {
      transaction = tmp;
      user = tmpUser;
    });
  }

  _DashboardViewState(this.user);

  @override
  void initState() {
    refreshTransaction().then((res) {
      scrollController = ScrollController(
          initialScrollOffset: transaction.content.transactions.length * 100.0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              child: Image.asset(
                'assets/images/bg_bottle.png',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  color: MyColors.primaryColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  color: MyColors.primaryColor,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfileView()),
                                  );
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text('Hai, ${user.content.user.name}!',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            child: Container(
                              child: Icon(
                                Icons.power_settings_new,
                                size: 30,
                                color: Colors.white,
                              ),
                              color: MyColors.primaryColor,
                            ),
                            onTap: () {
                              //logout
                              logout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 160,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Refresh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onTap: () {
                        _state == StateView.showHistory
                            ? refreshHistory()
                            : refreshTransaction();
                      },
                    )
                  ],
                ),
                _state == StateView.showHistory
                    ? _buildHistoryView()
                    : _state == StateView.showQR
                        ? _buildQR()
                        : _buildNewTransactionView(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    height: 85,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            transaction = null;
                            refreshTransaction();
                            _state = StateView.showNewTransaction;
                            setState(() {});
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.new_releases,
                                color: MyColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Transaksi\nBaru',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            transaction = null;
                            refreshHistory();
                            _state = StateView.showHistory;
                            setState(() {});
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.history,
                                color: MyColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Riwayat\nTransaksi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            _state = StateView.showQR;
                            setState(() {});
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.camera,
                                color: MyColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'QR\nSaya',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/qr_inacash_mini.png',
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Redeem\nInacash',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                  context: _scaffold.currentContext,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text(
                                          "Masukkan poin yang akan ditukar ke Inacash"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
//                                            controller: _pointController,
                                        decoration:
                                            InputDecoration(hintText: "poin"),
                                      ),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                                context: _scaffold.currentContext,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        new Text("Redeem Result"),
                                                    content: Text(
                                                        'Fasilitas ini sedang tidak diaktifkan'),
                                                    actions: <Widget>[
                                                      // usually buttons at the bottom of the dialog
                                                      new FlatButton(
                                                        child: new Text("OK"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNewTransactionView() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          _buildLine(),
          transaction != null
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => _transactionBox(
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].user.name}',
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].id}',
                      transaction
                          .content
                          .transactions[
                              transaction.content.transactions.length -
                                  index -
                                  1]
                          .plasticCollector
                          .name),
                  itemCount: transaction.content.transactions.length,
                  reverse: false,
                  controller: scrollController,
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }

  _buildHistoryView() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          _buildLine(),
          transaction != null
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => _historyBox(
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].user.name}',
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].id}',
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].totalPlastic}kg (${transaction.content.transactions[transaction.content.transactions.length - index - 1].totalPoint}p)',
                      '${transaction.content.transactions[transaction.content.transactions.length - index - 1].createdAt.day}/${transaction.content.transactions[transaction.content.transactions.length - index - 1].createdAt.month}/${transaction.content.transactions[transaction.content.transactions.length - index - 1].createdAt.year}'),
                  itemCount: transaction.content.transactions.length,
                  reverse: false,
                  controller: scrollController,
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }

  _buildQR() {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: QrImage(
        data: user.content.user.id.toString(),
        size: MediaQuery.of(context).size.width - 100,
        backgroundColor: Colors.white,
      ),
    ));
  }

  Widget _buildLine() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 30.0,
      child: new Container(
        width: 5.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _transactionBox(String userName, String id, String collectorName) {
    double dotSize = 20;
    return Container(
        constraints: BoxConstraints.expand(height: 100),
        margin: EdgeInsets.only(bottom: 5),
        color: Colors.white70,
        child: Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
              child: new Container(
                height: dotSize,
                width: dotSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.primaryColor),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '$id. $userName',
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                              fontSize: 20.0, color: MyColors.primaryColor),
                        ),
                      ),
                      FlatButton.icon(
                        color: MyColors.secondaryColor,
                        icon: const Icon(
                          Icons.check,
                          size: 18.0,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          showDialog(
                              context: _scaffold.currentContext,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Input Berat Total Plastik"),
                                  content: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            "Silahkan masukkan berat total plastik dari pelanggan"),
                                        TextField(
                                          controller: _totalPlastikController,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            suffix: Text('kg'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Calculator"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CalculatorView()));
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text("Batal"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: MyColors.secondaryColor,
                                      onPressed: () {
                                        editTransaction(
                                                int.parse(id),
                                                double.parse(
                                                    _totalPlastikController
                                                        .text))
                                            .then((res) {
                                          refreshTransaction();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ],
                  ),
                  new Text(
                    collectorName,
                    style: new TextStyle(
                        fontSize: 18.0, color: MyColors.secondaryColor),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _historyBox(String userName, String id, String poin, String date) {
    double dotSize = 20;
    return Container(
        constraints: BoxConstraints.expand(height: 100),
        margin: EdgeInsets.only(bottom: 5),
        color: Colors.white70,
        child: Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
              child: new Container(
                height: dotSize,
                width: dotSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.primaryColor),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '$poin',
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                              fontSize: 20.0, color: MyColors.primaryColor),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '$date',
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  new Text(
                    userName,
                    style: new TextStyle(
                        fontSize: 18.0, color: MyColors.secondaryColor),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
