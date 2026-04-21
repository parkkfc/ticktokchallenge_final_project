import 'package:challenge_final_project/authscreen/editscreen.dart';
import 'package:challenge_final_project/noticeboard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const homescreenPath = "/homescreen";
  static const homescreenName = "homescreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _pageIndex != 0,
            child: Center(child: NoticeBoardScreen()),
          ),
          Offstage(offstage: _pageIndex != 1, child: EditScreen()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
                color: _pageIndex == 0 ? Colors.black : Colors.grey,
              ),
              onPressed: () => setState(() => _pageIndex = 0),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 30,
                color: _pageIndex == 1 ? Colors.black : Colors.grey,
              ),
              onPressed: () => setState(() => _pageIndex = 1),
            ),
          ],
        ),
      ),
    );
  }
}
