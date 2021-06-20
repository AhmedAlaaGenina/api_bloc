part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {
  const PostInitial();
}

class LoadingState extends PostState {
  const LoadingState();
}

class FetchSuccess extends PostState {
  final List<PostModel> posts;

  FetchSuccess({this.posts});
}

class ErrorState extends PostState {
  final String message;

  ErrorState(this.message);
}
