class HttpException implements Exception {
  String message;

  HttpException(this.message);

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return message;
  }
}
