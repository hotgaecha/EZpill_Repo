import 'package:ezpill/Screens/main_screen.dart';
import 'package:ezpill/auth/kakao_login.dart';
import 'package:ezpill/auth/main_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart'; //  실제 로그인 후 화면 전환
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedin = false;
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'EZPill과 함께\n하루하루 건강해져볼까요?',
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            Center(
              // 실제 로그인 없이 화면 전환만 구현
              // child: isLoggedin ? _buildUserButtons() : _buildLoginButton(),

              //  실제 로그인 후 화면 전환
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _buildLoginButton();
                  }
                  return _buildUserButtons();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      //  실제 로그인 없이 화면 전환만 구현 (onTap)
      // onTap: () {
      //   setState(() {
      //     isLoggedin = true;
      //   });
      //   print("isLoggedin true");
      // },

      //  실제 로그인 후 화면 전환 (onTap)
      onTap: () async {
        await viewModel.login();
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xffffeb3b),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 5,
              offset: Offset(0, 4),
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/free-icon-kakao-talk-3669973.png",
              width: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "카카오톡으로 로그인하기",
              style: TextStyle(
                  fontFamily: "NanumGothic",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (viewModel.user?.kakaoAccount?.profile?.profileImageUrl != null)
          Container(
            //  ProfileImage
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    viewModel.user!.kakaoAccount!.profile!.profileImageUrl!),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        // Container(
        //   height: 250,
        //   color: Colors.red,
        //   width: 250,
        // ),
        const SizedBox(
          height: 60,
        ),
        GestureDetector(
          //  Logout Button
          onTap: () async {
            await viewModel.logout();
            setState(() {
              isLoggedin = false;
            });
            print("isLoggedin false");
          },
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffffeb3b),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 5,
                  offset: Offset(0, 4),
                  spreadRadius: 3,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/free-icon-kakao-talk-3669973.png",
                  width: 60,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${viewModel.user?.kakaoAccount?.profile?.nickname}에서 로그아웃하기",
                  style: const TextStyle(
                      fontFamily: "NanumGothic",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          //  Start with 'logined user'
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  kakaoUid: viewModel.user?.id.toString() ?? '',
                  firebaseUid: viewModel.firebaseUid,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xfff9b53a),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 5,
                  offset: Offset(0, 4),
                  spreadRadius: 3,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              "${viewModel.user?.kakaoAccount?.profile?.nickname}님 환영해요!",
              style: const TextStyle(
                  fontFamily: "Gmarket Sans TTF",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
