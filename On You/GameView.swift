//
//  GameView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/23.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var settings: GameSettings
    @StateObject private var model = GameSocketModel()
    
    private let operands:[String] = ["+", "-", "x", "/"]
    @State private var selectedOpperand:String = ""
    @State private var selectedNumber:Int = 0
    @State private var displayedNumber:String = "0"
    
    private func onAppear() {
        model.connect()
    }
    
    private func onDisappear() {
        model.disconnect()
    }
    
    private func handleClick(number: Int) -> Void {
        selectedNumber = number
    }
    
    private func opClick(op: String) -> Void {
        self.calculate(operand: op)
    }
    
    private func individualCell(value: Int) -> some View {
        return Button(action: {
            self.handleClick(number: value)
        }, label: {
            Text("\(value)").font(.title2)
        }).frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
    }
    
    private func opCell(operand: String) -> some View {
        return Button(action: {
            self.opClick(op: operand)
        }, label: {
            Image(systemName: "plus.square")
        }).frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
    }
    
    private func makeNumRow(cols: [Int]) -> some View {
        return HStack {
            ForEach(cols, id:\.self) { col in
                individualCell(value: col)
            }
        }
    }
    
    private func makeOpRow(cols: [String]) -> some View {
        return HStack {
            ForEach(cols, id:\.self) { col in
                opCell(operand: col)
            }
        }
    }
    
    private func calculate(operand: String) -> Void {
            var result  = 0
        let currentNum = Int(displayedNumber)!
        

            if operand == "+" {
                result = currentNum + selectedNumber
            } else if operand == "-" {
                result = currentNum - selectedNumber
            } else if operand == "*" {
                result = currentNum * selectedNumber
            } else {
                result = currentNum / selectedNumber
            }

            displayedNumber = "\(result)"
    }
    
    struct GradientButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(Color.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15.0)
        }
    }
    

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("\(displayedNumber)").padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                HStack {
                    Button(action: {self.opClick(op: "+")}) {
                        Image(systemName: "plus.square")
                    }.padding(.trailing)
                    Button(action: {self.opClick(op: "-")}) {
                        Image(systemName: "minus.square")
                    }.padding(.trailing)
                    Button(action: {self.opClick(op: "*")}) {
                        Image(systemName: "multiply.square")
                    }.padding(.trailing)
                    Button(action: {self.opClick(op: "/")}) {
                        Image(systemName: "divide.square")
                    }
                }.frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.largeTitle)
               ForEach(self.settings.matrix, id:\.self) { row in self.makeNumRow(cols: row)
                    
                }.padding()
                Button(action: {
                    self.settings.clearGame()
                }) {
                        Text("Cancel Game")
                }.buttonStyle(GradientButtonStyle())
            }
        }.environmentObject(settings)
    }
}

struct GameView_Previews: PreviewProvider {
    @EnvironmentObject var settings: GameSettings
    static var previews: some View {
        GameView().environmentObject(GameSettings())
    }
}
