import 'dart:convert';

import 'package:firebase_provider/modules/home/models/ModelProduct.dart';
import 'package:firebase_provider/modules/home/repository/RepositoryProducts.dart';
import 'package:flutter/foundation.dart';

import '../models/ModelProductResponce.dart';

class ProviderProducts extends ChangeNotifier {
  ModelProductResponse response =
      ModelProductResponse(messageCode: 0, responseMessage: "");

  ModelProductResponse get getResponse => response;

  getProductsList() {
    List<ModelProducts> list;
    RepositoryProducts.getProductList().then((value) {
      final data = json.decode(value.body);
      if (data['products'].isNotEmpty) {
        list = [];
        data['products'].forEach((v) {
          list.add(ModelProducts.fromJson(v));
        });
      } else {
        list = [];
      }
      response = ModelProductResponse(
          messageCode: 200, responseMessage: "Success", list: list);
      notifyListeners();
    }).catchError((onError) {
      response = ModelProductResponse(
          messageCode: 400, responseMessage: onError.toString());
      notifyListeners();
    });
  }
}
