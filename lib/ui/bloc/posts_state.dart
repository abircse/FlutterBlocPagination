import 'package:equatable/equatable.dart';
import 'package:flutterblocpagination/model/PostModel.dart';

abstract class PostsState extends Equatable {
  final dynamic posts;
  const PostsState(this.posts);

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial(super.posts);
}

// ---------------------------------------------
// Post Error State
// Pass Loaded Post from Post Repository
// ---------------------------------------------
class PostsLoadedState extends PostsState {
  @override
  final List<PostModel> posts;
  const PostsLoadedState({required this.posts}) : super(posts);

  @override
  List<Object> get props => [posts];
}

// ---------------------------------------------
// Post Error State
// Pass Error message
// ---------------------------------------------
class PostsErrorState extends PostsState {
  final String error;
  const PostsErrorState(this.error) : super(null);

  @override
  List<Object> get props => [error];
}
