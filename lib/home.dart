import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class Homee extends StatelessWidget {
  Homee({Key? key}) : super(key: key);

  List<Binanceprac?> newList = [];

  Future<List<Binanceprac?>> fetchData() async {
    String url = "https://api2.binance.com/api/v3/ticker/24hr";
    http.Response response = await http.get(Uri.parse(url));
    var jsonDecoded = await json.decode(response.body);

    if (response.statusCode == 200) {
      for (var i in jsonDecoded) {
        newList.add(Binanceprac.fromJson(i));
      }
      return newList;
    } else {
      return newList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binance'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<List<Binanceprac?>> snapshot) {
          return Column(
            children: [
              ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text('${snapshot.data![index]!.symbol}'),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
