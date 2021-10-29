import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final int result;
  final bool ismale;
  final int age;
  BmiResult({
    required this.result,
    required this.age,
    required this.ismale,
  });
  Widget underWeight() {
    return Text('Underweight',style: TextStyle(color: Colors.white,fontSize: 50),);
  }

  Widget normal() {
   return Text('Normal Weight',style: TextStyle(color: Colors.white,fontSize: 50),);
  }
Widget overweight() {
   return Text(' Over Weight',style: TextStyle(color: Colors.white,fontSize: 50),);
  }
  Widget obease() {
   return Text('Obease',style: TextStyle(color: Colors.white,fontSize: 50),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Center(child: Text('BMI RESULT')),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender :${ismale ? 'male' : 'female'}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'age : ($age)',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Result : $result',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          SizedBox(
            height: 50,
          ),
          if (result < 18.5)
                    underWeight()                      
                    else if (result >= 18.5&&result<25)
                    normal()
                    else if(result>=25&&result<=29.9)
                    overweight()
                    else obease(),

           
          SizedBox(
            height: 100,
          ),
            Container(
              color: Colors.black,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    
                    Text(
                      'Underweight = <18.5\nNormal weight = 18.5–24.9\nOverweight = 25–29.9\nObesity = BMI of 30 or greater',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
