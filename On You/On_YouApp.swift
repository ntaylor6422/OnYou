//
//  On_YouApp.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var gridSize = 5
    @Published var totalPrice = ""
    @Published var result = ""
    @Published var view:Bool = false
    @Published var matrix:[[Int]] = []
    
    func createMatrix() -> Void{
        let toDouble = Double(self.totalPrice)!
        let rdDown = Int(floor(toDouble)) / 2
        var arr:[[Int]] = []
        
        for _ in 0...self.gridSize - 1 {
            var tempArr:[Int] = []
            for _ in 0...self.gridSize - 1 {
                let random = Int.random(in: 0..<rdDown)
                tempArr.append(random)
            }
            arr.append(tempArr)
        }
        matrix = arr
    }
    
    func clearGame() -> Void {
        self.totalPrice = ""
        self.result = ""
        self.matrix = []
        self.view = false
    }
    
}

@main
struct On_YouApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
