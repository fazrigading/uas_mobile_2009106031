import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:uas_pemo_2009106031/controllers/product_controller.dart';
import 'package:uas_pemo_2009106031/views/product_tile.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final ProductController controllerNama = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UAS Mobile"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            final snackBar2 = SnackBar(
              content: const Text('Handak mangganti nama kah ikam?'),
              action: SnackBarAction(
                label: 'Diam aja.',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              }),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              final snackBar3 = SnackBar(
                content: const Text('Baluman jua fiturnya ngitu, wal.'),
                action: SnackBarAction(
                  label: 'Uma malasnya.',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar3);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Welcome, ${controllerNama.name.value}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {
                      productController.pov.value = 2;
                    }),
                IconButton(
                    icon: const Icon(Icons.grid_view),
                    onPressed: () {
                      productController.pov.value = 1;
                    }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (productController.pov.value == 1) {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: productController.productList.length,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return ProductTile2(productController.productList[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                } else {
                  return ListView.builder(
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return ProductTile1(productController.productList[index]);
                    },
                  );
                }
              }
            }),
          )
        ],
      ),
    );
  }
}
