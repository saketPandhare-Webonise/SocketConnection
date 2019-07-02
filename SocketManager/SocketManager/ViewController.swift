//
//  ViewController.swift
//  SocketManager

import UIKit
import Starscream

class ViewController: UIViewController, SocketConnectionDelegate {
    
    let mySocket = MySocket()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Call my socket
        mySocket.loadRequest(socketUrl: "Enter Your Socket URL here")
        mySocket.socketConnectionDelegate = self
        
    }
}

//MARK: WebSocket CustomDelegate
extension ViewController {
    
    func didReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received text Has \(text)")
        
    }
    func didReciveData(socket: WebSocketClient, data: Data) {
        print("Received Data has \(data)")
    }
}

