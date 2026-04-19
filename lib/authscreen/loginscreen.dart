import 'package:challenge_final_project/authscreen/signupscreen.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String loginscreenPath = "/loginscreen";
  static const String loginscreenName = "loginscreen";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _onLoginTap() {
    if (_key.currentState != null && _key.currentState!.validate()) {
      // 2. 검증 통과 시 데이터 저장
      _key.currentState!.save();

      // 이후 로그인 API 호출 등 로직 진행
      print("검증 완료! 로그인 로직을 진행합니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen"), centerTitle: true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "이메일을 입력해주세요.";
                        final regExp = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!regExp.hasMatch(value)) return "올바른 이메일 형식이 아닙니다.";
                        return null;
                      },
                    ),
                  ),
                  AppSize.h24,
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
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
                        return null;
                      },
                    ),
                  ),

                  AppSize.h24,
                  GestureDetector(
                    onTap: _onLoginTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
        child: GestureDetector(
          onTap: () => context.goNamed(SignupScreen.signupscreenName),
          child: Text("sign up"),
        ),
      ),
    );
  }
}
