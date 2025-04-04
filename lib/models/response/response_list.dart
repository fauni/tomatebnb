class ApiResponseList<T> {
  final bool status;
  final String message;
  final List<T>? data;

  ApiResponseList({
    required this.status,
    required this.message,
    this.data
  });

  // Método factory para construir ApiResponseList desde JSON para una lista de objetos
  factory ApiResponseList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) createResultado,
  ) {
    return ApiResponseList<T>(
      status: json["status"],
      message: json["message"],
      data: json["data"] != null
          ? (json["data"] as List)
              .map((item) => createResultado(item))
              .toList()
          : null,
    );
  }
}
