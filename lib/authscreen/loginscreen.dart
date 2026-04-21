import 'package:challenge_final_project/authscreen/signupscreen.dart';
import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:challenge_final_project/widget/appts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  static const String loginscreenPath = "/loginscreen";
  static const String loginscreenName = "loginscreen";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _onLoginTap(WidgetRef ref) {
    if (_key.currentState != null && _key.currentState!.validate()) {
      // 2. 검증 통과 시 데이터 저장
      _key.currentState!.save();
      final userInfo = ref.read(authMapProvider.notifier).state;
      ref.read(authRepoProvider).signInRepo(userInfo);
      // 이후 로그인 API 호출 등 로직 진행
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFFECE6C2),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.fire, color: Colors.red),
            Text("MOOD", style: TextStyle(fontWeight: FontWeight.bold)),
            FaIcon(FontAwesomeIcons.fire, color: Colors.red),
          ],
        ),

        backgroundColor: Color(0xFFECE6C2),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            Text(
              "Welcome!",
              style: TextStyle(
                fontSize: AppTS.s24MainTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _key,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSize.h24,
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ), // 👈 두께 조절
                        ),
                        // 2. 포커스 보더 (클릭해서 입력 중일 때)
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 3.0,
                          ), // 👈 더 강조하고 싶을 때
                        ),
                        // 3. 기본값 (위의 설정들이 없을 때 대비)
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "이메일을 입력해주세요.";
                        final regExp = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!regExp.hasMatch(value)) return "올바른 이메일 형식이 아닙니다.";
                        final refer = ref.read(authMapProvider.notifier).state;
                        ref.read(authMapProvider.notifier).state = {
                          ...refer,
                          "email": value,
                        };
                        return null;
                      },
                    ),
                  ),
                  AppSize.h24,
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ), // 👈 두께 조절
                        ),
                        // 2. 포커스 보더 (클릭해서 입력 중일 때)
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 3.0,
                          ), // 👈 더 강조하고 싶을 때
                        ),
                        // 3. 기본값 (위의 설정들이 없을 때 대비)
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "비밀번호를 입력해주세요.";
                        // 10글자 이상 + 최소 하나의 특수문자 포함
                        final regExp = RegExp(
                          r'^(?=.*[!@#$%^&*(),.?":{}|<>]).{10,}$',
                        );
                        if (!regExp.hasMatch(value))
                          return "특수문자 포함 10자 이상 입력해주세요.";
                        final refer = ref.read(authMapProvider.notifier).state;
                        ref.read(authMapProvider.notifier).state = {
                          ...refer,
                          "password": value,
                        };
                        return null;
                      },
                    ),
                  ),

                  AppSize.h24,
                  GestureDetector(
                    onTap: () => _onLoginTap(ref),
                    child: Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.symmetric(),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black, width: 1.0),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ), // 하단: 빨간선
                          left: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ), // 좌측: 얇게
                          right: BorderSide(color: Colors.black, width: 5.0),
                        ),
                        color: Color(0xFFFFA6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Enter",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 200,
        color: Color(0xFFECE6C2),
        child: GestureDetector(
          onTap: () => context.goNamed(SignupScreen.signupscreenName),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 1.0),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ), // 하단: 빨간선
                    left: BorderSide(color: Colors.black, width: 1.0), // 좌측: 얇게
                    right: BorderSide(color: Colors.black, width: 5.0),
                  ),
                  color: Color(0xFFFFA6F6),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 300,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create an account",
                        style: TextStyle(
                          fontSize: AppTS.s20AppBar,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSize.w12,
                      FaIcon(FontAwesomeIcons.arrowRight),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
