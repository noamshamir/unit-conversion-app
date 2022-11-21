import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

NumberInputWidget input1 = NumberInputWidget();
NumberInputWidget input2 = NumberInputWidget();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(title: Text('Hello World!')),
      body: NumberInputWidget(),
    );
  }
}

class NumberInputWidget extends StatefulWidget {
  NumberInputWidget({super.key});

  @override
  State<NumberInputWidget> createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  double numberValue1 = 0;
  double numberValue2 = 0;
  double conversionFactor = 100;

  String dropdownValue = '1';

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
      numberValue1 = double.parse(text);
      numberValue2 = numberValue1 / conversionFactor;
      myController2.text = numberValue2.toString();
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
      numberValue2 = double.parse(text);
      numberValue1 = numberValue2 * conversionFactor;
      myController1.text = numberValue1.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.blue),
          underline: Container(
            height: 0,
            color: Colors.blueAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: const [
            DropdownMenuItem(child: Text("Meter"), value: "1"),
            DropdownMenuItem(child: Text("Centimeter"), value: ".01"),
            DropdownMenuItem(child: Text("Kilometer"), value: "1000"),
          ]),
      TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
        ],
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        controller: myController1,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.numbers),
            labelText: 'type a number already'),
        onChanged: (text) => convert1(text),
      ),
      TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
        ],
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        controller: myController2,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.numbers),
            labelText: 'type a number already'),
        onChanged: (text) => convert2(text),
      ),
    ]);
  }
}
