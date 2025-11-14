import 'package:flutter/material.dart';
import 'package:protiencaluclator/global_varialbles.dart';

class ProtienCount extends StatefulWidget {
  final List<Map<String, dynamic>> product;

  const ProtienCount({super.key, required this.product});

  @override
  _ProtienCountState createState() => _ProtienCountState();
}

class _ProtienCountState extends State<ProtienCount> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];
  List<TextEditingController> quantityControllers = [];

  int totalProtein = 0;
  int totalCalories = 0;

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _initializeQuantityControllers();
  }

  void _initializeQuantityControllers() {
    quantityControllers = List.generate(
      filteredProducts.length,
      (index) => TextEditingController(text: ''), // Default to 100g/ml
    );
  }

  void calculateTotals() {
    totalProtein = 0;
    totalCalories = 0;

    for (int i = 0; i < filteredProducts.length; i++) {
      final quantityText = quantityControllers[i].text;
      if (quantityText.isNotEmpty) {
        final quantity = double.tryParse(quantityText) ?? 0.0;
        if (quantity > 0) {
          // Calculate based on the entered quantity (proportion to 100g)
          final proteinPer100g = filteredProducts[i]['protein'] as int;
          final caloriesPer100g = filteredProducts[i]['calories'] as int;

          totalProtein += ((proteinPer100g * quantity) / 100).round();
          totalCalories += ((caloriesPer100g * quantity) / 100).round();
        }
      }
    }
    setState(() {});
  }

  void clearAll() {
    setState(() {
      for (final controller in quantityControllers) {
        controller.text = '100'; // Reset to default 100g/ml
      }
      totalProtein = 0;
      totalCalories = 0;
      searchController.clear();
      filteredProducts = products;
      _initializeQuantityControllers();
    });
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts =
          products.where((product) {
            final name = product['name'].toString().toLowerCase();
            return name.contains(query.toLowerCase());
          }).toList();
      _initializeQuantityControllers();
    });
  }

  @override
  void dispose() {
    for (final controller in quantityControllers) {
      controller.dispose();
    }
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 145, 230),
        title: Text(
          'Protein Count',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                labelText: 'Search food item',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Total Protein: $totalProtein g\nTotal Calories: $totalCalories kcal',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                final name = product['name'] as String;
                final image = product['imageUrl'] as String;
                final protein = product['protein'] as int;
                final calories = product['calories'] as int;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Image.asset(
                      image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Protein: $protein g, Calories: $calories kcal per 100g",
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('Quantity:'),
                            SizedBox(width: 8),
                            Container(
                              width: 80,
                              child: TextField(
                                controller: quantityControllers[index],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'grams/ml',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                                onChanged: (value) {
                                  // Optional: Recalculate automatically when quantity changes
                                  // calculateTotals();
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Text('g/ml'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calculateTotals,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Calculate'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: clearAll,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 244, 245, 248),
                  ),
                  child: Text('Clear'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


