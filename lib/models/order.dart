// A global order object used to hold order information

class Order {
  String orderId = '';
  String userId = '';
  String orderDate = '';
  String orderTime = '';
  String orderStatus = '';
  double orderTotal = 0;

  void setOrderID(String id) {
    orderId = id;
  }

  String getOrderId() {
    return orderId;
  }

  void setUserID(String id) {
    userId = id;
  }

  String getUserId() {
    return userId;
  }

  void setOrderDate(String date) {
    orderDate = date;
  }

  String getOrderDate() {
    return orderDate;
  }

  void setOrderTime(String time) {
    orderTime = time;
  }

  String getOrderTime() {
    return orderTime;
  }

  void setOrderStatus(String status) {
    orderStatus = status;
  }

  String getOrderStatus() {
    return orderStatus;
  }

  void setOrderTotal(double amount) {
    orderTotal = amount;
  }

  double getOrderTotal() {
    return orderTotal;
  }

  void clearOrder() {
    orderId = '';
    orderDate = '';
    orderTime = '';
    orderStatus = '';
    orderTotal = 0.00;
  }
}
