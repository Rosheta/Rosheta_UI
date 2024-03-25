import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {

  late IO.Socket socket;

  SocketService() {
    final String apiUrl = dotenv.env['API_URL']!;

    socket = IO.io(apiUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}
