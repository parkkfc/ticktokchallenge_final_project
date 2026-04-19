import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:challenge_final_project/widget/appts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});
  static const userinfoPath = "/userinfo";
  static const userinfoName = "userinfo";

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요.';
    }
    if (value.length < 2) {
      return '이름은 최소 2자 이상이어야 합니다.';
    }
    // 한글 또는 영문만 허용하는 정규식
    final nameRegExp = RegExp(r'^[a-zA-Z가-힣]+$');
    if (!nameRegExp.hasMatch(value)) {
      return '이름에는 숫자나 특수문자를 사용할 수 없습니다.';
    }
    return null;
  }

  String? birthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '생년월일을 입력해주세요.';
    }

    // 8자리 숫자 형식 (YYYYMMDD) 체크
    if (value.length != 8 || int.tryParse(value) == null) {
      return '생년월일 8자리를 입력해주세요 (예: 19950101).';
    }

    final year = int.parse(value.substring(0, 4));
    final month = int.parse(value.substring(4, 6));
    final day = int.parse(value.substring(6, 8));

    // 월/일 범위 체크
    if (month < 1 || month > 12) return '유효하지 않은 월입니다.';
    if (day < 1 || day > 31) return '유효하지 않은 일입니다.';

    // 실제 날짜로 변환하여 유효성 최종 확인
    try {
      final date = DateTime(year, month, day);
      if (date.isAfter(DateTime.now())) {
        return '미래의 날짜는 입력할 수 없습니다.';
      }
    } catch (e) {
      return '유효하지 않은 날짜입니다.';
    }

    return null;
  }

  Future<void> _onNextButton() async {
    if (_key.currentState == null) return;
    if (_key.currentState!.validate()) {
      final Map<String, dynamic> userInfo = ref
          .read(authMapProvider.notifier)
          .state;
      ref.read(authRepoProvider).signUpRepo(userInfo);
    }
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '핸드폰 번호를 입력해주세요.';
    }

    // 숫자만 추출 (하이픈 제거 시)
    final cleanNumber = value.replaceAll(RegExp(r'[^0-9]'), '');

    // 한국 핸드폰 번호 정규식
    // 01로 시작 + (0,1,6,7,8,9) + 7~8자리 숫자
    final phoneRegExp = RegExp(r'^01[016789][0-9]{7,8}$');

    if (!phoneRegExp.hasMatch(cleanNumber)) {
      return '유효한 핸드폰 번호 형식이 아닙니다.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Info",
          style: TextStyle(fontSize: AppTS.s24MainTitle),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      return nameValidator(value);
                    },
                  ),
                ),
                AppSize.h24,
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "birth:YYYYMMDD",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      return birthValidator(value);
                    },
                  ),
                ),
                AppSize.h24,
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "phonenumber",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      return phoneValidator(value);
                    },
                  ),
                ),
                AppSize.h24,
                GestureDetector(
                  onTap: () => _onNextButton(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
    );
  }
}
