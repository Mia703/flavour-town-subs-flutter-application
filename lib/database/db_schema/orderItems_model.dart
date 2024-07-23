const String orderItemsTableName = 'orderItems';

class OrderItemsColumns {
  static final List<String> values = [orderId, productId, quantity, itemPrice];

  static const String orderId = '_orderId';
  static const String productId = 'productId';
  static const String quantity = 'quantity';
  static const String itemPrice = 'itemPrice';
}

class OrderItem {
  final String orderId;
  final int productId;
  final int quantity;
  final double itemPrice;

  const OrderItem({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.itemPrice,
  });

  static OrderItem fromJSON(Map<String, Object?> json) => OrderItem(
    orderId: json[OrderItemsColumns.orderId] as String,
    productId: json[OrderItemsColumns.productId] as int,
    quantity: json[OrderItemsColumns.quantity] as int,
    itemPrice: json[OrderItemsColumns.itemPrice] as double,
  );

  Map<String, Object?> toJSON() => {
        OrderItemsColumns.orderId: orderId,
        OrderItemsColumns.productId: productId,
        OrderItemsColumns.quantity: quantity,
        OrderItemsColumns.itemPrice: itemPrice,
      };

  OrderItem copy({
    String? orderId,
    int? productId,
    int? quantity,
    double? itemPrice,
  }) =>
      OrderItem(
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        itemPrice: itemPrice ?? this.itemPrice,
      );
}
