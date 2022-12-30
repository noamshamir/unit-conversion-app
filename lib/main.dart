import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:math_parser/math_parser.dart';

String currentMeasurement = "lengths";

ConversionForm input1 = ConversionForm();
ConversionForm input2 = ConversionForm();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Unit Converter',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          backgroundColor: Colors.grey.shade50,
        ),
        body: ConversionForm());
  }
}

class ConversionForm extends StatefulWidget {
  ConversionForm({super.key});

  @override
  State<ConversionForm> createState() => _ConversionFormState();
}

class _ConversionFormState extends State<ConversionForm> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  double numberValue1 = 0;
  double numberValue2 = 0;

  String unit1 = "1";
  String unit2 = "1";

  Map formulas = {
    "temperatures": [
      {"name": "celsius", "toCanonical": "x", "fromCanonical": "x"},
      {
        "name": "fahrenheit",
        "toCanonical": "(x-32)*5/9",
        "fromCanonical": "9/5*x + 32"
      },
      {"name": "kelvin", "toCanonical": "x-273.15", "fromCanonical": "x+273.15"}
    ],
    "lengths": [
      {"name": "meter", "toCanonical": "x", "fromCanonical": "x"},
      {
        "name": "inch",
        "toCanonical": "x / 39.370079",
        "fromCanonical": "x * 39.370079"
      },
      {
        "name": "centimeter",
        "toCanonical": "x / 100",
        "fromCanonical": "x * 100"
      },
      {
        "name": "feet",
        "toCanonical": "x / 3.28084",
        "fromCanonical": "x * 3.28084"
      },
      {
        "name": "mile",
        "toCanonical": "x / 0.000621371",
        "fromCanonical": "x * 0.000621371"
      },
      {
        "name": "kilometer",
        "toCanonical": "x / 0.001",
        "fromCanonical": "x * 0.001"
      },
      {
        "name": "yard",
        "toCanonical": "x / 1.09361",
        "fromCanonical": "x * 1.09361"
      }
    ],
    "volumes": [
      {"name": "liter", "toCanonical": "x", "fromCanonical": "x"},
      {
        "name": "gallon",
        "toCanonical": "x / 0.264172",
        "fromCanonical": "x * 0.264172"
      },
      {
        "name": "milliliter",
        "toCanonical": "x / 1000",
        "fromCanonical": "x * 1000"
      },
      {
        "name": "cup",
        "toCanonical": "x / 4.22675",
        "fromCanonical": "x * 4.22675"
      },
      {
        "name": "fluid ounce",
        "toCanonical": "x / 33.814",
        "fromCanonical": "x * 33.814"
      },
      {
        "name": "liquid quart",
        "toCanonical": "x / 1.05669",
        "fromCanonical": "x * 1.05669"
      },
      {
        "name": "tablespoon",
        "toCanonical": "x / 67.628",
        "fromCanonical": "x * 67.628"
      },
      {
        "name": "teaspoon",
        "toCanonical": "x / 202.884",
        "fromCanonical": "x * 202.884"
      },
      {
        "name": "cubic meter",
        "toCanonical": "x / 0.001",
        "fromCanonical": "x * 0.001"
      },
      {
        "name": "cubic feet",
        "toCanonical": "x / 0.0353147",
        "fromCanonical": "x * 0.0353147"
      },
      {
        "name": "cubic inch",
        "toCanonical": "x / 61.0237",
        "fromCanonical": "x * 61.0237"
      },
    ]
  };

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
  }

  void convert1(text) {
    setState(() {
      if (text == "-" || text == "") {
        numberValue1 = 0;
        numberValue2 = 0;
        myController2.text = "";
        return;
      }
      myController2.text = convert(
              formulas[currentMeasurement][int.parse(unit1) - 1]["toCanonical"],
              formulas[currentMeasurement][int.parse(unit2) - 1]
                  ["fromCanonical"],
              num.parse(text))
          .toString();
    });
  }

  void convert2(text) {
    setState(() {
      if (text == "-" || text == "") {
        numberValue1 = 0;
        numberValue2 = 0;
        myController1.text = "";
        return;
      }
      myController1.text = convert(
              formulas[currentMeasurement][int.parse(unit2) - 1]["toCanonical"],
              formulas[currentMeasurement][int.parse(unit1) - 1]
                  ["fromCanonical"],
              num.parse(text))
          .toString();
    });
  }

  num? convert(
      String toCanonicalFormula, String fromCanonicalFormula, num fromValue) {
    print("Value to convert: " + fromValue.toString());
    print("To:" + toCanonicalFormula);
    MathExpression exp =
        MathNodeExpression.fromString(toCanonicalFormula, variableNames: {'x'});
    num? canonicalValue = exp.calc(MathVariableValues({'x': fromValue}));
    print("Canonical value: " + canonicalValue.toString());
    // Convert the result from canonical
    print("From: " + fromCanonicalFormula);
    exp = MathNodeExpression.fromString(fromCanonicalFormula,
        variableNames: {'x'});
    num? convertedValue = exp.calc(MathVariableValues({'x': canonicalValue!}));
    print("Converted value: " + convertedValue.toString());
    return convertedValue;
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> measurements = [];
    if (currentMeasurement == "lengths") {
      measurements = const [
        DropdownMenuItem(child: Text("Meter"), value: "1"),
        DropdownMenuItem(child: Text("Inch"), value: "2"),
        DropdownMenuItem(child: Text("Centimeter"), value: "3"),
        DropdownMenuItem(child: Text("Feet"), value: "4"),
        DropdownMenuItem(child: Text("Mile"), value: "5"),
        DropdownMenuItem(child: Text("Kilometer"), value: "6"),
        DropdownMenuItem(child: Text("Yard"), value: "7"),
      ];
    } else if (currentMeasurement == "temperatures") {
      measurements = const [
        DropdownMenuItem(child: Text("Celsius"), value: "1"),
        DropdownMenuItem(child: Text("Fahrenheit"), value: "2"),
        DropdownMenuItem(child: Text("Kelvin"), value: "3"),
      ];
    } else if (currentMeasurement == "volumes") {
      measurements = const [
        DropdownMenuItem(child: Text("Liter"), value: "1"),
        DropdownMenuItem(child: Text("Gallon"), value: "2"),
        DropdownMenuItem(child: Text("Milliliter"), value: "3"),
        DropdownMenuItem(child: Text("Cup"), value: "4"),
        DropdownMenuItem(child: Text("Fluid Ounce"), value: "5"),
        DropdownMenuItem(child: Text("Liquid Quart"), value: "6"),
        DropdownMenuItem(child: Text("Tablespoon"), value: "7"),
        DropdownMenuItem(child: Text("Teaspoon"), value: "8"),
        DropdownMenuItem(child: Text("Cubic Meter"), value: "9"),
        DropdownMenuItem(child: Text("Cubic Feet"), value: "10"),
        DropdownMenuItem(child: Text("Cubic Inches"), value: "11"),
      ];
    }
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: DropdownButton<String>(
              underline: Container(
                height: 0,
                color: Colors.blue,
              ),
              isExpanded: true,
              value: currentMeasurement == "lengths"
                  ? "1"
                  : currentMeasurement == "temperatures"
                      ? "2"
                      : "3",
              items: [
                DropdownMenuItem(
                    value: "1",
                    child: Row(
                      children: [
                        Icon(Icons.straighten_outlined,
                            size: 20, color: Colors.black),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          ' Length',
                          style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )),
                DropdownMenuItem(
                    value: "2",
                    child: Row(
                      children: [
                        Icon(Icons.thermostat_outlined,
                            size: 20, color: Colors.black),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          ' Temperature',
                          style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )),
                DropdownMenuItem(
                    value: "3",
                    child: Row(
                      children: [
                        Icon(Icons.science_outlined,
                            size: 20, color: Colors.black),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          ' Volume',
                          style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )),
              ],
              onChanged: (String? value) {
                if (value == "1") {
                  currentMeasurement = "lengths";
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                } else if (value == "2") {
                  currentMeasurement = "temperatures";
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                } else if (value == "3") {
                  currentMeasurement = "volumes";
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                }
                // do something here
              })),
      Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
            ],
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            controller: myController1,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Type a number...'),
            onChanged: (text) => convert1(text),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: DropdownButton<String>(
            value: unit1,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.black),
            isExpanded: true,
            underline: Container(
              height: 0,
              color: Colors.blue,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                unit1 = value!;
                try {
                  myController1.text = convert(
                          formulas[currentMeasurement][int.parse(unit2) - 1]
                              ["toCanonical"],
                          formulas[currentMeasurement][int.parse(unit1) - 1]
                              ["fromCanonical"],
                          num.parse(myController2.text))
                      .toString();
                } catch (e) {
                  print(e.toString());
                }
              });
            },
            items: measurements),
      ),
      Divider(
        thickness: 2.0,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
            ],
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            controller: myController2,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Type a number...'),
            onChanged: (text) => convert2(text),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: DropdownButton<String>(
            value: unit2,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.black),
            isExpanded: true,
            underline: Container(
              height: 0,
              color: Colors.black,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.

              setState(() {
                unit2 = value!;
                try {
                  myController2.text = convert(
                          formulas[currentMeasurement][int.parse(unit1) - 1]
                              ["toCanonical"],
                          formulas[currentMeasurement][int.parse(unit2) - 1]
                              ["fromCanonical"],
                          num.parse(myController1.text))
                      .toString();
                } catch (e) {
                  print(e.toString());
                }
              });
            },
            items: measurements),
      )
    ]);
  }
}
