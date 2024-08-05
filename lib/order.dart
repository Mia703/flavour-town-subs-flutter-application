// A global order object used to hold order information

class Order {
  String orderId = '';
  String userId = '';
  String orderDate = '';
  String orderStatus = '';
  double orderTotal = 0.00;
  int orderCount = 0; // the number of items in the cart

  void setOrderID(String id) {
    orderId = id;
  }

  void setUserID(String id) {
    userId = id;
  }

  void setOrderDate(String date) {
    orderDate = date;
  }

  void setOrderStatus(String status) {
    orderStatus = status;
  }

  void setOrderTotal(double total) {
    orderTotal = total;
  }

  void setOrderCount(int total) {
    orderCount = total;
  }

  String getOrderId() {
    return orderId;
  }

  String getUserId() {
    return userId;
  }

  String getOrderDate() {
    return orderDate;
  }

  String getOrderStatus() {
    return orderStatus;
  }

  double getOrderTotal() {
    return orderTotal;
  }

  int getOrderCount() {
    return orderCount;
  }

  double addToOrderTotal(double amount) {
    return orderTotal += amount;
  }
}
