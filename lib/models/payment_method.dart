// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethod {
  final String id;
  final String name;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final bool isPreferred;

 const PaymentMethod({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.isPreferred= false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isPreferred' :isPreferred,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as String,
      name: map['name'] as String,
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
      cvv: map['cvv'] as String,
      isPreferred:  map['isPreferred'] as bool,
    );
  }

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    bool? isPreferred,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isPreferred: isPreferred ?? this.isPreferred,
    );
  }
}
