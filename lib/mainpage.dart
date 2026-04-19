import 'package:flutter/material.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});
  static const String homepagescreenPath = "/homepagescreen";

  static const String homepagescreenName = "homepagescreen";
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MainHomePage")),
      body: Center(child: Text("main")),
    );
  }
}
