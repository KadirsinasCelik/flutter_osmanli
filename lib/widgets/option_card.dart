import 'package:flutter/material.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.option, required this.color, });
final String option;
final Color color;


  @override
  Widget build(BuildContext context) {
    return Card(
     color: color,
     
     
    child: ListTile(
    title: Text(
    option,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 22.0,
       color: color.red != color.green ? neutral : Colors.black 
    ),
    ),
    ),
    
    
    );
  }
}