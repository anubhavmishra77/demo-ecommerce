// import 'package:dio/dio.dart';
// import '../models/product_model.dart';

// class ApiService {
//   final Dio _dio = Dio();
//   final String _baseUrl = 'https://fakestoreapi.com';
//   final int limit = 8; // Number of items per page

//   Future<List<Product>> getProducts({int start = 0}) async {
//     try {
//       // Using limit and start parameters for pagination
//       final response = await _dio.get(
//         '$_baseUrl/products',
//         queryParameters: {
//           'limit': limit,
//           'skip': start,
//         },
//       );
//       return (response.data as List)
//           .map((item) => Product.fromJson(item))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to load products: $e');
//     }
//   }
// }
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://fakestoreapi.com';
  final int limit = 8; // Number of items per page

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('$_baseUrl/products');
      final List<Product> allProducts = (response.data as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return allProducts;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
