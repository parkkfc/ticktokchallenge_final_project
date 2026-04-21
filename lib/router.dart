import 'package:challenge_final_project/authscreen/loginscreen.dart';
import 'package:challenge_final_project/authscreen/signupscreen.dart';
import 'package:challenge_final_project/authscreen/homescreen.dart';
import 'package:challenge_final_project/mainpage.dart';
import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final authState = ref.watch(authStreamProvider);

  return GoRouter(
    initialLocation: HomeScreen.homescreenPath,
    redirect: (context, state) {
      final user = authState.value;
      final isLoggingIn =
          state.matchedLocation == "/" ||
          state.matchedLocation == SignupScreen.signupscreenPath;
      if (user == null) {
        return isLoggingIn ? null : "/";
      }
      if (isLoggingIn) {
        return HomeScreen.homescreenPath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        name: LoginScreen.loginscreenName,
        builder: (context, state) {
          return LoginScreen();
        },
      ),

      GoRoute(
        path: SignupScreen.signupscreenPath,
        name: SignupScreen.signupscreenName,
        builder: (context, state) {
          return SignupScreen();
        },
      ),
      GoRoute(
        path: HomeScreen.homescreenPath,
        name: HomeScreen.homescreenName,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
    ],
  );
});
