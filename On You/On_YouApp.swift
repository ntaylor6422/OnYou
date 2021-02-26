//
//  On_YouApp.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var gridSize = 4
    @Published var totalPrice = ""
    @Published var selectedNum:Int = 0
    @Published var result = "0"
    @Published var view:String = "Main"
    @Published var operand:String = ""
    @Published var matrix:[[Int]] = []
    @Published var difference:String = ""
    @Published var boolMatrix:[[Bool]] = [[false, true, true, true],
                                          [true, true, true, true],
                                          [true, true, true, true],
                                          [true, true, true, true]]
    
    @Published var clickedMatrix:[[Bool]] = [[false, false, false, false],
                                             [false, false, false, false],
                                             [false, false, false, false],
                                             [false, false, false, false]]
    
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
    
    func setSelectedNumber(num: Int) {
        self.selectedNum = num
    }
    
    func calculate() {
        var result = Int(self.result)!
        
        if self.operand == "+" {
            result += self.selectedNum
        } else if self.operand == "-" {
           result -= self.selectedNum
        } else if self.operand == "*" {
            result *= self.selectedNum
        } else {
            result /= self.selectedNum
        }
        
        self.selectedNum = 0
        self.operand = ""
        let calculatedDifference = fabs(Double(self.totalPrice)! - Double(result))
        self.difference = String(format: "%.2f", calculatedDifference)
        self.result = "\(result)"
    }
    
    func setSelectedPosition(position: [Int]) {
        self.clickedMatrix[position[0]][position[1]] = true
        
        if position == [3, 3] {
            return self.gameOver()
        }
        
        self.boolMatrix = [[true, true, true, true],
                           [true, true, true, true],
                           [true, true, true, true],
                           [true, true, true, true]]
        self.toggleButtons(position: position)
    }
    
    func toggleButtons(position: [Int]) {
        
        let y = position[0]
        let x = position[1]
        
        
        let positions = [[y, x + 1],[y, x - 1],[y + 1, x], [y - 1, x]]
        
        for i in 0..<4 {
            let current = positions[i]
            if current[0] <= 3 && current[0] >= 0 && current[1] <= 3 && current[1] >= 0 && !self.clickedMatrix[current[0]][current[1]] {
                self.boolMatrix[current[0]][current[1]] = false
            }
        }
    }
    
    func gameOver() {
        self.view = "GameOver"
    }
    
    func clearGame() -> Void {
        self.view = "Main"
        self.totalPrice = ""
        self.result = "0"
        self.boolMatrix = [[false, true, true, true],
                           [true, true, true, true],
                           [true, true, true, true],
                           [true, true, true, true]]
        
        self.clickedMatrix = [[false, false, false, false],
                              [false, false, false, false],
                              [false, false, false, false],
                              [false, false, false, false]]
    }
    
}

@main
struct On_YouApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameSettings()).environmentObject(GameSocketModel())
        }
    }
}
