import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_firebase_login/current_user/bloc/current_user_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_repository/users_repository.dart';

class QRCode extends StatelessWidget {
  const QRCode({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const QRCode(),
      );

  @override
  Widget build(final BuildContext context) {
    Future<ui.Image> _loadOverlayImage() async {
      final Completer completer = Completer<ui.Image>();
      final byteData = await rootBundle.load('assets/bloc_logo_small.png');
      ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
      final ui.Image imageInfo = await completer.future;
      return imageInfo;
    }

    final FutureBuilder qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (final ctx, final snapshot) {
        final User user =
            ctx.select((final CurrentUserBloc bloc) => bloc.state.user);
        const size = 280.0;
        if (!snapshot.hasData) {
          return const SizedBox(width: size, height: size);
        }
        return CustomPaint(
          size: const Size.square(size),
          painter: QrPainter(
            data: user.uid,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color(0xff128760),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Color(0xff1a5441),
            ),
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: const Size.square(60),
            ),
          ),
        );
      },
    );

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      'Receive Money',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 23),
                    ),
                  ],
                )),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 280,
                  child: qrFutureBuilder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
