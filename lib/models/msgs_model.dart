import 'package:rosheta_ui/models/msg_model.dart';

class Messages {
  final List<dynamic>? msgs;

  Messages({this.msgs});

  factory Messages.fromJson(Map<String,dynamic> jsonData) {
    return Messages(
      msgs: jsonData['msg']
    );
  }

}