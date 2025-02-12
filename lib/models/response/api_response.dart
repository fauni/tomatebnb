class ApiResponse<T> {
  final bool status;
  final String message;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  // Método factory para construir ApiResponse desde JSON para un solo objeto
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) createResultado,
  ) {
    return ApiResponse<T>(
      status: json["status"],
      message: json["message"],
      data: json["data"] != null
          ? createResultado(json["data"])
          : null,
    );
  }
}
