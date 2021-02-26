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
    @Published private(set) var messages: [ReceivingScores] = []
    @Published private(set) var matrix: [[Int]] = []
    
    func connect() {
        let url = URL(string: "ws://127.0.0.1:8080/game")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive)
        webSocketTask?.resume()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive)
        
        if case .success(let message) = incoming {
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming {
            print("Error", error)
        }
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) {
        if case .string(let text) = message {
            guard let data = text.data(using: .utf8),
                  let chatMessage = try? JSONDecoder().decode(ReceivingScores.self, from: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.messages.append(chatMessage)
                self.matrix = chatMessage.matrix
            }
        }
    }
    
    func send(total: String) {
        let score = SubmittedStartGame(total: total)
        guard let json = try? JSONEncoder().encode(score), let jsonString = String(data: json, encoding: .utf8)
        else {
            return
        }
        webSocketTask?.send(.string(jsonString)) { error in
            if let error = error {
                print("Error Sending Message", error)
            }
        }
    }
    
    deinit {
        disconnect()
    }
    
}
