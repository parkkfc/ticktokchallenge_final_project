import 'package:challenge_final_project/viewmodel/editpostviewmodel.dart';
import 'package:challenge_final_project/widget/appsize.dart';
import 'package:challenge_final_project/widget/appts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditScreen extends ConsumerStatefulWidget {
  const EditScreen({super.key});

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final List<String> _imoticonList = ["😀", "😞", "😡", "😱", "😐", "🥱"];
  String selectedEmoji = "";
  final TextEditingController _controller = TextEditingController();
  void _selectEmoji(String emoji) {
    setState(() {
      selectedEmoji = (selectedEmoji == emoji) ? "" : emoji;
    });
  }

  Future<void> _onPostButton() async {
    await ref
        .read(editpostViewModelProvider.notifier)
        .uploadPost(_controller.text, selectedEmoji);
    if (!ref.read(editpostViewModelProvider).hasError) {
      if (!mounted) return; // 위젯이 여전히 떠있는지 확인

      _controller.clear();
      setState(() {
        selectedEmoji = "";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final refer = ref.watch(editpostViewModelProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: refer.when(
        data: (data) => Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.fire, color: Colors.red),
                SizedBox(width: 8),
                Text("MOOD", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                FaIcon(FontAwesomeIcons.fire, color: Colors.red),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How do you feel?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppTS.s18SubTitle,
                    ),
                  ),
                  AppSize.h16,
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 200, // 기본적으로 보여줄 최소 높이
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        top: BorderSide(width: 2),
                        left: BorderSide(width: 3),
                        right: BorderSide(width: 2),
                        bottom: BorderSide(width: 5),
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: "Write it down here!",
                      ),
                    ),
                  ),
                  AppSize.h24,
                  Text(
                    "what's your mood?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppTS.s18SubTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _imoticonList.map((emoji) {
                      return GestureDetector(
                        onTap: () {
                          _selectEmoji(emoji);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 5.0,
                                ), // 하단: 빨간선
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ), // 좌측: 얇게
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 5.0,
                                ),
                              ),
                              color: selectedEmoji == emoji
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              emoji,
                              style: GoogleFonts.notoColorEmoji(
                                fontSize: 25,

                                // 선택된 이모티콘에 살짝 효과 주기
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppSize.h24,
                  Center(
                    child: GestureDetector(
                      onTap: _onPostButton,
                      child: Container(
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
                        width: 300,
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Post",
                                style: TextStyle(
                                  fontSize: AppTS.s20AppBar,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        error: (error, StackTrace) =>
            Center(child: Text("Sending error pop up")),
        loading: () => Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
