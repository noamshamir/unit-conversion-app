import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final List<DropdownMenuItem<String>> temperatures = const [
  DropdownMenuItem(child: Text("Celcius"), value: "2"),
  DropdownMenuItem(child: Text("Fahrenheit"), value: "3"),
  DropdownMenuItem(child: Text("Kelvin"), value: "4")
];
final List<DropdownMenuItem<String>> lengths = const [
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
  DropdownMenuItem(child: Text("Nautical Mile"), value: "0.000539957"),
  DropdownMenuItem(child: Text("Parsec"), value: "30856775812800000"),
  DropdownMenuItem(child: Text("Light Year"), value: "9460730472580000"),
  DropdownMenuItem(
      child: Text("Planck Length"),
      value: "161605000000000000000000000000000000")
];

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
            actions: [
              PopupMenuButton(
                  icon: Icon(
                    Icons.thermostat,
                    color: Color.fromARGB(255, 87, 87, 87),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                          .copyWith(topRight: Radius.circular(0))),
                  padding: EdgeInsets.all(10),
                  elevation: 10,
                  color: Colors.grey.shade100,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        padding: EdgeInsets.only(right: 50, left: 20),
                        value: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.thermostat_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Temperature',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        padding: EdgeInsets.only(right: 50, left: 20),
                        value: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.straighten_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Length',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        padding: EdgeInsets.only(right: 50, left: 20),
                        value: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.science_outlined,
                                    size: 20, color: Colors.black),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Volume',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      currentMeasurement = "temperatures";
                      print(currentMeasurement);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                    } else if (value == 1) {
                      currentMeasurement = "volumes";
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                    } else if (value == 2) {
                      currentMeasurement = "lengths";
                      print(currentMeasurement);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                    }
                  })
            ]),
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
    List<DropdownMenuItem<String>> measurements = [];
    if (currentMeasurement == "lengths") {
      measurements = const [
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
        DropdownMenuItem(child: Text("Nautical Mile"), value: "0.000539957"),
        DropdownMenuItem(child: Text("Parsec"), value: "30856775812800000"),
        DropdownMenuItem(child: Text("Light Year"), value: "9460730472580000"),
        DropdownMenuItem(
          child: Text("Planck Length"),
          value: "161605000000000000000000000000000000",
        )
      ];
    } else if (currentMeasurement == "temperatures") {
      measurements = const [
        DropdownMenuItem(child: Text("Celcius"), value: "1"),
        DropdownMenuItem(child: Text("Fahrenheit"), value: "3"),
        DropdownMenuItem(child: Text("Kelvin"), value: "4"),
      ];
    } else if (currentMeasurement == "volumes") {
      measurements = const [
        DropdownMenuItem(child: Text("Liter"), value: "1"),
      ];
    }
    print("HERE");
    print(measurements);
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
                border: OutlineInputBorder(), labelText: 'Type a number...'),
            onChanged: (text) => convert1(text),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: DropdownButton<String>(
            value: conversionFactor1,
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
            value: conversionFactor2,
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
            items: measurements),
      )
    ]);
  }
}
