import 'package:dokani/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../utils/routes.dart';
import '../widget/shimmer_loader.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ Dokani'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildShimmer();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: controller.search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search products...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Obx(() => ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  FilterChip(
                    label: const Text("All"),
                    selected: controller.selectedCategory.value == '',
                    onSelected: (_) => controller.filterByCategory(''),
                  ),
                  ...controller.categories.map(
                        (cat) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(cat),
                        selected: controller.selectedCategory.value == cat,
                        onSelected: (_) => controller.filterByCategory(cat),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              child: Obx(() => GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return ProductCard(product: product);
                },
              )),
            ),
          ],
        );
      }),
    );
  }
}
