import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/modules/otherModules/bmiresult/BMIResult.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  // ignore: non_constant_identifier_names
  bool Ismale = true;
  double height = 170.0;

  int weight = 90;
  int age = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'BMI Calculator',
            style: TextStyle(color: Colors.white),
          ),
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Ismale = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Ismale ? Colors.blue : Colors.grey[900]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/male.png'),
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Ismale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: !Ismale ? Colors.blue : Colors.grey[900]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/female.png'),
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.black,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[900]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CM',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Slider(
                        value: height,
                        max: 200.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                          print(height.round());
                        }),
                  ],
                ),
              ),
            ),
          )),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[900]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                'AGE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Text(
                              '$age',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'age--',
                                  
                                  onPressed: () {
                                    setState(() {
                                      if (age > 0) {
                                        age--;
                                      }
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.remove),
                                ),
                                FloatingActionButton(
                                  
                                  onPressed:
                                   () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  mini: true,
                                  
                                  heroTag: 'age--',
                                  child: Icon(Icons.add),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[900]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                'WEIGHT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Text(
                              '$weight',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'weight--',
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 0) {
                                        weight--;
                                      }
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.remove),
                                ),
                                FloatingActionButton(
                                  heroTag: 'weight ++',
                                  onPressed: () {
                                    setState(() {
                                      if (weight < 200) {
                                        weight++;
                                      }
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.add),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              color: Colors.red,
              child: MaterialButton(
                  onPressed: () {
                    // ignore: non_constant_identifier_names
                    var Result = weight / pow(height / 100, 2);
                    print(Result.round());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BmiResult(
                          age: age,
                          ismale: Ismale,
                          result: Result.round(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
