import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/topup/cubit/topup_cubit.dart';
import 'package:flutter_firebase_login/topup/view/topup_form.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TopupPage());

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const TopupPage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => TopupCubit(Razorpay())..init(),
        child: const TopupForm(),
      );
}
