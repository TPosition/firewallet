import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/common/views/failure_page.dart';
import 'package:flutter_firebase_login/common/views/success_page.dart';
import 'package:flutter_firebase_login/common/widgets/avatar.dart';
import 'package:flutter_firebase_login/current_user/bloc/current_user_bloc.dart';
import 'package:flutter_firebase_login/send_money/cubit/send_money_cubit.dart';
import 'package:flutter_firebase_login/transactions/bloc/transactions_bloc.dart';
import 'package:flutter_firebase_login/transactions/transaction_category_contant.dart';
import 'package:flutter_firebase_login/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:users_repository/users_repository.dart';
import 'package:formz/formz.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({
    required final this.receiver,
    final Key? key,
  }) : super(key: key);

  final User receiver;

  static Route route(final User receiver) => MaterialPageRoute<void>(
        builder: (final _) => SendMoneyPage(
          receiver: receiver,
        ),
      );

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (final context) => SendMoneyCubit(),
      child: BlocListener<SendMoneyCubit, SendMoneyState>(
        listener: (final context, final state) {
          if (state.status.isSubmissionSuccess) {
            context.read<UsersBloc>().add(
                  UpdateUser(
                    receiver.copyWith(balance: receiver.balance + state.amount),
                  ),
                );
            context.read<UsersBloc>().add(
                  UpdateUser(
                    receiver.copyWith(balance: user.balance + state.amount),
                  ),
                );
            context.read<TransactionsBloc>().add(
                  AddTransaction(
                    Transaction(
                      amount: state.amount,
                      category: ktransfer,
                      senderDisplayName: user.displayName,
                      senderUID: user.uid,
                      receiverDisplayName: receiver.displayName,
                      receiverUID: receiver.uid,
                    ),
                  ),
                );
            Navigator.of(context).push<void>(SuccessPage.route());
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        Text(
                          'Send Money',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder:
                        (final BuildContext context, final int index) =>
                            _getSection(index, receiver),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSection(final int index, final User receiver) {
    switch (index) {
      case 0:
        return _getReceiverSection(receiver);
      case 1:
        return _getEnterAmountSection();
      case 2:
        return _getSendSection(receiver);
    }
    return const FailurePage();
  }

  Widget _getReceiverSection(final User receiver) => Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Avatar(photo: receiver.photoURL),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  receiver.displayName,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.phone,
                        size: 13,
                        color: Color(0xFF929091),
                      ),
                    ),
                    Text(
                      receiver.mobile,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: const Color(0xFF929091),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      );

  Widget _getEnterAmountSection() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(11))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Text(
                    'Enter Amount',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '\RM',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: _AmountForm(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _getSendSection(final User receiver) => Builder(
      builder: (final context) => Container(
            margin: const EdgeInsets.all(16),
            child: GestureDetector(
              onTapUp: (final _) {
                context.read<SendMoneyCubit>().submitOnPress();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xFF65D5E3),
                    borderRadius: BorderRadius.all(Radius.circular(11))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  'SEND',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ));
}

class _AmountForm extends StatelessWidget {
  const _AmountForm({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    return BlocBuilder<SendMoneyCubit, SendMoneyState>(
      buildWhen: (final previous, final current) =>
          previous.amount != current.amount,
      builder: (final context, final state) => TextField(
        key: const Key('SendMoneyPage_AmountForm'),
        onChanged: (final amount) =>
            context.read<SendMoneyCubit>().amountChanged(amount, user.balance),
        keyboardType: TextInputType.number,
        style: GoogleFonts.roboto(
            fontSize: 35, fontWeight: FontWeight.w700, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Amount',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          helperText: '',
          errorText:
              state.isEnough ? null : 'You are out of balance, please top up.',
        ),
      ),
    );
  }
}
