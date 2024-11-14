import 'package:flutter/material.dart';

class ButtonGroup extends StatefulWidget {
  const ButtonGroup({super.key});

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  int _activeIndex = 0; // Track the active button index

  void _onButtonTapped(int index) {
    setState(() {
      _activeIndex = index; // Update the active index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Button Group')),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () => _onButtonTapped(index),
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300), // Animation duration
                  decoration: BoxDecoration(
                    color: _activeIndex == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Button ${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
