class Sale {
  String? id;
  String? productName;
  int? value;
  String? client;
  String? paymentMethod;
  String? paymentDate;

  // Constructor con id
  Sale({
    required this.id,
    required this.productName,
    required this.value,
    required this.client,
    required this.paymentMethod,
    required this.paymentDate,
  });

  // Constructor sin id
  Sale.withoutId({
    this.productName,
    this.value,
    this.client,
    this.paymentMethod,
    this.paymentDate,
  });

  // Método para transformar un documento en una instancia de Sale
  factory Sale.fromDocument(Map<String, dynamic> doc) {
    return Sale(
      id: doc['id'],
      productName: doc['productName'],
      value: doc['value'],
      client: doc['client'],
      paymentMethod: doc['paymentMethod'],
      paymentDate: doc['paymentDate'],
    );
  }

  // Método para convertir una instancia de Sale a un Map (útil para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'value': value,
      'client': client,
      'paymentMethod': paymentMethod,
      'paymentDate': paymentDate,
    };
  }
}
