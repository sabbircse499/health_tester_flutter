import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
home: splash(),
    );
  }
}
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
 Timer(Duration(seconds: 4), () {
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(),));
 });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo2.png",height: 300,width: 300,),

          SizedBox(
            height: 10,
          ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/5,
            ),
            Center(child: Text('Health Tester',style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.bold
            ),
            )
            ),
            SizedBox(
              height: 10,
            ),

            Center(child: Text('Your Ultimate Health Companion',style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.bold
            ),
            )
            ),


          ],
        ),
      )

    );
  }
}

//home screen or bmi calculator

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pages = [calculate(), health(), account()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculate(),
    );
  }
}


//calculator
/*
class calculate extends StatefulWidget {
  const calculate({super.key});

  @override
  State<calculate> createState() => _calculateState();
}

class _calculateState extends State<calculate> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bmi Calculate'),
      ),
    );
  }
}

*/
class calculate extends StatefulWidget {
  const calculate({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<calculate>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,

      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Some Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: feetController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Feet',
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                HapticFeedback.vibrate();
                                return 'Fill up this field';
                              }
                              return null;
                            },
                            cursorColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: inchController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Inches',
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                HapticFeedback.vibrate();
                                return 'Fill up this field';
                              }
                              return null;
                            },
                            cursorColor: Colors.white,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter weight (kg)',
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                HapticFeedback.vibrate();
                                return 'Fill up this field';
                              }
                              return null;
                            },
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              calculateBMI();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(bmiResult),
                                ),
                              );
                            }
                          },
                          child: Text('Calculate BMI'),
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
    );
  }

  void calculateBMI() {
    double feet = double.parse(feetController.text);
    double inches = double.parse(inchController.text);
    double weight = double.parse(weightController.text);

    double heightInCm = (feet * 12 + inches) * 2.54; // Convert feet and inches to cm

    setState(() {
      bmiResult = weight / ((heightInCm / 100) * (heightInCm / 100));
    });
  }
}

//result screen

class ResultPage extends StatelessWidget {
  final double bmiResult;
  late  String outputs="";
  ResultPage(this.bmiResult);

  void result(){
    if(bmiResult<18.5){
outputs="Your BMI suggests you're underweight, which can cause fatigue, weakened immunity, even bone issues. Seek medical advice for a personalized plan. Prioritize a balanced diet with fruits, veggies, whole grains, and lean protein. Increase calorie intake gradually and explore strength training to build muscle. Remember, prioritizing sleep and managing stress also play a role in healthy weight gain. Good luck!";
    }
else if(bmiResult>=18.5 && bmiResult<=24.9){
outputs="Congrats! Your BMI indicates you're in the healthy weight range, meaning your body composition reflects a lower risk of weight-related health issues. Keep up the good work by maintaining a balanced diet rich in fruits, veggies, and whole grains. Prioritize physical activity you enjoy, and remember to listen to your body's needs for rest and stress management. Celebrate this achievement and continue nourishing your healthy lifestyle!";
    }
else if(bmiResult>=25 && bmiResult<=29.9){
  outputs="Your BMI between 25 and 29.9 falls into the overweight range, where carrying extra weight might elevate your risk of certain health conditions. Don't panic! This is an opportunity to focus on small, sustainable changes. Talk to your doctor or a registered dietitian for personalized guidance. Prioritize whole foods like fruits, vegetables, and whole grains over processed options. Incorporate more physical activity you enjoy, even starting with brisk walks. Remember, small, consistent steps towards a healthier lifestyle can make a big difference!";
    }
else if(bmiResult>=30 && bmiResult<=24.9){
outputs="BMI above 30 suggests a higher health risk zone. A personalized plan with a doctor or registered dietitian can help you make sustainable changes towards a healthier you.";
}
  }



  @override
  Widget build(BuildContext context) {
    result();
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result',),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body:

      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              SizedBox(height: MediaQuery.of(context).size.height/25),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width /1.2,
                  child: Text(
                    'BMI Result: ${bmiResult.toStringAsFixed(3)}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color:Colors.cyanAccent,
                   borderRadius: BorderRadius.circular(20)
          
                  ),
          
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Suggestion :\n\n $outputs',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color:Colors.cyanAccent,
                        borderRadius: BorderRadius.circular(20)

                    ),

                  ),
            ),
              ]
          ),
        ),
      ),





    );
  }
}



//health class
class health extends StatefulWidget {
  const health({super.key});

  @override
  State<health> createState() => _healthState();
}

class _healthState extends State<health> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health'),
      ),
    );
  }
}



//acoount
class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('account'),
),
    );
  }
}
