import 'package:firebase_provider/modules/home/models/ModelProduct.dart';

class ModelProductResponse {
  int messageCode;
  String responseMessage;
  List<ModelProducts>? list;

  ModelProductResponse(
      {required this.messageCode, required this.responseMessage, this.list});
}
