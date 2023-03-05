import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, Key? key})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false;

  // initState는 절대로 async를 할 수 없다.
  // 그럼 어떻게 async를 하느냐? 함수를 하나 더 만들면 된다.
  @override
  void initState() {
    super.initState();

    // 어쨌든 이 함수 자체는 await가 아니기 때문에
    // 먼저 렌더링이 될 수가 있다.
    initializeController();
  }

  // didUpdateWidget는 이stateful위젯이 실행된 이력이 있는데,
  // 그 때 파라미터만 변경이 됐을 때 실행 할 수 있다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // oldWidget는 새로운 위젯이 생성되기 전의 위젯입니다!
    // widget는 당연히 현재 위젯이고요.
    if (oldWidget.video.path != widget.video.path) {
      // 그 전 영상을 멈추기위해 사용
      videoController!.pause();
      initializeController();
    }
  }

  initializeController() async {
    // 이게 didUpdateWidget에서 이게 싱크가 안 맞는 경우가 생겨서 에러가난다.
    // 그래서 시작할 때 이걸 0으로만들어주자
    currentPosition = Duration();

    videoController = VideoPlayerController.file(
      // 여기 들어올 수 있는 파라미터의 타입은 다트에서 제공하는 File타입이어야한다.
      // XFile(이미지피커타입)을 File타입으로 바꿔줘야한다.
      // File를 보면 두가지 타입이 있는데, dart.io에서 불러오는 타입을 사용하셔야합니다!
      File(widget.video.path),
    );

    // 왜 느낌표냐면, 위에서 넣었으니까 null일 수가 없다.
    videoController!.initialize();

    // 이렇게 리스너를 만들수도 있다.
    // 이 함수는 이 비디오컨트롤러가 변경이 될 때마다 실행이 된다.
    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    // 이렇게 비디오 컨트롤러를 생성해줬으니, 그에 맞게 새로 빌드를 하기 위해
    // 빈 setState를 한 번 실행해준다.
    // 여기서 setState로 재렌더링을 해주지 않아도 멀쩡히 작동한다. 이유가 뭘까??
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            if (showControls)
              _Controls(
                onReversePressed: onReversePressed,
                onPlayPressed: onPlayPressed,
                onForwardPressed: onForwardPressed,
                isPlaying: videoController!.value.isPlaying,
              ),
            if (showControls)
              _NewVideo(
                // 이 함수를 홈스크린 밖으로 빼줘야 새로운비디오를 불러올 수 있다.
                onPressed: widget.onNewVideoPressed,
              ),
            _SliderBottom(
              currentPosition: currentPosition,
              maxPosition: videoController!.value.duration,
              onSliderChanged: onSliderChanged,
            )
          ],
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    // 사실 여기서 currentPosition을 setState로 바꾸는 것은 아무런 의미도 없어요.
    // 슬라이더만 바뀌고 비디오 위치는 안 바뀝니다.
    //
    // 우리가 슬라이더를 직접 움직일 때마다 onChanged를 실행해줘서,
    // 비디오컨트롤러로 어느 위치로 다시 실행을 하라는 것을 알려줘야 하기 때문이죠.
    // 그래서 처음의 방법으로는 비디오컨트롤러에 실행할 위치를 알려주지는 않는다.
    //
    // 만약에 되게 하려면, seekTo로 비디오의 현재위치를 갱신하고,
    // setState를 해주면 된다. 근데 이미 위의 리스너에서 setState를 자동으로
    // 하겠끔 했기 때문에 또 setState를 할 필요는 없다.

    videoController!.seekTo(
      Duration(
        seconds: val.toInt(),
      ),
    );
  }

  void onReversePressed() {
    // 현재길이 가져오기
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); // 기본 Duration은 0초다.

    // 3초 넘을 때만 빼준다.
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    // 전체길이 가져오기
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition;

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    // 재랜더링 해줘야한다.
    setState(() {
      // 이미 실행중이면 중지
      // 실행중이 아니면 실행
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        // 아이콘 버튼까지 stretch가 되어서 버그가 일어난다. 그래서 대신 박스에 높이를 최대로 주자.
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30.0,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _SliderBottom(
      {required this.currentPosition,
      required this.maxPosition,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      // 이렇게 하면 쭉 늘어나서 왼쪽끝 오른쪽끝에 붙게 할 수 있다.
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              // 이렇게 초에 60으로 나눈 나머지 넣지 않으면, 61초가 넘어가도 61 그대로 표현할거다.
              // 만약 시간도 필요하면, 분단위도 똑같이 %60 해줘야한다.
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
