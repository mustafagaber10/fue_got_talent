import 'package:flutter/material.dart';

customErrorScreen(){

  return ErrorWidget.builder = ((details) {
    return Material(
      child: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Not_found.png'),
            const SizedBox(height: 20,),
            Text(
              details.exception.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  });

}