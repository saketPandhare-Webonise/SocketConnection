//
//  MySocket.swift
//  SocketManager

import Foundation
import SocketIO
import Starscream


protocol SocketConnectionDelegate {
    func didReceiveMessage(socket: WebSocketClient, text: String)
    func didReciveData(socket: WebSocketClient, data: Data)
}

class MySocket: NSObject, WebSocketDelegate {
    
    var socket: WebSocket!
    var socketConnectionDelegate: SocketConnectionDelegate?
    
    func loadRequest(socketUrl: String) {
        var request = URLRequest(url: URL(string: socketUrl)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}

// MARK: Websocket Delegate Methods.
extension MySocket {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        socketConnectionDelegate?.didReceiveMessage(socket: socket, text: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        socketConnectionDelegate?.didReciveData(socket: socket, data: data)
    }
}
