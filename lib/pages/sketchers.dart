// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'SingleProductPage.dart';

import 'home_page.dart';

class SketchersPage extends StatefulWidget {
  const SketchersPage({super.key});

  @override
  _SketchersPageState createState() => _SketchersPageState();
}

class _SketchersPageState extends State<SketchersPage> {
  final List<Map<String, String>> _sketchersProducts = [
    {
      'image': 'assets/images/Sketchers/1.webp',
      'name': 'Sketchers 1',
      'detail': 'Go Walk 5',
      'price': '\$80'
    },
    {
      'image': 'assets/images/Sketchers/2.jpg',
      'name': 'Sketchers 2',
      'detail': 'Max Cushioning',
      'price': '\$100'
    },
    {
      'image': 'assets/images/Sketchers/3.jpg',
      'name': 'Sketchers 3',
      'detail': 'D Lites',
    'price': '\$90'
    },
    {
      'image': 'assets/images/Sketchers/4.jpg',
      'name': 'Sketchers 4',
      'detail': 'On-The-Go 600',
      'price': '\$85'
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = _sketchersProducts.where((product) {
      return product['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sketchers'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Sketchers shoes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Grid view for Sketchers shoes
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                    onTap: () {
                      // Navigate to SingleProductPage when card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SingleProductPage(product: product),
                        ),
                      );
                    },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            filteredProducts[index]['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filteredProducts[index]['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          filteredProducts[index]['detail']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filteredProducts[index]['price']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Container(
                      //     width:112,
                      //     height: 35,
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //         colors: [Colors.black, Colors.grey],
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => HomePage()),
                      //         );
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.transparent,
                      //         shadowColor: Colors.transparent,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         minimumSize: Size(double.infinity, 36),
                      //       ),
                      //       child: Text(
                      //         'BUY',
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: SketchersPage(),
  ));
}
