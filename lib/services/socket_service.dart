import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService(){
    this._initConfig();
  }

  void _initConfig() {

    this._socket = IO.io('http://192.168.0.2:3000',{
      'transports': ['websocket'],
      'autoConnect': true,

    });


    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    
    this._socket.on('disconnect', (_)  {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('Bandas-activas', (payload)  {
    //   print('Bandas: $payload');
    // });
    

  }

}