import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // tip : ios에서는 뒤로 갈 때가 아무것도 없을 때 더 이상 뒤로가지 못하는데,
      // 안드로이드에서는 그래도 뒤로 가서 아에 앱밖으로 나갈 수가 있다.
      // 그래서 이 위젯을 이용하자.
      // 이 밑의 함수는 특이하게 async를 무조건 달아줘야 됩니다.
      onWillPop: () async {
        // 리턴값이?
        // true - pop 가능
        // false - pop 불가능 (일부로 자체적으로 pop버튼을 만든 경우는 그래도 뒤로가진다.)
        // 다만 시스템적으로 안드로이드 버튼으로 뒤로 가는 것은 막을 수 있다.

        // 이렇게 밑에처럼 활용하면 된다.
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              // canPop는 pop을 하는 기능이아니라,
              // pop가 가능한지 여부를 알려주는 함수다.
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              // maybePop()는 뒤에 아무 것도 없을 때,
              // 뒤로가서 꺼지는 것을 방지해준다.
              // maybePop()는 canPop()가 true 일 때만 뒤로가기를 한다.
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      RouteOneScreen(
                        number: 123,
                      ),
                ),
              );
              print(result);
            },
            child: Text('Push'),
          ),
        ],
      ),
    );
  }
}
