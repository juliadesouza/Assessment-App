import 'package:assessment_app/model/assessment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/timeout_database.dart';
import '../../services/service.dart';
import '../../model/response.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(UnauthenticatedCode()) {
    on<VerifyTimeout>((event, emit) async {
      await TimeoutDatabase().open();
      DateTime? last = await TimeoutDatabase().getLastAssessmentDatetime();
      if (last == null) {
        emit(Avaliable());
        emit(UnauthenticatedCode());
      } else {
        DateTime current = DateTime.now();
        Duration diff =
            last.add(const Duration(minutes: 30)).difference(current);

        if (diff.inMinutes <= 0) {
          emit(Avaliable());
          emit(UnauthenticatedCode());
        } else {
          emit(Timeout(diff.inMinutes.toString()));
          emit(UnauthenticatedCode());
        }
      }
    });

    on<VerifyCode>((event, emit) async {
      emit(Authenticating());
      Response response = await Service().verifyCode(event.code);
      if (response.successfull) {
        emit(AuthenticatedCode(response.assessment));
      } else {
        emit(CodeError("Código Inválido."));
        emit(UnauthenticatedCode());
      }
    });
  }
}
