import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_%20two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 시스템 적인 뒤로가기는 막을 수 있다!
      // (실험결과 (false로 리턴의 경우) : maybePop 과 <-뒤로가기는 막을 수 있다.)
      // 일반 pop은 못 막는다
      // print(Navigator.of(context).canPop()); 근데, 이 값은 true가 나오긴한다.
      onWillPop: () async {
        return false;
      },
      child: MainLayout(
        title: 'Route One',
        children: [
          Text(
            'arguments : ${number.toString()}',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('Pop'),
          ),
          ElevatedButton(
              onPressed: () {
                // [HomeScreen(), RouteOneScreen(), RouteTwoScreen() ...]
                // 이런 느낌의 후입선출 구조를 스택이라고한다.
                // 실제로 라우팅은 스택구조로 되어있다.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RouteTwoScreen(),
                    settings: RouteSettings(arguments: 789),
                  ),
                );
              },
              child: Text('Push'))
        ],
      ),
    );
  }
}
