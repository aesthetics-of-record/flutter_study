import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'argument: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            // 근데 이렇게 하면 MaterialPageRoute를 통하지 않기 때문에,
            // settings 값이 존재하지 않습니다.
            // 그럼 어떻게 route3로 값을 전달해주나?
            // 그건 이 pushNamed에는 바로 arguments파라미터가 존재합니다.
            // 이렇게 NamedRouter를 쓸 때는 arguments가 편합니다.
            // 나중에 url에 값을 심어놓는 방법도 알려드릴 거지만 일단은 현재로써는 이게 최선입니다.
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            // [HomeScreen(), RouteOne(), RouteTwo(), RouteThree()] 기존방식
            // [HomeScreen(), RouteOne(), RouteThree()] 이렇게 two를 three로 대체하는거다
            Navigator.of(context).pushReplacementNamed(
              '/three',
            );
          },
          child: Text('Push Replacement'),
        ),
        ElevatedButton(
            onPressed: () {
              // 이것도 마찬가지로 Named로 바꿀 수 있다.
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RouteThreeScreen(),
                ),
                // 여기서 보이는, route.settings.name 은 실제로 우리가 앞에서
                // main.dart에서 설정한 route의 name이다.
                // 밑에서 라우트를 다 불러와서 조건에 맞는 것만 true를 반환하여 살린다.
                (route) => route.settings.name == '/',
              );
            },
            child: Text('Push And Remove Until'))
      ],
    );
  }
}
