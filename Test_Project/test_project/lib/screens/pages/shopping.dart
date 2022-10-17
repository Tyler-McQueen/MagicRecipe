import 'package:flutter/material.dart';

class Shopping3 extends StatefulWidget {
  @override
  _Shopping3State createState() => _Shopping3State();
}

class _Shopping3State extends State<Shopping3> {
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
              count--;
            });
          },
          child: Text('Decrement'),
        )
      ],
    );
  }
}

