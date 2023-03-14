part of 'token_bloc.dart';

@immutable
abstract class TokenState {}

class TokenInitialState extends TokenState {}

class TokenLoadingState extends TokenState {}

class TokenSuccessState extends TokenState {}

class TokenFailureState extends TokenState {}
