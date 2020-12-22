// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.id,
    this.authid,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.paymentAccountNumber,
    this.paymentBankName,
    this.password,
    this.bvn,
    this.accountNumber,
    this.bankCode,
    this.paymentAccountName,
    this.winningsBalance,
    this.idCard,
    this.address,
    this.city,
    this.state,
    this.status,
    this.referralCode,
    this.referredBy,
    this.referralType,
    this.lastFunding,
    this.picture,
    this.userType,
  });

  String id;
  String authid;
  String firstname;
  String lastname;
  String email;
  String phoneNumber;
  DateTime createdAt;
  String updatedAt;
  String balance;
  String paymentAccountNumber;
  String paymentBankName;
  String password;
  String bvn;
  String accountNumber;
  String bankCode;
  String paymentAccountName;
  String winningsBalance;
  String idCard;
  String address;
  String city;
  String state;
  String status;
  String referralCode;
  String referredBy;
  String referralType;
  DateTime lastFunding;
  String picture;
  String userType;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        authid: json["authid"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        balance: json["balance"],
        paymentAccountNumber: json["payment_account_number"],
        paymentBankName: json["payment_bank_name"],
        password: json["password"],
        bvn: json["bvn"],
        accountNumber: json["account_number"],
        bankCode: json["bank_code"],
        paymentAccountName: json["payment_account_name"],
        winningsBalance: json["winnings_balance"],
        idCard: json["id_card"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        status: json["status"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        referralType: json["referral_type"],
        lastFunding: DateTime.parse(json["last_funding"]),
        picture: json["picture"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "authid": authid,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "balance": balance,
        "payment_account_number": paymentAccountNumber,
        "payment_bank_name": paymentBankName,
        "password": password,
        "bvn": bvn,
        "account_number": accountNumber,
        "bank_code": bankCode,
        "payment_account_name": paymentAccountName,
        "winnings_balance": winningsBalance,
        "id_card": idCard,
        "address": address,
        "city": city,
        "state": state,
        "status": status,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "referral_type": referralType,
        "last_funding": lastFunding.toIso8601String(),
        "picture": picture,
        "user_type": userType,
      };
}
