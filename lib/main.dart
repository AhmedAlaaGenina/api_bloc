import 'package:api_bloc/blocs/post_bloc.dart';
import 'package:api_bloc/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PostBloc>(
        create: (BuildContext context) => PostBloc(PostRepo()),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PostBloc bloc;
  @override
  void initState() {
    bloc = context.read<PostBloc>();
    bloc.add(DoFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Bloc"),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (BuildContext context, state) {
            if (state is PostInitial) {
              return CircularProgressIndicator();
            } else if (state is LoadingState) {
              return CircularProgressIndicator();
            } else if (state is FetchSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${state.posts[index].title}'),
                    subtitle: Text('${state.posts[index].body}'),
                  );
                },
                itemCount: state.posts.length,
              );
            } else if (state is ErrorState) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
