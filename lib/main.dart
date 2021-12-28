import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

//const Color(0xFF121212),
int valorTempo = 0;
int valorVontade = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool decisao = false;
  bool visible = false;

  void pacocaDecide() {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    randomNumber += (valorVontade - 5) * 5;
    randomNumber += valorTempo * 5;
    setState(() {
      if (randomNumber > 60) {
        decisao = true;
      } else {
        decisao = false;
      }
    });
  }

  void setVisible() {
    setState(() {
      visible = !visible;
    });
  }

  String definition() {
    if (visible) {
      if (decisao) {
        return "Manda bala!";
      } else {
        return "Não!";
      }
    } else {
      return "";
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xFFBA9A6A),
      shape: const CircleBorder(),
      fixedSize: const Size(200, 200));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF484848),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Devo comer uma paçoquinha?",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: style,
            onPressed: () {
              pacocaDecide();
              setVisible();
            },
            child: const Image(
              image: AssetImage("assets/images/botao.png"),
              width: 400,
              height: 400,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            definition(),
            style: const TextStyle(color: Colors.white, fontSize: 26),
          ),
          SizedBox(height: visible ? 50 : 0),
          const Text(
            "Vontade de comer",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SliderVontade(),
          const SizedBox(height: 50),
          const Text(
            "Tempo desde a ultima paçoquinha",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SliderTempo(),
        ],
      ),
    );
  }
}

class SliderTempo extends StatefulWidget {
  const SliderTempo({Key? key}) : super(key: key);

  @override
  State<SliderTempo> createState() => _SliderTempoState();
}

class _SliderTempoState extends State<SliderTempo> {
  double _currentSliderValue = 0;
  List<String> valueList = ["< 0:30", "0:30", "1:00", "1:30", "2:00", "> 2:00"];
  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: const Color(0xFFBA9A6A),
      inactiveColor: const Color(0xFF705937),
      value: _currentSliderValue,
      max: 5,
      divisions: 5,
      label: valueList[_currentSliderValue.round()],
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
          valorTempo = value.round();
        });
      },
    );
  }
}

class SliderVontade extends StatefulWidget {
  const SliderVontade({Key? key}) : super(key: key);

  @override
  State<SliderVontade> createState() => _SliderVontadeState();
}

class _SliderVontadeState extends State<SliderVontade> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: const Color(0xFFBA9A6A),
      inactiveColor: const Color(0xFF705937),
      value: _currentSliderValue,
      max: 10,
      divisions: 10,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
          valorVontade = value.round();
        });
      },
    );
  }
}

class BotaoWidget extends StatefulWidget {
  const BotaoWidget({Key? key}) : super(key: key);

  @override
  State<BotaoWidget> createState() => _MyBotaoWidgetState();
}

class _MyBotaoWidgetState extends State<BotaoWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: const Color(0xFFBA9A6A),
        shape: const CircleBorder(),
        fixedSize: const Size(200, 200));

    return Center(
        child: ElevatedButton(
      style: style,
      onPressed: () {},
      child: const Image(
        image: AssetImage("assets/images/botao.png"),
        width: 400,
        height: 400,
      ),
    ));
  }
}
