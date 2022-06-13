import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/data/models/LoginRequest.dart';
import 'package:volunteer/data/storage/user_shared_preferences.dart';
import 'package:volunteer/logic/blocs/auth/login/login_event.dart';
import 'package:volunteer/logic/blocs/form_submission_status.dart';

import '../../../../data/models/User.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApi authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        bool val = await authRepo
            .login(LoginRequest(email: state.email, password: state.password));
        if (val) {
          UserSharedPreferences.setEmail(state.email);
          yield state.copyWith(formStatus: SubmissionSuccess());
        }
      } catch (e) {
        Exception ex = Exception("Неправильная почта или пароль");
        yield state.copyWith(formStatus: SubmissionFailed(ex as Exception));
      }
    }
  }
}
