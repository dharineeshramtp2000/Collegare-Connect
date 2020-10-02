import 'package:flutter/material.dart';

class DoctorTitle extends StatelessWidget {
  DoctorTitle({this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w100,
            fontFamily: 'KumbhSans',
          ),
        ),
        Text(
          'See All',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontFamily: 'Ubuntu',
          ),
        )
      ],
    );
  }
}