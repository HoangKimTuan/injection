import 'package:dependencies/dependencies.dart';
import 'package:injection/infrastructure/database/user/database.dart';
import 'package:injection/infrastructure/database/user/models.dart';
import 'package:injection/services/post/service.dart';
import 'package:injection/ui/post/post_view.dart';
import 'package:injection/ui/post/post_viewmodel.dart';

class PostPresenter {
  void getPosts() {}
  set postsView(PostView value) {}
}

class BasicPostPresenter implements PostPresenter {
  PostView postView;
  PostViewModel postViewModel;
  Injector injector;

  BasicPostPresenter(this.injector) {
    this.postViewModel = new PostViewModel();
  }

  @override
  void getPosts() async {
    final user = injector.get<UserDatabase>();
    await user.save(new User(name: "", email: "", id: 0, username: "update"));
    final posts = injector.get<PostService>();
    List msg = await posts.getAll();
    this.postViewModel.posts = msg;
    this.postView.refreshPost(this.postViewModel);
  }

  @override
  set postsView(PostView value) {
    postView = value;
    this.postView.refreshPost(this.postViewModel);
  }
}
