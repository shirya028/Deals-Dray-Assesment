import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final double width;  // Fixed width
  final double height; // Fixed height

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.width = 150,  // Default width
    this.height = 50,  // Default height
  });

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  @override
  void initState() {
    super.initState();
    initialPosition = widget.values[0] == 'Phone';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                initialPosition = !initialPosition;
              });
              var index = initialPosition ? 0 : 1;
              widget.onToggleCallback(index);
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.height * 0.5), // rounded corners based on height
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),  // Fixed padding for alignment
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 10.0,  // Font size set to 10
                        fontWeight: FontWeight.bold,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: widget.width * 0.5,  // Adjust the button's width to 50% of the total width
              height: widget.height,  // Use the same height as the container
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.height * 0.5),  // rounded corners based on height
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 10.0,  // Font size set to 10
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
