import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Chip(label: Text('Flutter'), avatar: Icon(Icons.tag)),
            ExpansionTile(
              title: Text('Tap to Expand'),
              children: [
                ListTile(title: Text('Option 1')),
                ListTile(title: Text('Option 2')),
              ],
            ),
            Tooltip(message: 'This is a tooltip', child: Icon(Icons.info)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Centered Text'),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text('This is a card'),
              ),
            ),
            DropdownButton(
              value: 'Option 1',
              items: [
                DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
              ],
              onChanged: (String? newValue) {},
            ),
            Radio(value: 1, groupValue: 1, onChanged: (int? newValue) {}),
            Slider(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (double newValue) {},
            ),
            Switch(value: true, onChanged: (bool newValue) {}),
            LinearProgressIndicator(),
            
          ],
        ),
      ),
    );
  }
}
