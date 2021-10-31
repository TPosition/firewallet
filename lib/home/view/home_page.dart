import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/common/common.dart';
import 'package:flutter_firebase_login/current_user/bloc/current_user_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 35),
                  _appBar(context, user),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "My wallet",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _balanceCard(context, user),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Operations",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _operationsWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(final BuildContext context, final User user) => Row(
        children: <Widget>[
          Avatar(photo: user.photoURL),
          const SizedBox(width: 15),
          Text(
            "Hello, ",
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.displayName,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2c405b),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {},
          ),
        ],
      );

  Widget _operationsWidget(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                ButtonTheme(
                  height: 90,
                  minWidth: 90,
                  child: RaisedButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.document_scanner_outlined),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Scan",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff76797e),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ButtonTheme(
                  height: 90,
                  minWidth: 90,
                  child: RaisedButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.transfer_within_a_station),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Transfer",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff76797e),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ButtonTheme(
                  height: 90,
                  minWidth: 90,
                  child: RaisedButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.call_received),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Request",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff76797e),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget _balanceCard(final BuildContext context, final User user) => ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .27,
        color: const Color(0xff15294a),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total Balance',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: LightColor.lightNavyBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'RM ',
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: LightColor.yellow.withAlpha(200),
                      ),
                    ),
                    Text(
                      user.balance.toString(),
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: LightColor.yellow2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 85,
                  child: RaisedButton(
                    onPressed: () {},
                    color: LightColor.navyBlue1,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Top up",
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Positioned(
              left: -170,
              top: -170,
              child: CircleAvatar(
                radius: 130,
                backgroundColor: LightColor.lightBlue2,
              ),
            ),
            const Positioned(
              left: -160,
              top: -190,
              child: CircleAvatar(
                radius: 130,
                backgroundColor: LightColor.lightBlue1,
              ),
            ),
            const Positioned(
              right: -170,
              bottom: -170,
              child: CircleAvatar(
                radius: 130,
                backgroundColor: LightColor.yellow2,
              ),
            ),
            const Positioned(
              right: -160,
              bottom: -190,
              child: CircleAvatar(
                radius: 130,
                backgroundColor: LightColor.yellow,
              ),
            )
          ],
        ),
      ));
}

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = Color(0xff1d2635);
  static const Color subTitleTextColor = Color(0xff797878);

  static const Color lightBlue1 = Color(0xff375efd);
  static const Color lightBlue2 = Color(0xff3554d3);
  static const Color navyBlue1 = Color(0xff15294a);
  static const Color lightNavyBlue = Color(0xff6d7f99);
  static const Color navyBlue2 = Color(0xff2c405b);

  static const Color yellow = Color(0xfffbbd5c);
  static const Color yellow2 = Color(0xffe7ad03);

  static const Color lightGrey = Color(0xfff1f1f3);
  static const Color grey = Color(0xffb9b9b9);
  static const Color darkgrey = Color(0xff625f6a);

  static const Color black = Color(0xff040405);
  static const Color lightblack = Color(0xff3E404D);
}
