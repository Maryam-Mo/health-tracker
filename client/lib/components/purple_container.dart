import 'package:flutter/material.dart';

class PurpleContainerWithShadows extends StatelessWidget {
  PurpleContainerWithShadows(
      {this.width, this.height, this.begin, this.end, this.column});

  final double width;
  final double height;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Column column;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6757AA),
            const Color(0xFF39297E),
          ],
          begin: begin,
          end: end,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFB9B8CC),
            offset: const Offset(-20.0, 30.0),
            blurRadius: 15.0,
            spreadRadius: 10.0,
          ),
        ],
      ),
      child: column,
    );
  }
}
