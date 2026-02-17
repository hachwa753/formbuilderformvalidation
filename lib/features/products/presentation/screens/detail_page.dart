import 'package:flutter/material.dart';
import 'package:flutter_api_fetch/core/extensions/extension.dart';
import 'package:flutter_api_fetch/features/products/domain/model/product.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title.captitalizeFirst(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              product.body.captitalizeFirst(),
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
