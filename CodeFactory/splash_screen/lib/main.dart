import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // 이렇게 위에 디버그배너를 제거할 수 있다.
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

// 모든 위젯들은 실제로 class입니다.
// StatelessWidget 를 상속하면, 클래스를 위젯으로 변경가능
class HomeScreen extends StatelessWidget {
  // Widget를 리턴받는 함수 (build앞의 Widget는 리턴'타입'이다)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 16진수로 시작할 때는 0x로 시작, 그 다음 FF는 투명도다.
      backgroundColor: Color(0xFFF99231),
      body: Column(
        // 대부분의 위젯 자식은 home/body를 제외하고는,
        // child 아니면 ciildren이다.

        // 이렇게 파라미터 이름과 넣아야 되는 값이 똑같은 경우가 많아요.
        // 구글에서 굳이 찾아보지 않고 만들기 쉽게 이렇게 한겁니다.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/img/logo.png',
          ),
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
