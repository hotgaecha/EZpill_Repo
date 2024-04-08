import 'package:ezpill/auth/firebase_auth_remote_data_source.dart';
import 'package:ezpill/auth/social_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainViewModel {
  final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
  final SocialLogin _socialLogin;
  bool isLogined = false;
  kakao.User? user;

  MainViewModel(this._socialLogin);

  // 현재 로그인한 Firebase 사용자의 UID를 반환하는 getter
  String get firebaseUid {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await kakao.UserApi.instance.me();

      final token = await _firebaseAuthDataSource.createCustomToken({
        'uid': user!.id.toString(),
        'displayName': user!.kakaoAccount!.profile!.nickname,
        'email': user!.kakaoAccount!.email!,
        'photoURL': user!.kakaoAccount!.profile!.profileImageUrl!,
      });

      await FirebaseAuth.instance.signInWithCustomToken(token);

      // Django 백엔드로 사용자 정보를 전송
      await sendUserDataToDjango();
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    await FirebaseAuth.instance.signOut();
    isLogined = false;
    user = null;
  }

  Future<void> sendUserDataToDjango() async {
    if (user != null &&
        user!.kakaoAccount != null &&
        user!.kakaoAccount!.profile != null) {
      String nickname = user!.kakaoAccount!.profile!.nickname ?? 'Unknown';
      String email = user!.kakaoAccount!.email ?? '';

      // userDataResponse test
      var userDataResponse = await http.post(
        Uri.parse(
            'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': nickname,
          // 추가 필드
        }),
      );

      if (userDataResponse.statusCode == 200) {
        print("User data sent successfully");
      } else {
        print("Failed to send user data");
      }

      //  pillDataResponse test
      var pillDataResponse = await http.post(
        Uri.parse(
            'http://ec2-3-129-91-47.us-east-2.compute.amazonaws.com/ezpill/api/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': nickname,
          // 추가 필드
        }),
      );

      if (pillDataResponse.statusCode == 200) {
        print("User data sent successfully");
      } else {
        print("Failed to send user data");
      }
    }
  }
}
