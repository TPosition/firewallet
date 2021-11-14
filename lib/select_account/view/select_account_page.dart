import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/common/widgets/avatar.dart';
import 'package:flutter_firebase_login/select_account/cubit/select_account_cubit.dart';
import 'package:flutter_firebase_login/send_money/view/send_money_page.dart';
import 'package:flutter_firebase_login/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class SelectAccountPage extends StatelessWidget {
  const SelectAccountPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const SelectAccountPage(),
      );

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<UsersBloc, UsersState>(
        builder: (final context, final state) {
          if (state is UsersLoaded) {
            return BlocProvider(
              create: (final context) =>
                  SelectAccountCubit(users: state.users)..init(),
              child: Scaffold(
                backgroundColor: const Color(0xFFF4F4F4),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 16, right: 16),
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
                                  fontWeight: FontWeight.w700, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      _getSearchSection(),
                      _getAccountListSection()
                    ],
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      );
  Widget _getSearchSection() {
    Widget searchBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 8),
            child: BlocBuilder<SelectAccountCubit, SelectAccountState>(
              buildWhen: (final previous, final current) =>
                  previous.filteredUsersList != current.filteredUsersList,
              builder: (final context, final state) => TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Search for Phone number or Username',
                    hintStyle: GoogleFonts.roboto()),
                onChanged: (final value) =>
                    context.read<SelectAccountCubit>().searchChanged(value),
              ),
            ),
          ),
        )
      ],
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: searchBar,
        ),
      ),
    );
  }

  Widget _getAccountListSection() => Expanded(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: BlocBuilder<SelectAccountCubit, SelectAccountState>(
                    buildWhen: (final previous, final current) =>
                        previous.filteredUsersList != current.filteredUsersList,
                    builder: (final context, final state) => ListView.builder(
                      itemCount: state.filteredUsersList.isEmpty
                          ? state.usersList.length
                          : state.filteredUsersList.length,
                      itemBuilder:
                          (final BuildContext context, final int index) =>
                              _getReceiverSection(
                        state.filteredUsersList.isEmpty
                            ? state.usersList[index]
                            : state.filteredUsersList[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _getReceiverSection(final User? receiver) =>
      Builder(builder: (final context) {
        if (receiver != null) {
          return GestureDetector(
            onTapUp: (final tapDetail) {
              Navigator.of(context).push(SendMoneyPage.route(receiver));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Avatar(
                      photo: receiver.photoURL,
                    ),
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
                                fontSize: 14, color: const Color(0xFF929091)),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          );
        }
        return Container();
      });
}
