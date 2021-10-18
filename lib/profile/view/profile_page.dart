import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/common/common.dart';
import 'package:flutter_firebase_login/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoaded) {
                    final user =
                        state.users.firstWhere((user) => user.uid == auth.id);
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              const _AppBar(),
                              _ProfileAvatar(user: user)
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xffFFFFFF),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const _InfoTitle(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const _InfoName(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserName(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoEmail(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserEmail(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoMobile(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: const <Widget>[
                                        // Flexible(
                                        //   child: Text(
                                        //     _mobile ?? "Loading",
                                        //     style: GoogleFonts.roboto(
                                        //       fontSize: 18.0,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ));
  }
}

class _InfoMobile extends StatelessWidget {
  const _InfoMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Mobile',
                  style: GoogleFonts.roboto(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}

class _InfoUserEmail extends StatelessWidget {
  const _InfoUserEmail({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Text(
                user.email,
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ));
  }
}

class _InfoEmail extends StatelessWidget {
  const _InfoEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Email',
                  style: GoogleFonts.roboto(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}

class _InfoUserName extends StatelessWidget {
  const _InfoUserName({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Text(
                user.displayName,
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ));
  }
}

class _InfoName extends StatelessWidget {
  const _InfoName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Name',
                  style: GoogleFonts.roboto(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}

class _InfoTitle extends StatelessWidget {
  const _InfoTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Parsonal Information',
                  style: GoogleFonts.roboto(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Avatar(photo: user.photoURL),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'My Profile',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black),
              ),
            )
          ],
        ));
  }
}
