import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class AppUtils {
  static sNavigateTo(context, routeName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => routeName));
  }
  static sNavigateToReplace(context, routeName) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => routeName));
  }

  static snackBarShowing(context, snackTitle) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackTitle)));
  }

  static MakeRequests(type, query) async {
    final response = await Dio().get("https://www.qcec.online/Requests.php?$type=$query");
    return json.decode(response.data);
  }
}
