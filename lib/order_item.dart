// A global order item object that is used to update order information

class OrderItem {
  String orderId = '';
  int productId = 0;
  int quantity = 0;
  double itemPrice = 0.00;

  void setOrderId(String id) {
    orderId = id;
  }

  void setProductId(int id) {
    productId = id;
  }

  void setQuantity(int amount) {
    quantity = amount;
  }

  void setItemPrice(double price) {
    itemPrice = price;
  }

  String getOrderId() {
    return orderId;
  }

  int getProductId() {
    return productId;
  }

  int getQuantity() {
    return quantity;
  }

  double getItemPrice() {
    return itemPrice;
  }

  int incrementQuantity() {
    return quantity += 1;
  }

  double addToItemPrice(double amount) {
    return itemPrice += amount;
  }
}
