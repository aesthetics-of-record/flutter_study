import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                // Material State
                // 이 MaterialState의 8개 속성은 버튼뿐만아니라,
                // 어디에서나 다 쓰이는 공통적인거다. 중요하다.
                //
                // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 됐을 때 (텍스트 필드)
                // pressed - 눌렸을 때
                // dragged - 드래그 됐을 때
                // selected - 선택됐을 때 (체크박스, 라디오 버튼)
                // scrollUnder - 다른 컴포넌트  밑으로 스크롤링 됐을 때
                // disabled - 비활성화 됐을 때 (onPressed 에 null을 넣을 때)
                // error - 에러상태
                // 버튼에서는 pressed 랑 disabled상태 정도만 쓰인다고 보면된다.


                // MaterialStateProperty.resolveWith 를 쓰면 상태에따른 스타일을 따로 줄 수 있다.
                // MaterialStateProperty.all 은 styleFrom이랑 똑같다고 보면 된다.
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.black;
                      }), foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.red;
                  }), padding: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return EdgeInsets.all(50.0);
                }
                return EdgeInsets.all(20.0);
              })),
              child: Text(
                'ButtonStyle',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // 배경색깔
                backgroundColor: Colors.red,
                // 글자 및 애니메이션 색깔
                foregroundColor: Colors.black,
                // 그림자 색깔
                shadowColor: Colors.green,
                // 3D 입체감의 높이
                elevation: 10.0,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
                // 이거 말고도 여러가지가 있다.
                // 하지만, 일단 이정도만 알아도 큰 문제는 없다.
                // 다른 것들은 직접 타입보면서 찾아보자.
              ),
              child: Text('ElevatedButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // 지금은 사라진 파라미터지만,
                // 위의 버튼이랑 primary만 차이있는 버튼일 뿐이었다.
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 10.0,
              ),
              child: Text('OutlinedButton'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black12,
              ),
              child: Text('TextButton'),
            ),
          ],
        ),
      ),
    );
  }
}
