import 'dart:convert';
import "dart:io";
import 'package:flutter/foundation.dart';


import 'package:drogo_libro/core/models/comment.dart';
import 'package:drogo_libro/core/models/post.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class WebApi {
  // static const _endpoint = 'https://jsonplaceholder.typicode.com';
  static const _endpoint = 'http://192.168.0.3:3000';
  
  static dynamic _httpClient;
  dynamic client;

  WebApi() {
    if (kIsWeb) {
      if (_httpClient == null) {
        _httpClient = new http.Client();
      }
      client = _httpClient;
    } else {
      if (_httpClient == null) {
        _httpClient = new HttpClient()
          ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      } 
      client = new IOClient(_httpClient);
    }
  }

  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$_endpoint/users/$userId');

    // Convert and return
    return User.fromJson(json.decode(response.body));
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$_endpoint/posts?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<List<DrogoInfo>> getDrogoInfosForUser(int userId) async {
      // Get user posts for id
      var response = await client.get('$_endpoint/drogo_infos');

      // parse into List
      var parsed = json.decode(response.body) as List<dynamic>;
      return parsed.map((element) => DrogoInfo.fromJson(element)).toList();
  }
  
  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = List<Comment>();

    // Get comments for post
    var response = await client.get('$_endpoint/comments?postId=$postId');

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;
    
    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }

    return comments;
  }
}
