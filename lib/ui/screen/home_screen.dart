import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpagination/model/PostModel.dart';
import 'package:flutterblocpagination/repository/post_repository.dart';
import 'package:flutterblocpagination/ui/bloc/posts_bloc.dart';
import 'package:flutterblocpagination/ui/bloc/posts_event.dart';
import 'package:flutterblocpagination/ui/bloc/posts_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: RepositoryProvider(
        create: (context) => PostRepository(),
        child: BlocProvider(
          create: (context) => PostsBloc(context.read<PostRepository>())
            ..add(PostsLoadedEvent()),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsInitial) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is PostsLoadedState) {
                final List<PostModel> posts = state.posts;
                return ListView.builder(
                  controller: context.read<PostsBloc>().scrollController,
                  itemCount: context.read<PostsBloc>().isLoadMore
                      ? posts.length + 1
                      : posts.length,
                  itemBuilder: (context, index) {
                    if (index >= posts.length) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          bottom: 0,
                        ),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(post.id.toString()),
                            ),
                            title: Text(post.title!),
                            subtitle: Text(post.body!),
                          ),
                        ),
                      );
                    }
                  },
                );
              }
              if (state is PostsErrorState) {
                return Center(
                  child: SelectableText(state.error),
                );
              } else {
                return const Center(child: Text("No Posts"));
              }
            },
          ),
        ),
      ),
    );
  }
}
