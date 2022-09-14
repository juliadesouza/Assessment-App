import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/service.dart';
import '../../model/response.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(UnauthenticatedCode()) {
    on<VerifyCode>((event, emit) async {
      emit(Authenticating());
      Response response = await Service().verifyCode(event.code);
      if (response.response) {
        emit(AuthenticatedCode());
      } else {
        emit(CodeError("Código Inválido: ${response.message}"));
        emit(UnauthenticatedCode());
      }
    });
  }
}
