import 'package:flutter/material.dart';

class FooddetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const FooddetailsPage({super.key, required this.product});

  @override
  State<FooddetailsPage> createState() => _FooddetailsPageState();
}

class _FooddetailsPageState extends State<FooddetailsPage> {
  @override
  Widget build(BuildContext context) {
    final name = widget.product['name'] as String;
    final image = widget.product['imageUrl'] as String;
    final description = widget.product['description'] as String;
    final protein = widget.product['protein'] as int;
    final calories = widget.product['calories'] as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 145, 230),
        title: Text(
          'Food Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.asset(image, height: 250, width: 300, fit: BoxFit.fill),

          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 103, 131, 188),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  "Protien: $protein g",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Calories: $calories kcal",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
