import 'package:flutter/material.dart';
class SeeAllComponent extends StatelessWidget {
  final String text;
  final String textButton ;
  final void Function()? onTap ;
  const SeeAllComponent({super.key , required this.text, this.onTap , required this.textButton});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( text , style: TextStyle(fontSize: 20 , color: Colors.black) ,  ),

          TextButton(onPressed: onTap, child: Text( textButton , style: TextStyle(fontSize: 15 , color: Color(0xFFFF4548)) , )),
        ],
      ),
    );
  }
}
