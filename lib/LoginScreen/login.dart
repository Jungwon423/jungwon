import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height; // 기기 높이
    double phoneWidth = MediaQuery.of(context).size.width; // 기기 너비

    EdgeInsets _buttonPadding = EdgeInsets.symmetric(
      horizontal: phoneWidth * 0.05,
      vertical: phoneHeight * 0.015,
    );
    double boxheight = 60;
    double boxwidth = 80;

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: phoneHeight * 0.15,
        ),
        Image.asset(
          "assets/images/아이콘 최종 핑크2_배경없음.png",
          width: phoneWidth * 0.7,
        ),
        SizedBox(
          height: phoneHeight * 0.15,
        ),
        // Padding(
        //   padding: _buttonPadding,
        //   child: SizedBox(
        //     height: boxheight,
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.white,
        //         padding: const EdgeInsets.all(10),
        //       ),
        //       onPressed: () async {
        //         // TODO
        //       },
        //       child:
        //           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //         ClipRRect(
        //           child: Image.asset(
        //             "assets/images/구글 로고.png",
        //             width: 30,
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 70,
        //         ),
        //         Text(
        //           "구글 계정으로 로그인",
        //           style: textTheme().titleMedium,
        //           textAlign: TextAlign.center,
        //         ),
        //         const SizedBox(
        //           width: 60,
        //         ),
        //       ]),
        //     ),
        //   ),
        // ),
        Padding(
          padding: _buttonPadding,
          child: SizedBox(
            height: boxheight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFEB3B),
                padding: const EdgeInsets.all(10),
              ),
              onPressed: () async {
                // 카카오 로그인 구현 예제

                // 카카오톡 실행 가능 여부 확인
                // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');

                    // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                    // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                    if (error is PlatformException &&
                        error.code == 'CANCELED') {
                      return;
                    }
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                } else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                  }
                }
                // TODO
              }, // 누르면 원하는 home 으로 이동
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: boxwidth,
                ),
                ClipRRect(
                  child: SvgPicture.asset(
                    'assets/images/카카오톡 로고.svg',
                    width: 30, // phoneWidth로 할 경우 너무 기종에 따라 디자인이 너무 달라짐
                  ), // 로고
                ),
                const SizedBox(
                  width: 10, // phoneWidth로 할 경우 너무 기종에 따라 디자인이 너무 달라짐
                ), // 로고랑 문자 사이 빈 공간
                Text(
                  '카카오톡으로 시작하기',
                  style: textTheme().subtitle1,
                  textAlign: TextAlign.center,
                ), // 텍스트
              ]),
            ),
          ),
        ),
        // 카톡 로그인 버튼
        // Padding(
        //   padding: _buttonPadding,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF00C73D),
        //       padding: const EdgeInsets.all(10),
        //     ),
        //     onPressed: () {
        //       // TODO
        //     }, // 누르면 원하는 home 으로 이동
        //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        //       SizedBox(
        //         width: boxwidth,
        //       ),
        //       ClipRRect(
        //         child: SvgPicture.asset(
        //           'assets/images/네이버 로고.svg',
        //           width: 30, // phoneWidth로 할 경우 너무 기종에 따라 디자인이 너무 달라짐
        //         ), // 로고
        //       ),
        //       const SizedBox(
        //         width: 10, // phoneWidth로 할 경우 너무 기종에 따라 디자인이 너무 달라짐
        //       ), // 로고랑 문자 사이 빈 공간
        //       Text(
        //         '네이버로 시작하기',
        //         style: textTheme().subtitle1?.copyWith(color: Colors.white),
        //         textAlign: TextAlign.center,
        //       ), // 텍스트
        //     ]),
        //   ),
        // ) // 네이버 로그인 버튼
      ]),
    );
  }
}
