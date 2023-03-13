import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenInitial()) {
    on<TokenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
