import 'package:flutter/material.dart';

class SalesMySalesScreen extends StatelessWidget {
  const SalesMySalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("My Sales"),
      ),
      body: const Center(
        child: Text("My Sales Screen"),
      ),
    );
  }
}