import 'package:flutter/material.dart';

class SalesMyOrderScreen extends StatefulWidget {
  const SalesMyOrderScreen({super.key});

  @override
  State<SalesMyOrderScreen> createState() => _SalesMyOrderScreenState();
}

class _SalesMyOrderScreenState extends State<SalesMyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('Sales My Order Screen')),
    );
  }
}