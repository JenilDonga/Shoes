import 'package:flutter/material.dart';
import 'package:shoes/pages/CheckoutPage.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all, color: Colors.red),
            tooltip: 'Clear Cart',
            onPressed: _clearCart,
          ),
        ],
      ),
      body: _buildCartItems(totalPrice),
      bottomNavigationBar: _buildBottomNavBar(totalPrice),
    );
  }

  // Helper method to calculate total price
  double _calculateTotalPrice() {
    double total = 0;
    for (var item in widget.cartItems) {
      total += double.parse(item['price'].replaceAll('\$', '')) * item['quantity'];
    }
    return total;
  }

  // Helper method to build the cart items list
  Widget _buildCartItems(double totalPrice) {
    return widget.cartItems.isEmpty
        ? Center(child: Text('Your cart is empty.', style: TextStyle(fontSize: 20, color: Colors.grey)))
        : ListView.builder(
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        return _buildCartItem(widget.cartItems[index], index);
      },
    );
  }

  // Helper method to build each cart item
  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item['image'],
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['price'],
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  _buildQuantityControls(item, index),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for quantity controls
  Widget _buildQuantityControls(Map<String, dynamic> item, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (item['quantity'] > 1) {
                item['quantity']--;
              }
            });
          },
          tooltip: 'Decrease Quantity',
        ),
        Text(
          '${item['quantity']}',
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              item['quantity']++;
            });
          },
          tooltip: 'Increase Quantity',
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeItem(index),
          tooltip: 'Remove Item',
        ),
      ],
    );
  }

  // Helper method to build the bottom navigation bar
  Widget _buildBottomNavBar(double totalPrice) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                _checkout(totalPrice);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to remove an item and show a snackbar
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed from cart.'),
      ),
    );
  }

  // Method to clear the cart and show a snackbar
  void _clearCart() {
    setState(() {
      widget.cartItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cart cleared.'),
      ),
    );
  }

  // Method to handle checkout
  void _checkout(double totalPrice) {
    if (widget.cartItems.isEmpty) {
      // Show an error message if the cart is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your cart is empty. Add items to the cart before checking out.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (totalPrice <= 0) {
      // Show an error message if the total price is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Total price must be greater than \$0 to proceed to checkout.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to the checkout page if validations are passed
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cartItems: widget.cartItems),
      ),
    );
  }
}
