class ModelResponse {
  int messageCode;
  String responseMessage;
  String? userId;

  ModelResponse(
      {required this.responseMessage, this.userId, required this.messageCode});
}
