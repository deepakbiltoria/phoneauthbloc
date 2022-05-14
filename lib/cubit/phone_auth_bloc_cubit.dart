import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_bloc_state.dart';

class PhoneAuthBlocCubit extends Cubit<PhoneAuthBlocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  PhoneAuthBlocCubit() : super(PhoneAuthBlocInitial()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(PhoneAuthLoggedInState(currentUser));
    } else {
      emit(PhoneAuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(PhoneAuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(PhoneAuthErrorState(error.message.toString()));
        },
        codeSent: (verificationId, forcedResendingToken) {
          this._verificationId = verificationId;
          emit(PhoneAuthcodesentState());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this._verificationId = verificationId;
        });
  }

  Future<void> verifyOTP(String otp) async {
    emit(PhoneAuthLoadingState());
    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential usercredential =
          await _auth.signInWithCredential(credential);

      if (usercredential.user != null) {
        emit(PhoneAuthLoggedInState(usercredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthErrorState(e.message.toString()));
    } catch (e) {
      PhoneAuthErrorState(e.toString());
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    emit(PhoneAuthLoggedOutState());
  }
}
