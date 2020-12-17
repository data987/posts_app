import 'package:zemoga_posts/core/models/comment_model.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/models/user_model.dart';

List<PostModel> mockPosts = [
  PostModel(
      id: 1,
      title: 'title 1',
      body: 'text 1',
      read: true,
      favorite: false,
      userId: 1),
  PostModel(
      id: 1,
      title: 'title 1',
      body: 'text 1',
      read: true,
      favorite: false,
      userId: 1),
  PostModel(
      id: 1,
      title: 'title 1',
      body: 'text 1',
      read: false,
      favorite: true,
      userId: 2),
  PostModel(
      id: 1,
      title: 'title 1',
      body: 'text 1',
      read: false,
      favorite: true,
      userId: 2)
];

List<Comment> mockComments = [
  Comment(
      id: 1,
      body: 'comment body',
      postId: 1,
      name: 'comment name',
      email: 'email@gmail.com'),
  Comment(
      id: 2,
      body: 'comment body',
      postId: 1,
      name: 'comment name',
      email: 'email@gmail.com'),
  Comment(
      id: 3,
      body: 'comment body',
      postId: 1,
      name: 'comment name',
      email: 'email@gmail.com'),
  Comment(
      id: 4,
      body: 'comment body',
      postId: 1,
      name: 'comment name',
      email: 'email@gmail.com')
];

List<User> mockUsers = [
  User(
      id: 1,
      name: 'User name',
      email: 'email@gmail.com',
      website: 'site.com',
      company: Company(name: 'zemoga'),
      phone: '43242344',
      username: 'user zemoga',
      address: Address(
          city: 'Buenos Aires',
          street: 'Palermo',
          zipcode: '1119',
          geo: Geo(lat: '12323', lng: '-32424'),
          suite: 'none')),
  User(
      id: 2,
      name: 'User name',
      email: 'email@gmail.com',
      website: 'site.com',
      company: Company(name: 'zemoga'),
      phone: '43242344',
      username: 'user zemoga',
      address: Address(
          city: 'Buenos Aires',
          street: 'Palermo',
          zipcode: '1119',
          geo: Geo(lat: '12323', lng: '-32424'),
          suite: 'none')),
  User(
      id: 3,
      name: 'User name',
      email: 'email@gmail.com',
      website: 'site.com',
      company: Company(name: 'zemoga'),
      phone: '43242344',
      username: 'user zemoga',
      address: Address(
          city: 'Buenos Aires',
          street: 'Palermo',
          zipcode: '1119',
          geo: Geo(lat: '12323', lng: '-32424'),
          suite: 'none')),
];

List<PostModel> mockPostsComments = [
  PostModel(
      id: 1,
      title: 'title 1',
      body: 'text 1',
      read: true,
      favorite: false,
      userId: 1,
      comments: mockComments),
  PostModel(
      id: 2,
      title: 'title 1',
      body: 'text 1',
      read: false,
      favorite: false,
      userId: 3),
  PostModel(
      id: 3,
      title: 'title 1',
      body: 'text 1',
      read: false,
      favorite: true,
      userId: 2),
  PostModel(
      id: 4,
      title: 'title 1',
      body: 'text 1',
      read: false,
      favorite: true,
      userId: 2)
];
