
//inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))],
//keyboardType: TextInputType.numberWithOptions(
    //decimal: true,
    //signed: trueimport 'package:flutter/services.dart';





import 'package:flutter/material.dart';


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
        appBar: AppBar(title: Text('Hello World!')), body: TextInputWIdget());
  }
}

class TextInputWIdget extends StatefulWidget {
  TextInputWIdget({super.key});

  @override
  State<TextInputWIdget> createState() => _TextInputWIdgetState();
}

class _TextInputWIdgetState extends State<TextInputWIdget> {
  final controller = TextEditingController();
  String text = "";
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  void changeText(text) {
    setState(() {
      this.text = text;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.numbers), labelText: 'type a number already'),
        onChanged: (text) => this.changeText(text),
      ),
      Text(this.text)
    ]); 
  }
}

