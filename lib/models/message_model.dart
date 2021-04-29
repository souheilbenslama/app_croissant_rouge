import 'package:app_croissant_rouge/models/user_model.dart';

class Message {
  final User sender;
  final String text;

  Message({this.sender, this.text});
}

final User currentUser =
    User(id: 0, name: 'Sena', imageUrl: 'assets/images/sena.jpg');
final User yui = User(id: 1, name: 'Yui', imageUrl: 'assets/images/yui.jpg');
final User ryuu = User(id: 2, name: 'Ryuu', imageUrl: 'assets/images/ryuu.jpg');
final User suya = User(id: 3, name: 'Suya', imageUrl: 'assets/images/suya.jpg');
final User haruka =
    User(id: 4, name: 'Haruka', imageUrl: 'assets/images/haruka.jpg');
final User neji = User(id: 4, name: 'Neji', imageUrl: 'assets/images/neji.jpg');
final User hanabi =
    User(id: 4, name: 'Hanabi', imageUrl: 'assets/images/hanabi.jpg');
final User iruka =
    User(id: 4, name: 'Iruka', imageUrl: 'assets/images/iruka.jpg');

//Favorite Contacts
List<User> favorites = [yui, haruka, suya, hanabi, neji, iruka];

// Example chats on home screen
List<Message> chats = [];

// Example chats in chat screen
List<Message> messages = [
  /*Message(
      sender: currentUser,
      time: '5:36 PM',
      text: "Aamiin",
      isLiked: true,
      unread: true),
  Message(
      sender: yui,
      time: '5:30 PM',
      text: "Semoga mamah cepet sadar :')",
      isLiked: true,
      unread: false),
  Message(
      sender: currentUser,
      time: '5:36 PM',
      text: "Mungkin nanti pada saatnya mamah pulang",
      isLiked: true,
      unread: true),
  Message(
      sender: yui,
      time: '5:30 PM',
      text: "Mamah kemana?",
      isLiked: true,
      unread: false),
  Message(
      sender: haruka,
      time: '5:36 PM',
      text: "Kangen sama mamah :(",
      isLiked: false,
      unread: true),
  Message(
      sender: ryuu,
      time: '7:30 PM',
      text: "Mudah-mudahan mamah cepet pulang :')",
      isLiked: false,
      unread: true)*/
];
