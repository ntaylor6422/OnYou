//
//  ContentView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    
    private func createMatrix(price: String, rows: Int) -> [[Int]] {
        let toDouble = Double(price)!
        let rdDown = Int(floor(toDouble)) / 2
        var arr:[[Int]] = []
        
        for _ in 0...rows {
            var tempArr:[Int] = []
            for _ in 0...rows {
                let random = Int.random(in: 0..<rdDown)
                tempArr.append(random)
            }
            arr.append(tempArr)
        }

        return arr
    }
    
    private func handleClick() -> Int {
        return 3
    }
    
    private func individualCell(value: Int) -> some View {
        return Button(action: {
            print(self.handleClick())
        }, label: {
            Text("\(value)")
        })
    }
    
    private func makeRow(cols: [Int]) -> some View {
        return HStack {
            ForEach(cols, id:\.self) { col in
                individualCell(value: col)
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            ForEach(self.createMatrix(price: "37.99", rows: 5), id:\.self) { row in self.makeRow(cols: row)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
