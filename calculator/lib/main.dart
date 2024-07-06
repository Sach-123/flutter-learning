import 'package:flutter/material.dart';
import './constants/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayText = "0";
  Parser p = Parser();

  void buttonPressed(String text) {
    try{
      if(text=="="){
        Expression exp = p.parse(_displayText);
        double result = exp.evaluate(EvaluationType.REAL, ContextModel());
        print(result);
        _displayText = result.toString();
      }else if(text=="C"){
        _displayText = "0";
      }else {
        if(_displayText=="0"){
          _displayText = text;
        }else{
          _displayText += text;
        }
      }
    }catch(e){
      _displayText = "Invalid Expression";
    }
    setState(() {
      _displayText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBG,
        appBar: AppBar(
          backgroundColor: appBG,
          title: const Text(
            "Calculator",
            style: TextStyle(color: Colors.white, fontSize: 36, fontFamily: "work_sans"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  _displayText,
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.white, fontSize: 72, fontFamily: "work_sans", fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      buttonPressed(btnText[index]);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: index % 4 == 3
                            ? btnOperations
                            : btnText[index] == 'C'
                                ? Colors.red
                                : btnText[index] == '='
                                    ? Colors.green
                                    : btnDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    child: Text(btnText[index],
                        style: const TextStyle(fontSize: 40, color: Colors.white, fontFamily: "work_sans")),
                  );
                },
                itemCount: btnText.length,
              ),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

const List<String> btnText = [
  '7',
  '8',
  '9',
  '/',
  '4',
  '5',
  '6',
  '*',
  '1',
  '2',
  '3',
  '-',
  'C',
  '0',
  '=',
  '+',
];
