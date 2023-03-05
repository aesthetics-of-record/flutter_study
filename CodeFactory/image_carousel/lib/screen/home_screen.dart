import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0, // int형 자료가 올 수 있다. 테스트해보니 시작할 사진의 인덱스 같다.
  ); // PageController 입니다. PageViewController(x)

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        int currentPage = controller.page!.toInt(); // 이거 page자체는 왜 double? 인지는 이게 페이지가 반만 돌아갈수도 있기 때문이다.
        print(currentPage);
        int nextPage = currentPage + 1;

        if(nextPage > 4){
          nextPage = 0;
        }

        controller.animateToPage(nextPage, duration: Duration(milliseconds: 400), curve: Curves.linear,);

        // 근데 핫리로드를 하면 이게 실행 안된다. 왜냐하면, 핫리로딩은 스테이트를 다시 생성하지 않기 때문이다.
        // 그래서 이거를 반영하려면 아에 재시작을 해줘야한다.
      },
    );
  }

  @override
  void dispose() {
    controller.dispose(); // 모든 컨트롤러는 살아있으면 안 좋으니 꼭 dispose를 해줘야합니다. 그래야 메모리를 안전하게 사용할 수가 있다.
    if (timer != null) {
      timer!
          .cancel(); // 근데 이게 타이머가 널일수가 없는 상황인데 바보같이 널이 아님을 인식 못하죠? 그래서 ! 를 넣어줍시다.
    }

    super.dispose(); // 이건 마지막에 실행. 처음에 실행하면 아에 사라져버리기 때문이다.
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 이거를 통해 앱과 관련 없는 상태바 같은 것을 바꿀 수 있습니다.
    // 이 기능은 서비스 패키지를 불러와야합니다.

    return Scaffold(
      body: PageView( // 웹뷰는 컨트롤러를 받을 수 있었죠. 근데 pageview는 저희가 알아서 생성을 해야합니다.
        controller: controller,
        // pageview는 children을 파라미터로 받는다.
        children: [1, 2, 3, 4, 5] //
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(), // map은 항상 toList()로 리스트로 바꿔줘야한다.
      ),
    );
  }
}
