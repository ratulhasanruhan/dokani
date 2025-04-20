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
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.details, arguments: product),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                product.images.first,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('৳${product.price}',
                                    style: const TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 14),
                                    Text('${product.rating}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        );
      }),
    );
  }
}
