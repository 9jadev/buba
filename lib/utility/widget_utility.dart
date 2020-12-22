import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:get/get.dart';

class AgentAccount extends StatelessWidget {
  const AgentAccount({
    Key key,
    @required this.accountbalance,
  }) : super(key: key);

  final String accountbalance;
  // final String  btcng = formatmoney(accountbalance)
  String formatmoney(accountbalance) {
    // int numberInt = int.parse(value);
    return accountbalance;
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: accountbalance);
    return fmf.formattedNonSymbol.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.amber[600],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agent Acount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'Email@buba.ng',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF3a3af2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: Text(
                    formatmoney(accountbalance),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Agentcreted extends StatelessWidget {
  const Agentcreted({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.amber[600],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agent created',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'Email@buba.ng',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF3a3af2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: Text(
                    '2020200',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatmoney(value) {
  // int numberInt = int.parse(value);
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: value);
  return fmf.formattedNonSymbol;
}
