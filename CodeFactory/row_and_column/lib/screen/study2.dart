import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // bottom: false,
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Column(
            // Expanded / Flexible
            // 이 두 위젯은 '무조건' row,column위젯의 children에서만 사용 할 수 있다.
            // 이걸 모르고 다른 곳에서 써서 에러를 만드는 경우가 많다.
            children: [
              // Flexible는 일단은 이 비율만큼 공간을 차지하되,
              // 만약 child안의 위젯이 그 공간을 다 차지하지 않으면,
              // 남는 공간을 버려버립니다.

              // 근데 실제로 Flexible는 크게 사용하지 않는다.
              // 주로는 Expanded를 사용하는 편이다.

              Flexible(
                child: Container(
                  color: Colors.red,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Flexible(
                // flex값은 나머지 공간을 나눠먹는 비율이다.
                // flex: 3,
                child: Container(
                  color: Colors.orange,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
