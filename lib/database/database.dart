import 'package:flavour_town_subs_flutter_application/database/db_schema/orderItems_model.dart';
import 'package:flavour_town_subs_flutter_application/database/db_schema/orders_model.dart';
import 'package:flavour_town_subs_flutter_application/database/db_schema/products_model.dart';
import 'package:flavour_town_subs_flutter_application/database/db_schema/users_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FlutterDatabase {
  // ==================== INITIALISE DB ====================
  // a global constructor
  static final FlutterDatabase instance = FlutterDatabase._init();

  static Database? _database;

  // a constructor
  FlutterDatabase._init();

  // opens a connection to the FlutterDatabase and
  // creates a db file, if it does not exist already
  Future<Database> get database async {
    // if it exists, return the FlutterDatabase
    if (_database != null) {
      return _database!;
    }
    // else, it doesn't exist, so create it
    _database = await _initDB('flutter_database.db');
    return _database!;
  }

  // initialises the FlutterDatabase
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // ==================== CREATE DATABASE ====================
  Future _createDB(Database db, int version) async {
    const uuidPK = 'UUID PRIMARY KEY NOT NULL';
    const varchar50 = 'VARCHAR(50) NOT NULL';
    const varchar50Unique = 'VARCHAR(50) UNIQUE NOT NULL';
    const varchar255 = 'VARCHAR(255) NOT NULL';

    // create 'users' table
    await db.execute('''
      CREATE TABLE $usersTableName (
        ${UsersColumns.uuid} $uuidPK, 
        ${UsersColumns.firstName} $varchar50,
        ${UsersColumns.lastName} $varchar50,
        ${UsersColumns.username} $varchar50Unique,
        ${UsersColumns.password} $varchar255
      );
      ''');

    const serial = 'SERIAL PRIMARY KEY';
    const text = 'TEXT NOT NULL';
    const decimal = 'DECIMAL(10, 2) NOT NULL';

    // create 'products' table
    await db.execute('''
      CREATE TABLE $productsTableName (
        ${ProductsColumns.productId} $serial, 
        ${ProductsColumns.productName} $varchar255,
        ${ProductsColumns.productDesc} $text,
        ${ProductsColumns.productPrice} $decimal,
        ${ProductsColumns.productImage} $varchar255,
        ${ProductsColumns.productType} $varchar50
      );
      ''');

    const uuid = 'UUID NOT NULL';
    const date = 'DATE NOT NULL';
    const varchar20 = 'VARCHAR(20) NOT NULL';
    // create 'orders' table
    await db.execute('''
      CREATE TABLE $ordersTableName (
        ${OrdersColumns.orderId} $uuidPK, 
        ${OrdersColumns.userId} $uuid,
        ${OrdersColumns.orderDate} $date,
        ${OrdersColumns.orderStatus} $varchar20,
        ${OrdersColumns.orderTotal} $decimal,
        FOREIGN KEY (${OrdersColumns.userId}) REFERENCES $usersTableName(${UsersColumns.uuid})
      );
      ''');

    const integer = 'INT NOT NULL';
    // create 'orderItems' table
    await db.execute('''
      CREATE TABLE $orderItemsTableName (
        ${OrderItemsColumns.orderId} $uuid, 
        ${OrderItemsColumns.productId} $integer,
        ${OrderItemsColumns.quantity} $integer,
        ${OrderItemsColumns.itemPrice} $decimal,
        PRIMARY KEY (${OrderItemsColumns.orderId}, ${OrderItemsColumns.productId}),
        FOREIGN KEY (${OrderItemsColumns.orderId}) REFERENCES $ordersTableName(${OrdersColumns.orderId}),
        FOREIGN KEY (${OrderItemsColumns.productId}) REFERENCES $productsTableName(${ProductsColumns.productId})
      );
      ''');
  }

  // ==================== USER DB METHODS ====================
  Future<User> insertUser(User user) async {
    final db = await instance.database;
    final uuid = await db.insert(usersTableName, user.toJSON());
    return user.copy(uuid: uuid as String);
  }

  Future<User> readUser(String uuid) async {
    final db = await instance.database;
    final maps = await db.query(
      usersTableName,
      columns: UsersColumns.values,
      where: '${UsersColumns.uuid} = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return User.fromJSON(maps.first);
    } else {
      throw Exception('User\'s uuid: $uuid, is not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;
    const alphaOrder = '${UsersColumns.firstName} ASC';
    // final result = await db.query(usersTableName, orderBy: alphaOrder);
    final result =
        await db.rawQuery('SELECT * FROM $usersTableName ORDER BY $alphaOrder');
    return result.map((json) => User.fromJSON(json)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db.update(usersTableName, user.toJSON(),
        where: '${UsersColumns.uuid} = ?', whereArgs: [user.uuid]);
  }

  Future<int> deleteUser(int uuid) async {
    final db = await instance.database;
    return await db.delete(usersTableName,
        where: '${UsersColumns.uuid} = ?', whereArgs: [uuid]);
  }

  // ==================== PRODUCT DB METHODS ====================
  Future<Product> insertProduct(Product product) async {
    final db = await instance.database;
    final productId = await db.insert(productsTableName, product.toJSON());
    return product.copy(productId: productId);
  }

  Future<Product> readProduct(int productId) async {
    final db = await instance.database;
    final maps = await db.query(
      productsTableName,
      columns: ProductsColumns.values,
      where: '${ProductsColumns.productId} = ?',
      whereArgs: [productId],
    );

    if (maps.isNotEmpty) {
      return Product.fromJSON(maps.first);
    } else {
      throw Exception('Product\'s productId: $productId, is not found');
    }
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return db.update(productsTableName, product.toJSON(),
        where: '${ProductsColumns.productId} = ?',
        whereArgs: [product.productId]);
  }

  Future<int> deleteProduct(int productId) async {
    final db = await instance.database;
    return db.delete(productsTableName,
        where: '${ProductsColumns.productId} = ?', whereArgs: [productId]);
  }

  // ==================== ORDER DB METHODS ====================
  Future<Order> insertOrder(Order order) async {
    final db = await instance.database;
    final orderId = await db.insert(ordersTableName, order.toJSON());
    return order.copy(orderId: orderId as String);
  }

  Future<Order> readOrder(String orderId) async {
    final db = await instance.database;
    final maps = await db.query(
      ordersTableName,
      columns: OrdersColumns.values,
      where: '${OrdersColumns.orderId} = ?',
      whereArgs: [orderId],
    );

    if (maps.isNotEmpty) {
      return Order.fromJSON(maps.first);
    } else {
      throw Exception('Order\'s orderId: $orderId, is not found');
    }
  }

  Future<int> updateOrder(Order order) async {
    final db = await instance.database;
    return db.update(ordersTableName, order.toJSON(),
        where: '${OrdersColumns.orderId} = ?',
        whereArgs: [order.orderId]);
  }

  Future<int> deleteOrder(String orderId) async {
    final db = await instance.database;
    return db.delete(ordersTableName,
        where: '${OrdersColumns.orderId} = ?', whereArgs: [orderId]);
  }

  // ==================== ORDER ITEMS DB METHODS ====================
  Future<OrderItem> insertOrderItem(OrderItem orderItem) async {
    final db = await instance.database;
    final orderItemId =
        await db.insert(orderItemsTableName, orderItem.toJSON());
    return orderItem.copy(orderId: orderItemId as String);
  }

  Future<OrderItem> readOrderItem(String orderId, int productId) async {
    final db = await instance.database;
    final maps = await db.query(
      orderItemsTableName,
      columns: OrderItemsColumns.values,
      where:
          '${OrderItemsColumns.orderId} = ? AND ${OrderItemsColumns.productId} = ?',
      whereArgs: [orderId, productId],
    );

    if (maps.isNotEmpty) {
      return OrderItem.fromJSON(maps.first);
    } else {
      throw Exception(
          'OrderItem\'s orderId: $orderId or productId: $productId, is not found');
    }
  }

  Future<int> updateOrderItem(OrderItem orderItem) async {
    final db = await instance.database;
    return db.update(orderItemsTableName, orderItem.toJSON(),
        where:
            '${OrderItemsColumns.orderId} = ? AND ${OrderItemsColumns.productId} = ?',
        whereArgs: [orderItem.orderId, orderItem.productId]);
  }

  Future<int> deleteOrderItem(String orderId, int productId) async {
    final db = await instance.database;
    return db.delete(orderItemsTableName,
        where:
            '${OrderItemsColumns.orderId} = ? AND ${OrderItemsColumns.productId} = ?',
        whereArgs: [orderId, productId]);
  }

  // ==================== CLOSE DB ====================
  // closes the FlutterDatabase connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
