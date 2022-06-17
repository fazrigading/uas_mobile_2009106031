import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:uas_pemo_2009106031/models/product.dart';
import 'package:uas_pemo_2009106031/services/remote_services.dart';

class ProductController extends GetxController {
  var name = "User".obs;
  var pov = 1.obs;
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  final nameForm = TextEditingController();
  void updatename() {
    name.value = nameForm.text;
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
