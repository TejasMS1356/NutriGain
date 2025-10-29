import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  // final String description;
  final String image;
  final double protein;
  final double calories;

  const FoodCard({
    super.key,
    required this.name,
    // required this.description,
    required this.image,
    required Color backgroundcolor,
    required this.protein,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 103, 146, 174),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (name),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "protein: $protein g, calories: $calories kcal per 100g ",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.fill,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

