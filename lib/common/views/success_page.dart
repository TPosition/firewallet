import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/home/home.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const SuccessPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: SuccessPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          child: Center(
            child: Column(
              children: <Widget>[
                const Image(
                    image: AssetImage("assets/ico_success.jpg"),
                    width: 100,
                    height: 100),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Payment Successful!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(0),
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  color: Colors.white,
                  child: const Text(
                    'Back to HomePage',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(AppView.route());
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
