import 'package:flutter/material.dart';
import 'customer_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background_image.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'lets begin',
                style: TextStyle(fontSize: 24.0, color: Color.fromARGB(255, 108, 223, 114)),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerListScreen(),
                    ),
                  );
                },
                child: Text('View All Customers'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
