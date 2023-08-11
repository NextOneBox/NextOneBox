import '../Navbar.dart';
import 'package:figtrade/widget.dart';

import 'login.dart';
// class AuthService {
  handleAuthState()  {
    if (userdata!.isNotEmpty) {
      return Bottomapp();
    } else {
      return Loginscreen();
    }

  }
// }