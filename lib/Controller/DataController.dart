
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataController{
  final List<Product> _items = [];
  List<Product> get items => _items;
  String? _errorMessage;

  Future<bool> getProduct(int limit, int skip) async {
    _errorMessage = null;
    final int skip = _items.length;
    final Uri url = Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List productsJson = data['products'];
        final List<Product> fetchedProducts = productsJson.map((json) => Product.fromJson(json)).toList();

        //add data retrieved from CDN to item list
        _items.addAll(fetchedProducts);

      } else {
        _errorMessage = 'Failed to load products (${response.statusCode})';
      }
    } catch (_) {
      _errorMessage = 'Failed to catch data from the server';
    }
    return false;
  }


  Future<bool> getProductByID(int id) async {
    _errorMessage = null;
    final Uri url = Uri.parse('https://dummyjson.com/products/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List productsJson = data['products'];
        final List<Product> fetchedProducts = productsJson.map((json) => Product.fromJson(json)).toList();

        //add data retrieved from CDN to item list
        _items.addAll(fetchedProducts);

      } else {
        _errorMessage = 'Failed to load products (${response.statusCode})';
      }
    } catch (_) {
      _errorMessage = 'Failed to catch data from the server';
    }
    return false;
  }

  Future<bool> getProductSearch(String keyword) async {
    _errorMessage = null;
    final Uri url = Uri.https('dummyjson.com', '/products/search', {'q': keyword});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List productsJson = data['products'];
        final List<Product> fetchedProducts = productsJson.map((json) => Product.fromJson(json)).toList();

        _items.clear();
        _items.addAll(fetchedProducts);
        return true;

      } else {
        _errorMessage = 'Failed to load products (${response.statusCode})';
      }
    } catch (_) {
      _errorMessage = 'Failed to catch data from the server';
    }
    return false;
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}