import 'package:flutter/material.dart';

class AppBarTest extends StatelessWidget {
  const AppBarTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final x = SnackBar(
              content: Text('snakebar'),
            );
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('show snakebar'),
          onPressed: () {
           

            ScaffoldMessenger.of(context).showSnackBar(x);
          },
        ),
      ),
    );
  }
}
