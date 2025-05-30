class Faliures {
  String? errorMessage;
  Faliures({required this.errorMessage});
}

class ServerError extends Faliures {
  ServerError({required super.errorMessage});
}

class NetworkError extends Faliures {
  NetworkError({required super.errorMessage});
}
