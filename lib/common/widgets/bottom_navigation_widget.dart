import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String text;
  final bool enabled;
  const BtnItem({
    super.key,
    required this.onTap,
    required this.text,
    required this.enabled,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: enabled ? Colors.blue : null,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(color: enabled ? Colors.blue : null),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
    required this.size,
    required this.btnItems
  });

  final Size size;
  final List<BtnItem> btnItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      // color: Colors.yellow,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            // blurRadius: 5,
            spreadRadius: 0.5,
            color: Colors.black.withAlpha(100))
      ]),
      height: size.height * 0.09,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: btnItems
        ),
      ),
    );
  }
}
