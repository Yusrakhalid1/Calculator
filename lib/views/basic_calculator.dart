import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class basic_calculator extends StatefulWidget {
  const basic_calculator({super.key});

  @override
  State<basic_calculator> createState() => basic_calculatorState();
}

class basic_calculatorState extends State<basic_calculator> {

  String userinput = "";
  String Result = "0";

  List <String> buttonlist = [
    'AC',
    ')',
    '(',
    '/',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userinput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white
                    ),
                  ),
                ),
                 Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    Result,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonlist.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12
                  ) ,
                 itemBuilder: (BuildContext context , int index){
                  return CustomButton(buttonlist[index]);
                 }
                 ),
            )
          )
        ],
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: (){
        setState(() {
        handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgcolor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(-3 , -3),
              spreadRadius: 0.5
            )
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text){
    if(
      text == "/" ||
      text == "+" ||
      text == "C" ||
      text == "_" ||
      text == "×" ||
      text == ")" ||
      text == "("
          ){
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }
    getBgcolor(String text){
    if(text == "AC" ){
      return const Color.fromARGB(255, 252, 100, 100);
    }
     if(text == "=" ){
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return const Color(0xFF1d2630);
  }
 handleButtons(String text){
  if(text == "AC"){
    userinput = "";
    Result = "0";
  }
  if(text == "C"){
    if(userinput.isNotEmpty){
      userinput = userinput.substring(0 , userinput.length -1);
      return;
    }
    else{
      return null;
    }
  }
  if(text == "="){
   Result = calculate();
   userinput = Result;
      if(userinput.endsWith(".0")){
    userinput = userinput.replaceAll(".0", "");
      }
   if(Result.endsWith(".0")){
    Result = Result.replaceAll(".0", "");
    return;
   }
  } 
   userinput = userinput + text;
 }
 String calculate(){
  try{
   var exp = Parser().parse(userinput);
   var evalution = exp.evaluate(EvaluationType.REAL, ContextModel());
   return evalution.toString();

  }catch(e){
    return "Error";
  }
 }
}