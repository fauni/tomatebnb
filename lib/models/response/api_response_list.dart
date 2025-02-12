class ApiResponse<T> {
  final bool status;
  final String message;
  final List<T>? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  // Método factory para construir ApiResponse desde JSON para una lista de objetos
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) createResultado,
  ) {
    return ApiResponse<T>(
      status: json["status"],
      message: json["message"],
      data: json["data"] != null
          ? (json["data"] as List)
              .map<T>((item) => createResultado(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}