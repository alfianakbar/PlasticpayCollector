import 'package:plasticpay/model/TransactionModel.dart';
import 'Config.dart';
import 'package:http/http.dart' as http;
import 'SharedPrefService.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future<TransactionModel> getNewTransaction() async {
  String url = '${Config.url}/plastic/newTransaction';
  String token = await getSharedPrefString('token');
  final response = await http.get(
    '$url',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Secret': Config.secret,
      'Authorization': token
    },
  );
//  print(response.body);
  return transactionModelFromJson(response.body);
}

Future<TransactionModel> getHistory() async {
  String url = '${Config.url}/plastic/history';
  String token = await getSharedPrefString('token');
  final response = await http.get(
    '$url',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Secret': Config.secret,
      'Authorization': token
    },
  );
//  print(response.body);
  return transactionModelFromJson(response.body);
}

Future<bool> editTransaction(int idTransaction, double totalPlastic) async {
  String url = '${Config.url}/plastic/$idTransaction/edit';
  String token = await getSharedPrefString('token');
  String body = '{"total_plastic": $totalPlastic}';
  final response = await http.put('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
        'Authorization': token
      },
      body: body);
//  print(response.body);
  return json.decode(response.body)["status"] == 'success';
}
