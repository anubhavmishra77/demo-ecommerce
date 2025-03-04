import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<Product> allProducts = <Product>[].obs;
  RxList<Product> displayedProducts = <Product>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMoreData = true.obs;

  final int _itemsPerPage = 8;
  int _currentIndex = 0;

  final RxSet<int> _favorites = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        _currentIndex = 0;
        displayedProducts.clear();
        hasMoreData.value = true;
      }

      if (_currentIndex == 0) {
        isLoading.value = true;
        // here we Fetch all products but only display first batch
        final products = await _apiService.getProducts();
        allProducts.value = products;
        _loadInitialBatch();
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _loadInitialBatch() {
    final endIndex = _itemsPerPage;
    if (endIndex <= allProducts.length) {
      displayedProducts.value = allProducts.sublist(0, endIndex);
      _currentIndex = endIndex;
      hasMoreData.value = _currentIndex < allProducts.length;
    } else {
      displayedProducts.value = allProducts;
      hasMoreData.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!isLoadingMore.value && hasMoreData.value) {
      isLoadingMore.value = true;

      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay for better UI 

      final endIndex = _currentIndex + _itemsPerPage;
      final nextBatch = allProducts.sublist(
        _currentIndex,
        endIndex <= allProducts.length ? endIndex : allProducts.length,
      );

      displayedProducts.addAll(nextBatch);
      _currentIndex += _itemsPerPage;

      hasMoreData.value = _currentIndex < allProducts.length;
      isLoadingMore.value = false;
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      _currentIndex = 0;
      displayedProducts.clear();
      _loadInitialBatch();
      return;
    }

    final filteredList = allProducts
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    displayedProducts.value = filteredList;
    hasMoreData.value = false;
  }

  bool isFavorite(int productId) {
    return _favorites.contains(productId);
  }

  void toggleFavorite(int productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
  }
}
