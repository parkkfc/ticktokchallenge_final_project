import 'dart:ffi';

import 'package:challenge_final_project/authscreen/userinfoscreen.dart';
import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:challenge_final_project/widget/appts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  static const String signupscreenPath = "/signupscreen";
  static const String signupscreenName = "signupscreen";

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _onNextButton(BuildContext context) {
    if (_key.currentState == null) return;
    if (_key.currentState!.validate()) {
      print(ref.read(authMapProvider.notifier).state);
      context.pushNamed(UserInfoScreen.userinfoName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up info"), centerTitle: true),
      body: Center(
        child: Column(
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
                        ref.read(authMapProvider.notifier).state = {
                          ...ref.read(authMapProvider.notifier).state,
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
                      obscureText: true,
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

                        ref.read(authMapProvider.notifier).state = {
                          ...ref.read(authMapProvider.notifier).state,
                          "password": value,
                        };

                        return null;
                      },
                    ),
                  ),
                  AppSize.h24,
                  GestureDetector(
                    onTap: () => _onNextButton(context),
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
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTS.s22SectionTitle,
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
    );
  }
}
