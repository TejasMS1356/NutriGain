import 'package:flutter/material.dart';
import 'package:protiencaluclator/food_card.dart';
import 'package:protiencaluclator/global_varialbles.dart';
import 'package:protiencaluclator/fooddetails_page.dart';
import 'package:protiencaluclator/protien_count.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> product;
  const HomePage({super.key, required this.product});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController sc = TextEditingController();
  List<Map<String, dynamic>> fps = [];
  List<bool> checkedItems = [];
  final List<String> categories = [
    'All',
    'Vegetables',
    'Fruits',
    'veg',
    'non veg',
    'Dairy',
  ];
  @override
  void initState() {
    super.initState();
    fps = products;
    checkedItems = List<bool>.filled(fps.length, false);
  }

  int currentpage = 1;
  late String selected_category = categories[0];
  void filterProducts(String query) {
    setState(() {
      fps =
          products.where((product) {
            final name = product['name'].toString().toLowerCase();
            return name.contains(query.toLowerCase());
          }).toList();
      checkedItems = List<bool>.filled(fps.length, false);
    });
  }

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
        // In home_page.dart, inside AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FooddetailsPage(product: products[0]),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 45)),
                Expanded(
                  child: TextField(
                    controller: sc,
                    onChanged: filterProducts,

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
                itemCount: fps.length,
                itemBuilder: (context, index) {
                  final product = fps[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FooddetailsPage(
                              product: product.cast<String, Object>(),
                            );
                          },
                        ),
                      );
                    },
                    child: FoodCard(
                      name: product['name'] as String,
                      image: product['imageUrl'] as String,
                      protein: (product['protein'] as int).toDouble(),
                      calories: (product['calories'] as int).toDouble(),
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

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Always show Home as selec   ted
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProtienCount(product: products),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Protein count",
          ),
        ],
      ),
    );
  }
}

