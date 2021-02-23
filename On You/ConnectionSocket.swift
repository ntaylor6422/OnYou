//
//  ConnectionSocket.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/23.
//

import Combine
import Foundation


final class GameSocketModel: ObservableObject {
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connect() {
        let url = URL(string: "ws://127.0.0.1:8080/chat")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive)
        webSocketTask?.resume()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        
    }
    
    deinit {
        disconnect()
    }
    
}
