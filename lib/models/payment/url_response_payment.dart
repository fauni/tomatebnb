import 'dart:convert';

UrlResponsePayment urlResponsePaymentFromJson(String str) => UrlResponsePayment.fromJson(json.decode(str));

String urlResponsePaymentToJson(UrlResponsePayment data) => json.encode(data.toJson());

class UrlResponsePayment {
    final int? codigo;
    final String? mensaje;

    UrlResponsePayment({
        this.codigo,
        this.mensaje,
    });

    UrlResponsePayment copyWith({
        int? codigo,
        String? mensaje,
    }) => 
        UrlResponsePayment(
            codigo: codigo ?? this.codigo,
            mensaje: mensaje ?? this.mensaje,
        );

    factory UrlResponsePayment.fromJson(Map<String, dynamic> json) => UrlResponsePayment(
        codigo: json["codigo"],
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "mensaje": mensaje,
    };
}
