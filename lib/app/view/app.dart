import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/current_user/bloc/current_user_bloc.dart';
import 'package:flutter_firebase_login/theme.dart';
import 'package:flutter_firebase_login/users/bloc/users_bloc.dart';
import 'package:users_repository/users_repository.dart';

class App extends StatelessWidget {
  const App({
    required final AuthenticationRepository authenticationRepository,
    required final FirebaseUsersRepository usersRepository,
    final Key? key,
  })  : _authenticationRepository = authenticationRepository,
        _usersRepository = usersRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirebaseUsersRepository _usersRepository;

  @override
  Widget build(final BuildContext context) => RepositoryProvider.value(
        value: _usersRepository,
        child: RepositoryProvider.value(
          value: _authenticationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (final _) => AppBloc(
                  authenticationRepository: _authenticationRepository,
                ),
              ),
              BlocProvider<UsersBloc>(
                create: (final context) => UsersBloc(
                  usersRepository: _usersRepository,
                )..add(LoadUsers()),
              ),
            ],
            child: BlocBuilder<AppBloc, AppState>(
              builder: (final context, final state) {
                final auth =
                    context.select((final AppBloc bloc) => bloc.state.user);
                final _currentUserBloc = CurrentUserBloc(
                  uid: auth.id,
                  usersRepository: _usersRepository,
                );

                return BlocProvider.value(
                  value: _currentUserBloc,
                  child: const AppView(),
                );
              },
            ),
          ),
        ),
      );
}

class AppView extends StatelessWidget {
  const AppView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    UserStatus _userStatus = UserStatus.appStatusUnauthenticated;
    final AppStatus _appStatus =
        context.select((final AppBloc bloc) => bloc.state.status);
    final CurrentUserStatus _currentUserStatus =
        context.select((final CurrentUserBloc bloc) => bloc.state.status);

    switch (_appStatus) {
      case AppStatus.unauthenticated:
        _userStatus = UserStatus.appStatusUnauthenticated;
        break;
      case AppStatus.authenticated:
        switch (_currentUserStatus) {
          case CurrentUserStatus.incompleted:
            _userStatus = UserStatus.currentUserStatusIncompleted;
            break;
          case CurrentUserStatus.unauthenticated:
            _userStatus = UserStatus.currentUserStatusIncompleted;
            break;
          case CurrentUserStatus.completed:
            _userStatus = UserStatus.currentUserStatusCompleted;
        }
        break;
    }

    return MaterialApp(
      theme: theme,
      home: FlowBuilder<UserStatus>(
        state: _userStatus,
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}

enum UserStatus {
  appStatusUnauthenticated,
  currentUserStatusIncompleted,
  currentUserStatusCompleted,
}
