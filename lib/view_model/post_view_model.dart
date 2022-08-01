// import 'package:flutter/cupertino.dart';
// import 'package:traveling_social_app/models/post.dart';
// import 'package:collection/collection.dart';
// import '../services/post_service.dart';
//
// class PostViewModel with ChangeNotifier {
//   PostViewModel() {
//     print("FETCH POSTS");
//     fetchPosts();
//   }
//
//   final PostService _postService = PostService();
//
//   Set<Post> _posts = <Post>{};
//
//   int _page = 0;
//   bool _isLoading = false;
//
//   void fetchPosts() async {
//     _page = 0;
//     var data = await _postService.getPosts(page: _page, pageSize: 4);
//     _posts.addAll(data);
//     notifyListeners();
//   }
//
//   void fetchMorePosts() async {
//     _isLoading = true;
//     _page = _page + 1;
//     var data = await _postService.getPosts(page: _page, pageSize: 4);
//     _posts.addAll(data);
//     if (data.isEmpty) {
//       _page = _page - 1;
//     }
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void addPost(Post post) {
//     _posts = <Post>{post}.union(_posts);
//     notifyListeners();
//   }
//
//   void removePost({required postId}) {
//     _posts.removeWhere((element) => element.id == postId);
//     _postService.hidePost(postId: postId);
//     notifyListeners();
//   }
//
//   void removeComment({required postId, required commentId}) {
//     Post? rs = _posts.singleWhereOrNull((element) => element.id == postId);
//     if (rs != null) {
//       try {
//         rs.myComments.removeWhere((element) => element.id == commentId);
//       } on Exception catch (e) {
//
//       }
//     }
//     notifyListeners();
//   }
//
//   void incrementCommentCount({required postId}) {
//     Post post = _posts.singleWhere((element) => element.id == postId);
//     post.commentCount = post.commentCount + 1;
//     notifyListeners();
//   }
//
//   void decrementCommentCount({required postId}) {
//     Post post = _posts.singleWhere((element) => element.id == postId);
//     post.commentCount = post.commentCount - 1;
//     notifyListeners();
//   }
//
//   clear() {
//     _posts = <Post>{};
//     notifyListeners();
//   }
//
//   //getters
//   Set<Post> get posts => _posts;
//
//   bool get isLoading => _isLoading;
// }
