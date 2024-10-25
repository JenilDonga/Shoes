import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoes/pages/CartPage.dart';
import 'dart:async';
import 'puma.dart';
import 'adidas.dart';
import 'sketchers.dart';
import 'sparks.dart';
import 'Loginpage.dart'; // Import the LoginPage
import 'SingleProductPage.dart'; // Import the SingleProductPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  final CarouselController _carouselController = CarouselController();
  final List<Map<String, dynamic>> _cartItems = [];

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(color: Colors.black)),
    Text('Search Page', style: TextStyle(color: Colors.black)),
    Text('Add to Cart Page', style: TextStyle(color: Colors.black)),
    Text('Profile Page', style: TextStyle(color: Colors.black)),
  ];

  final List<Map<String, String>> _products = [
    {
      'image': 'assets/images/air-force-1-07-shoes-0XGfD7.png',
      'name': 'NIKE',
      'detail': 'Air Force 1',
      'price': '\$120'
    },
    {
      'image': 'assets/images/slider3.jpg',
      'name': 'SKETCHERS',
      'detail': 'Go Walk 5',
      'price': '\$80'
    },
    {
      'image': 'assets/images/slider1.jpg',
      'name': 'adidas',
      'detail': 'Ultraboost 21',
      'price': '\$180'
    },
  ];

  final List<String> _categories = ['adidas', 'Nike', 'Puma', 'Sketchers', 'Sparks'];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < _products.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _carouselController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else if (index == 2) {
      // Navigate to the CartPage instead of opening the cart modal
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage(cartItems: _cartItems)),
      );
    }
  }

  void _navigateToCategory(String category) {
    Widget page;

    switch (category) {
      case 'adidas':
        page = AdidasPage();
        break;
      case 'Puma':
        page = PumaPage();
        break;
      case 'Sketchers':
        page = SketchersPage();
        break;
      case 'Sparks':
        page = SparksPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _navigateToSingleEventPage(Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleProductPage(product: product),
      ),
    );
  }

  void _addToCart(Map<String, String> product) {
    setState(() {
      _cartItems.add({
        'name': product['name'],
        'price': product['price'],
        'image': product['image'],
        'quantity': 1 // Store quantity as an integer
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} has been added to the cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var carouselController = _carouselController;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the CartPage when the cart icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cartItems: _cartItems)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Slider section
            SizedBox(
              height: 240,
              child: CarouselSlider(
                items: _products.map((product) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                product['image']!,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    product['name']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToCategory(category);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Products List
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7, // Adjust this ratio for a better fit
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return GestureDetector(
                        onTap: () => _navigateToSingleEventPage(product),
                        child: Card(
                          elevation: 8, // Increased shadow for a more pronounced effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Image.asset(
                                  product['image']!,
                                  height: 120, // Decreased height for better fit
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16, // Adjusted font size
                                  ),
                                ),
                              ),
                              Text(
                                product['detail']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  product['price']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              Expanded( // Use Expanded to avoid overflow
                                child: ElevatedButton(
                                  onPressed: () {
                                    _addToCart(product);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('Add to Cart'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

extension on CarouselController {
  void animateToPage(int currentPage, {required Duration duration, required Cubic curve}) {}
}
