import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
 
class SocketServices {
  static late io.Socket _socket;
  bool show = false;
 
  ///<<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    _socket = io.io(
      AppApiEndPoint.domain,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
 
    _socket.onConnect((data) => AppPrint.appLog("=============> Connection $data"));
    _socket.onConnectError((data) => AppPrint.appLog("========>Connection Error $data"));
    _socket.connect();
    // _socket.on("user-notification::${LocalStorage.userId}", (data) {
    //   appLog("================> get Data on socket: $data");
    //   NotificationService.showNotification(data);
    // });
  }
 
  static on(String event, Function(dynamic data) handler) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.on(event, handler);
  }
 
  static emit(String event, Function(dynamic data) handler) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.emit(event, handler);
  }
 
  static emitWithAck(
    String event,
    Map<String, dynamic> data,
    Function(dynamic data) handler,
  ) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.emitWithAck(event, data, ack: handler);
  }
}
 





// import 'package:el_mago/const/app_api_end_point.dart';
// import 'package:el_mago/services/api/get_storage_services.dart';
// import 'package:el_mago/widgets/app_log/app_print.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// class SocketAllOparations {
//   SocketAllOparations._privateConstructor();
//   static final SocketAllOparations _instance =
//       SocketAllOparations._privateConstructor();
//   static SocketAllOparations get instance => _instance;

//   GetStorageServices getStorageServices = GetStorageServices.instance;

//   io.Socket? appRootSocket;
//   bool _isConnecting = false;
//   final Map<String, List<void Function(dynamic)>> _eventHandlers = {};

//   bool get isConnected => appRootSocket?.connected == true;

//   void initializeSocket() {
//     if (appRootSocket != null) return;

//     _connectSocketToServer();
//   }

//   void readEvent({
//     required String event,
//     required void Function(dynamic) handler,
//   }) {
//     try {
//       // Store the handler for reconnection scenarios
//       if (!_eventHandlers.containsKey(event)) {
//         _eventHandlers[event] = [];
//       }
//       _eventHandlers[event]!.add(handler);

//       // If already connected, setup the listener immediately
//       if (isConnected) {
//         _setupEventListener(event, handler);
//       } else {
//         // If not connected, initialize the connection
//         initializeSocket();
//       }
//     } catch (e, stackTrace) {
//       AppPrint.appError("readEvent ($event)$e $stackTrace");
//     }
//   }

//   void removeEvent(String event) {
//     try {
//       // Remove the event listener from socket
//       appRootSocket?.off(event);

//       // Remove from stored handlers
//       _eventHandlers.remove(event);

//       AppPrint.appLog("Removed event listener: $event");
//     } catch (e, stackTrace) {
//       AppPrint.appError("removeEvent ($event) $e $stackTrace");
//     }
//   }

//   void _setupEventListener(String event, void Function(dynamic) handler) {
//     appRootSocket?.off(event); // Remove existing listeners to avoid duplicates
//     appRootSocket?.on(event, (data) {
//       AppPrint.appLog("Received event: $event ");
//       AppPrint.appLog("with data: $data");
//       handler(data);
//     });
//   }

//   void emitEvent(String event, dynamic data) {
//     try {
//       if (isConnected) {
//         appRootSocket?.emit(event, data);
//       } else {
//         // Queue the emit for when connection is established
//         initializeSocket();
//         _onceConnected(() {
//           appRootSocket?.emit(event, data);
//         });
//       }
//     } catch (e, stackTrace) {
//       AppPrint.appError("emitEvent ($event) $e $stackTrace");
//     }
//   }

//   void _onceConnected(void Function() callback) {
//     if (isConnected) {
//       callback();
//       return;
//     }

//     void listener(dynamic listener) {
//       try {
//         callback();
//         appRootSocket?.off('connect', listener);
//       } catch (e) {
//         AppPrint.appError("listener $e");
//       }
//     }

//     appRootSocket?.on('connect', listener);
//   }

//   void _connectSocketToServer() {
//     try {
//       if (appRootSocket != null || _isConnecting) return;

//       _isConnecting = true;
//       AppPrint.appLog("Attempting to connect socket...");

//       appRootSocket = io.io(
//         AppApiEndPoint.domain,
//         // "${AppApiEndPoint.domain}?userId=${getStorageServices.getUID()}",
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .disableAutoConnect()
//             .setExtraHeaders({
//               'foo': 'bar',
//               "Authorization": "Bearer ${getStorageServices.getToken()}",
//             })
//             .enableReconnection()
//             .build(),
//       );

//       // Setup connection listeners
//       appRootSocket?.onConnect((_) {
//         _isConnecting = false;
//         AppPrint.appLog("Socket connected");

//         // Re-establish all event listeners using for loops
//         for (final entry in _eventHandlers.entries) {
//           final event = entry.key;
//           final handlers = entry.value;
//           for (final handler in handlers) {
//             _setupEventListener(event, handler);
//           }
//         }
//       });

//       appRootSocket?.onDisconnect((_) {
//         AppPrint.appError("Socket disconnected");
//         _isConnecting = false;
//       });

//       appRootSocket?.onConnectError((data) {
//         AppPrint.appError("Connect error $data");
//         _isConnecting = false;
//       });

//       appRootSocket?.onError((data) {
//         AppPrint.appError("Error $data");
//         _isConnecting = false;
//       });

//       appRootSocket?.onReconnect((_) {
//         AppPrint.appLog("Socket reconnected");
//       });

//       // Start the connection
//       appRootSocket?.connect();
//     } catch (e, stackTrace) {
//       _isConnecting = false;
//       AppPrint.appError("_connectSocketToServer $e $stackTrace");
//     }
//   }

//   void reconnect() {
//     if (!isConnected && !_isConnecting) {
//       _connectSocketToServer();
//     }
//   }

//   void dispose() {
//     if (appRootSocket != null) {
//       appRootSocket?.disconnect();
//       appRootSocket?.dispose();
//       appRootSocket = null;
//     }
//     _eventHandlers.clear();
//     _isConnecting = false;
//   }
// }
