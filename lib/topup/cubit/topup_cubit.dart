import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'topup_state.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit(this._razorpay) : super(const TopupState());

  final Razorpay _razorpay;

  void init() {
    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void amountChanged(final String value) {
    emit(
      state.copyWith(amount: double.parse(value), status: FormzStatus.valid),
    );
  }

  void submitOnPress(
    final String? displayName,
    final String? mobile,
    final String? email,
  ) {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    try {
      final options = {
        'key': 'rzp_test_HrKYY6mdiMRJLt',
        'amount': (double.parse(state.amount.toString()) * 100.roundToDouble())
            .toString(),
        'name': displayName ?? '',
        'description': 'Top up wallet',
        'prefill': {'contact': mobile ?? '', 'email': email ?? ''},
        'external': {
          'wallets': [''],
        },
        'currency': 'MYR'
      };

      _razorpay.open(options);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  void _handlePaymentSuccess(final PaymentSuccessResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
      ),
    );
  }

  void _handlePaymentError(final PaymentFailureResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionFailure,
      ),
    );
  }

  void _handleExternalWallet(final ExternalWalletResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionFailure,
      ),
    );
  }
}
