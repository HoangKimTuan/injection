import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:injection/ui/post/post_presenter.dart';
import 'package:injection/ui/post/post_view.dart';
import 'package:injection/ui/post/post_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostScreen extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            height: 600.0,
            margin: EdgeInsets.only(bottom: 50),
            child: new PostList(new BasicPostPresenter(injector)),
          ),
          CachedNetworkImage(
            imageUrl: "https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}

class PostList extends StatefulWidget {
  final PostPresenter presenter;

  const PostList(this.presenter, {Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => new PostListState();
}

class PostListState extends State<PostList> implements PostView {
  PostViewModel viewModel;

  @override
  void initState() {
    this.widget.presenter.postsView = this;
    this.widget.presenter.getPosts();
    super.initState();
  }

  showLoadingDialog() {
    return viewModel.posts.length == 0;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  ListView getListView() => ListView.builder(
      itemCount: viewModel.posts.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(viewModel.posts[i].title),
            subtitle: Text(viewModel.posts[i].body),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: getBody());
  }

  @override
  void refreshPost(PostViewModel viewModel) {
    setState(() {
      this.viewModel = viewModel;
    });
  }
}