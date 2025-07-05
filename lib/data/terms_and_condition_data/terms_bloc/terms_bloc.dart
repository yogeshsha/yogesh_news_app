
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/terms_model/terms_model.dart';
import '../domain/usecases/terms_usecase_interface.dart';


part 'terms_event.dart';
part 'terms_state.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  final TermsUseCase termsUseCase;

  TermsBloc({required this.termsUseCase}) : super(TermsInitial()) {
    on<FetchTerms>((event, emit) async {
      emit(TermsLoading());
      try {
        final details = await termsUseCase.getTermsApi();
        emit(TermsLoaded(details: details));
      } catch (e) {
        emit(TermsError(message: e.toString()));
      }
    });
  }
}
