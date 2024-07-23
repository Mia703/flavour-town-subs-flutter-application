const String productsTableName = 'products';

class ProductsColumns {
  static final List<String> values = [
    productId,
    productName,
    productDesc,
    productPrice,
    productImage,
    productType
  ];

  static const String productId = '_productId';
  static const String productName = 'productName';
  static const String productDesc = 'productDesc';
  static const String productPrice = 'productPrice';
  static const String productImage = 'productImage';
  static const String productType = 'productType';
}

class Product {
  final int productId;
  final String productName;
  final String productDesc;
  final double productPrice;
  final String productImage;
  final String productType;

  const Product({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productImage,
    required this.productType,
  });

  static Product fromJSON(Map<String, Object?> json) => Product(
    productId: json[ProductsColumns.productId] as int,
    productName: json[ProductsColumns.productName] as String,
    productDesc: json[ProductsColumns.productDesc] as String,
    productPrice: json[ProductsColumns.productPrice] as double,
    productImage: json[ProductsColumns.productImage] as String,
    productType: json[ProductsColumns.productType] as String,
  );

  Map<String, Object?> toJSON() => {
        ProductsColumns.productId: productId,
        ProductsColumns.productName: productName,
        ProductsColumns.productDesc: productDesc,
        ProductsColumns.productPrice: productPrice,
        ProductsColumns.productImage: productImage,
        ProductsColumns.productType: productType,
      };

  Product copy({
    int? productId,
    String? productName,
    String? productDesc,
    double? productPrice,
    String? productImage,
    String? productType,
  }) =>
      Product(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productDesc: productDesc ?? this.productDesc,
        productPrice: productPrice ?? this.productPrice,
        productImage: productImage ?? this.productImage,
        productType: productType ?? this.productType,
      );
}
