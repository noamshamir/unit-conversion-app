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
      appBar: AppBar(title: Text('Unit Converter')),
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
  List<DropdownMenuItem<String>> lengthMeasurements = const [
    DropdownMenuItem(child: Text("Kilometer"), value: "1000"),
    DropdownMenuItem(child: Text("Hectometer"), value: "100"),
    DropdownMenuItem(child: Text("Decameter"), value: "10"),
    DropdownMenuItem(child: Text("Meter"), value: "1"),
    DropdownMenuItem(child: Text("Decimeter"), value: "0.1"),
    DropdownMenuItem(child: Text("Centimeter"), value: "0.01"),
    DropdownMenuItem(child: Text("Millimeter"), value: "0.001"),
    DropdownMenuItem(child: Text("Micrometer"), value: "0.000001"),
    DropdownMenuItem(child: Text("Nanometer"), value: "0.000000001"),
    DropdownMenuItem(child: Text("Miles"), value: "1609.344"),
    DropdownMenuItem(child: Text("Yard"), value: "0.9144"),
    DropdownMenuItem(child: Text("Foot"), value: "0.3048"),
    DropdownMenuItem(child: Text("Inch"), value: "0.0254"),
  ];

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  double numberValue1 = 0;
  double numberValue2 = 0;
  double conversionFactor = 1;

  String conversionFactor1 = '1';
  String conversionFactor2 = '1';

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
      numberValue2 = numberValue1 * conversionFactor;
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
      numberValue1 = numberValue2 / conversionFactor;
      myController1.text = numberValue1.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
                labelText: 'type a number already'),
            onChanged: (text) => convert1(text),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: DropdownButton<String>(
            value: conversionFactor1,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.blue),
            isExpanded: true,
            underline: Container(
              height: 0,
              color: Colors.blueAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                conversionFactor1 = value!;
                conversionFactor = double.parse(conversionFactor1) /
                    double.parse(conversionFactor2);
                try {
                  myController1.text =
                      (double.parse(myController2.text) / conversionFactor)
                          .toString();
                } catch (e) {}
              });
            },
            items: lengthMeasurements),
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
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
                labelText: 'type a number already'),
            onChanged: (text) => convert2(text),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: DropdownButton<String>(
            value: conversionFactor2,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.blue),
            isExpanded: true,
            underline: Container(
              height: 0,
              color: Colors.blueAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                conversionFactor2 = value!;
                conversionFactor = double.parse(conversionFactor1) /
                    double.parse(conversionFactor2);
                try {
                  myController2.text =
                      (double.parse(myController1.text) * conversionFactor)
                          .toString();
                } catch (e) {}
              });
            },
            items: lengthMeasurements),
      )
    ]);
  }
}
