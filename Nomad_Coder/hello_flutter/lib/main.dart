import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

// 모든 위젯은 build메소드를 구현해줘야한다.
// build는 당신의 ui를 리턴해주는 메소드다.
// StatelessWidget를 사용하려면 정해놓은 규칙을 적용해야한다.

// StatelessWidget 은 가장 기초적인 위젯이고, 화면에 뭔가를 띄워주는 일 말고는 안한다.

// StatelessWidget 은 build메소드를 구현해야한다는 계약이 있다. 그리고 그 메소드는 리턴을 해줘야한다.
class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // 리턴할 것에는 머티리얼과 쿠퍼티노 앱이 있다. 각각 구글과 애플의 디자인 시스템이다.
    // 어쨌든 우리가 둘의 디자인을 안 따른다고 하더라도 기본적으로 둘중 하나는 선택해야한다.
    // 근데 보통은 기본적으로는 머터리얼 앱을 선택한다. 보통 공식적으로도 그것을 추천하고있다.

    // 모바일 앱의 화면은 Scaffold가 필수적으로 필요하다.

    // ','를 적어주면 주석으로 저렇게 위젯을 표현해주면서 IDE가 도움을 준다.

    // 플러터는 이 모든것들이 다 위젯이다!
    // 이 모든게 그저 class를 사용하고 있다는 것을 이해해야한다.(named prameter)

    // 위젯들에 마우스를 올려보면, 이 위젯이 또 어떤 위젯들을 가지고 있는지 constructor을 볼 수 있다.
    // ** 여기 나오는 것들을 직접 읽고 쓸 줄 알아야한다.
    // ?가 붙어있는 타입은 꼭 타입값을 지정하지 않아도 오류가 나지 않는다. 비어도 되는 값들이다.
    // 이런것들을 하나하나 보면서 다 시험해보셨으면 좋겠다.

    // dart 프로그래밍은 new를 써서 인스턴스화를 안 시켜도 다 인스턴스화가 된다.
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          backgroundColor: Colors.red,
          // 예를 들면 여기 Text의 문자열은 포지셔널 파라미터다.
          // 그리고 Text의 data는 꼭 들어가야하는 포지셔널파라미터다.
          // 그리고 title: 은 네임드파라미터다.
          title: Text('Hello flutter!'),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}