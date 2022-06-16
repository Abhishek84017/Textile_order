import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textile/config/router/router.dart';
import 'package:textile/constants/app_assets.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/screens/widgets/button.dart';
import 'package:textile/screens/widgets/input.dart';
import 'package:textile/utils/helpers/utils.dart';
import 'package:textile/utils/mixins/post_frame_callback.dart';
import 'package:textile/utils/services/rest_api.dart';

import '../home/homepage.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with PostFrameCallBack {
  late TextEditingController _nameCtrl;
  late TextEditingController _passwordCtrl;
  bool _isInAsync = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(
        text: kSharedPreferences.getString(PrefConst.username));
    _passwordCtrl = TextEditingController(
        text: kSharedPreferences.getString(PrefConst.password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.loginBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.15.sh, bottom: 0.1.sh),
                    child: const Text(
                      "Textile Ordering\nSystem",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.2,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30.h),
                Input(
                  hintText: "Name",
                  controller: _nameCtrl,
                ),
                Input(
                  hintText: "Password",
                  controller: _passwordCtrl,
                  obscureText: true,
                ),
                Button(
                  label: "Log in",
                  onPressed: _signIn,
                  isInAsync: _isInAsync,
                  margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Method to signIn
  void _signIn() async {
    Utils.unFocus(context);
    await kSharedPreferences.setString(PrefConst.username, _nameCtrl.text);
    await kSharedPreferences.setString(PrefConst.password, _passwordCtrl.text);

    final payload = {
      "username": _nameCtrl.text,
      "password": _passwordCtrl.text,
    };

    setState(() {
      _isInAsync = true;
    });
    final response = await Services.signIn(payload);
    if (response.statusCode == 200) {
      kUserdata = response.data;
      Navigate.replace(const HomePage());
    } else {
      Utils.showToast(response.message ?? "Invalid username and password");
      setState(() {
        _isInAsync = false;
      });
    }
  }

  @override
  void postFrameCallback(Duration timeStamp) {
    /// Caching image for further use
    precacheImage(const AssetImage(AppAssets.loginBackground), context);
  }
}
