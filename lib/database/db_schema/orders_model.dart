const String ordersTableName = 'orders';

class OrdersColumns {
  static final List<String> values = [
    orderId,
    userId,
    orderDate,
    orderStatus,
    orderTotal
  ];
  static const String orderId = '_orderId';
  static const String userId = 'userId';
  static const String orderDate = 'orderDate';
  static const String orderStatus = 'orderStatus';
  static const String orderTotal = 'orderTotal';
}

class Order {
  final String orderId;
  final String userId;
  final DateTime orderDate;
  final String orderStatus;
  final double orderTotal;

  const Order({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.orderStatus,
    required this.orderTotal,
  });

  static Order fromJSON(Map<String, Object?> json) => Order(
    orderId: json[OrdersColumns.orderId] as String,
    userId: json[OrdersColumns.userId] as String,
    orderDate: DateTime.parse(json[OrdersColumns.orderDate] as String),
    orderStatus: json[OrdersColumns.orderStatus] as String,
    orderTotal: json[OrdersColumns.orderTotal] as double,
  );

  Map<String, Object?> toJSON() => {
        OrdersColumns.orderId: orderId,
        OrdersColumns.userId: userId,
        OrdersColumns.orderDate: orderDate.toIso8601String(),
        OrdersColumns.orderStatus: orderStatus,
        OrdersColumns.orderTotal: orderTotal,
      };

  Order copy({
    String? orderId,
    String? userId,
    DateTime? orderDate,
    String? orderStatus,
    double? orderTotal,
  }) =>
      Order(
        orderId: orderId ?? this.orderId,
        userId: userId ?? this.userId,
        orderDate: orderDate ?? this.orderDate,
        orderStatus: orderStatus ?? this.orderStatus,
        orderTotal: orderTotal ?? this.orderTotal,
      );
}
