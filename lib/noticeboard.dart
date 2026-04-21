import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:challenge_final_project/repository/postrepo.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:challenge_final_project/widget/appts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeBoardScreen extends ConsumerStatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  ConsumerState<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends ConsumerState<NoticeBoardScreen> {
  final List<String> _imoticonList = ["😀", "😞", "😡", "😱", "😐", "🥱"];

  void onsignOutButton() {
    ref.read(authRepoProvider).signOut();
  }

  String formatTimestamp(int milliseconds) {
    // 1. 한국어 설정 (한 번만 실행해도 됩니다)
    timeago.setLocaleMessages('ko', timeago.KoMessages());

    // 2. 숫자를 DateTime 객체로 변환
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    // 3. 상대적 시간으로 변환 ('ko'를 지정해야 한국어로 나옵니다)
    return timeago.format(date, locale: 'ko');
  }

  @override
  Widget build(BuildContext context) {
    final refer = ref.watch(postrepoStreamProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: refer.when(
          data: (data) {
            return [
              SliverAppBar(
                leading: Opacity(
                  opacity: 0, // 투명하게 만듦
                  child: IconButton(
                    onPressed: null, // 클릭 방지
                    icon: FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                    ), // 같은 크기의 아이콘
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: onsignOutButton,
                    icon: FaIcon(FontAwesomeIcons.rightFromBracket),
                  ),
                ],
                floating: true,
                expandedHeight: 56,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.fire, color: Colors.red),
                    SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                    Text(
                      "MOOD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    FaIcon(FontAwesomeIcons.fire, color: Colors.red),
                  ],
                ),
                centerTitle: true,
              ),

              SliverList.separated(
                separatorBuilder: (context, index) => AppSize.h16,
                itemCount: data.length,

                itemBuilder: (context, index) {
                  final post = data[index];
                  final String day = formatTimestamp(post["createdAt"]);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          constraints: BoxConstraints(minHeight: 50),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 5),
                              top: BorderSide(color: Colors.black, width: 2),
                              left: BorderSide(color: Colors.black, width: 2),
                              right: BorderSide(color: Colors.black, width: 3),
                            ),
                            color: Color(0xFF74BDA8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Mood: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppTS.s18SubTitle,
                                    ),
                                  ),
                                  Text(
                                    post["mood"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppTS.s18SubTitle,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                post["content"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppTS.s18SubTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSize.h12,
                        Text(day, style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  );
                },
              ),
            ];
          },
          error: (error, StackTrace) => [
            SliverToBoxAdapter(child: Center(child: Text("error pop up"))),
          ],
          loading: () => [
            SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          ],
        ),
      ),
    );
  }
}
