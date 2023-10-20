import 'package:cash/Tasksoffer.dart';
import 'package:cash/quiz_file.dart';

import 'Login_screen.dart';
import 'navbar.dart';

import 'welcome.dart';

class AuthService {
  handleAuthState() {
    if (account!.isNotEmpty) {
      if (adsbox!.get(200) == true) {
        return Bottomapp();
      } else {
        return Taskoffers();
      }
    } else {
      return Loginscreen();
    }
  }
}
