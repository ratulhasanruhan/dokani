import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/ProductModel.dart';

class ProductListController extends GetxController {
  var isLoading = true.obs;
  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  void fetchAll() async {
    await Future.wait([
      fetchProducts(),
      fetchCategories(),
    ]);
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=100'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<ProductModel> loaded = List<ProductModel>.from(
            data['products'].map((json) => ProductModel.fromJson(json)));
        products.value = loaded;
        filteredProducts.value = loaded;
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
      if (response.statusCode == 200) {
        categories.value = List<String>.from(json.decode(response.body));
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void search(String query) async {
    searchQuery(query);
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/search?q=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        filteredProducts.value = List<ProductModel>.from(
            data['products'].map((json) => ProductModel.fromJson(json)));
      }
    }
  }

  void filterByCategory(String category) async {
    selectedCategory(category);
    if (category == '') {
      filteredProducts.value = products;
    } else {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/category/$category'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        filteredProducts.value = List<ProductModel>.from(
            data['products'].map((json) => ProductModel.fromJson(json)));
      }
    }
  }
}
