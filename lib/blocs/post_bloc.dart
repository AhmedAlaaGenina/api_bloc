import 'dart:async';

import 'package:api_bloc/model/post_model.dart';
import 'package:api_bloc/repository/post_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepo repo;
  PostBloc(this.repo) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is DoFetchEvent) {
      yield LoadingState();
      try {
        var posts = await repo.fetchPosts();
        yield FetchSuccess(posts: posts);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }
  }
}
