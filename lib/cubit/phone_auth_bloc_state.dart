part of 'phone_auth_bloc_cubit.dart';

@immutable
abstract class PhoneAuthBlocState {}

class PhoneAuthBlocInitial extends PhoneAuthBlocState {}

class PhoneAuthLoadingState extends PhoneAuthBlocState {}

class PhoneAuthcodesentState extends PhoneAuthBlocState {}

class PhoneAuthcodeVerifiedState extends PhoneAuthBlocState {}

class PhoneAuthLoggedInState extends PhoneAuthBlocState {
  final User firebaseUser;

  PhoneAuthLoggedInState(this.firebaseUser);
}

class PhoneAuthLoggedOutState extends PhoneAuthBlocState {}

class PhoneAuthErrorState extends PhoneAuthBlocState {
  final String errorMessage;

  PhoneAuthErrorState(this.errorMessage);
}
