import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {

  late io.Socket socket;

  SocketService() {
    final String apiUrl = dotenv.env['API_URL']!;

    socket = io.io(apiUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}
