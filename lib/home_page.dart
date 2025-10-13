import 'package:flutter/material.dart';
import 'package:protiencaluclator/food_card.dart';
import 'package:protiencaluclator/global_varialbles.dart';
import 'package:protiencaluclator/fooddetails_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    'All',
    'Vegetables',
    'Fruits',
    'veg',
    'non veg',
    'Dairy',
  ];
  late String selected_category = categories[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 84, 95, 134),

        title: Text(
          'Nutrigain',

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: const Color.fromARGB(255, 208, 206, 221),
          ),
        ),
        leading: Icon(
          Icons.fitness_center,
          color: Color.fromARGB(255, 208, 206, 221),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 45)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "search",

                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(54, 47, 47, 1),
                      ),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_category = cat;
                        });
                      },
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(
                          color: Color.fromARGB(255, 84, 95, 134),
                        ),
                        backgroundColor:
                            selected_category == cat
                                ? Color.fromARGB(255, 146, 159, 206)
                                : Colors.white,
                        padding: EdgeInsets.all(15),
                        label: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FooddetailsPage(product: product);
                          },
                        ),
                      );
                    },
                    child: FoodCard(
                      name: product['name'] as String,
                      image: product['imageUrl'] as String,
                      backgroundcolor:
                          index.isEven
                              ? Color.fromRGBO(72, 129, 160, 1)
                              : Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
