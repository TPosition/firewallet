import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/common/views/success_page.dart';
import 'package:flutter_firebase_login/current_user/bloc/current_user_bloc.dart';
import 'package:flutter_firebase_login/topup/cubit/topup_cubit.dart';
import 'package:flutter_firebase_login/users/bloc/users_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class TopupForm extends StatelessWidget {
  const TopupForm({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    final amountText = TextEditingController();

    return BlocListener<TopupCubit, TopupState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          context.read<UsersBloc>().add(
                UpdateUser(user.copyWith(balance: user.balance + state.amount)),
              );
          Navigator.of(context).push<void>(SuccessPage.route());
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Payment Failure')),
            );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(
                        'Top up wallet',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ],
                  )),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                            ),
                            child: Text(
                              'Enter Amount',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 16, bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'RM',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35),
                                ),
                                _AmountInput(amountText: amountText)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: _AmountFirstRow(amountText: amountText),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: _AmountSecondRow(amountText: amountText),
                          ),
                          RaisedButton(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            onPressed: () {
                              context.read<TopupCubit>().submitOnPress(
                                    user.displayName,
                                    user.mobile,
                                    user.email,
                                  );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF65D5E3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Text(
                                'Top up',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AmountSecondRow extends StatelessWidget {
  const _AmountSecondRow({
    required final this.amountText,
    final Key? key,
  }) : super(key: key);

  final TextEditingController amountText;

  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('100');
              amountText.text = '100';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'RM 100',
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('500');
              amountText.text = '500';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(
              'RM 500',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('1000');
              amountText.text = '1000';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'RM 1000',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
}

class _AmountFirstRow extends StatelessWidget {
  const _AmountFirstRow({
    required final this.amountText,
    final Key? key,
  }) : super(key: key);

  final TextEditingController amountText;

  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('10');
              amountText.text = '10';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'RM 10',
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('25');
              amountText.text = '25';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(
              'RM 25',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<TopupCubit>().amountChanged('50');
              amountText.text = '50';
            },
            color: const Color(0xFFF4F4F4),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'RM 50',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
}

class _AmountInput extends StatelessWidget {
  const _AmountInput({
    required final this.amountText,
    final Key? key,
  }) : super(key: key);

  final TextEditingController amountText;

  @override
  Widget build(final BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BlocBuilder<TopupCubit, TopupState>(
            buildWhen: (
              final previous,
              final current,
            ) =>
                previous.amount != current.amount,
            builder: (
              final context,
              final state,
            ) =>
                TextFormField(
              key: const Key('topupPage_amount_textField'),
              controller: amountText,
              onChanged: (final amount) =>
                  context.read<TopupCubit>().amountChanged(amount),
              cursorColor: Colors.cyan,
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                hintText: 'Amount',
                labelStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      );
}
