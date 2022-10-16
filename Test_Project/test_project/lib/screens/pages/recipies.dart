import 'package:flutter/material.dart';

class Recipies1 extends StatefulWidget {
  @override
  _Recipies1State createState() => _Recipies1State();
}

class _Recipies1State extends State<Recipies1> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('Increment'),
        )
      ],
    );
  }
}