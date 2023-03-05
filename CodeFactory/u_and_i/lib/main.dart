import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        // 이렇게 스타일들은 main.dart로 옮겨서 효율성있게 개발 할 수 있다.
        //기본폰트를 설정할 수 있다.
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          // 이름은 뭘로 해도 상관없다.
          headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80.0
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w700),
        ),
      ),
      home: HomeScreen(),
    ),
  );
}
