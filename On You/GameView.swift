//
//  GameView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/23.
//

import SwiftUI
import Neumorphic

struct GameView: View {
    
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var model: GameSocketModel
    
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
        self.settings.operand = op
    }
    
    private func individualCell(value: Int, matrix: [Int]) -> some View {
        return ButtonView(num: value, position: matrix, isEnabled: self.settings.boolMatrix[matrix[0]][matrix[1]])
            
            /*Button(action: {
            self.handleClick(number: value)
        }, label: {
            Text("\(value)").font(.title2)
        }).frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()*/
    }
    
    private func opCell(operand: String) -> some View {
        return Button(action: {
            self.opClick(op: operand)
        }, label: {
            Image(systemName: "plus.square")
        }).frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
    }
    
    private func makeNumRow(cols: [Int], index: Int) -> some View {
        return HStack {
            ForEach(cols.indices) { n in
                individualCell(value: cols[n], matrix: [index, n])
            }
        }.padding()
    }
    
    private func makeOpRow(cols: [String]) -> some View {
        return HStack {
            ForEach(cols, id:\.self) { col in
                opCell(operand: col)
            }
        }
    }
    
    private func calculate(operand: String) -> Void {
        var currentResult = Int(self.settings.result)!
        let currentNumber = self.settings.selectedNum

            if operand == "+" {
                currentResult += currentNumber
            } else if operand == "-" {
               currentResult -= currentNumber
            } else if operand == "*" {
                currentResult *= currentNumber
            } else {
                currentResult /= currentNumber
            }
        
        self.settings.selectedNum = 0
        self.settings.result = "\(currentResult)"
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
            Color.Neumorphic.main.ignoresSafeArea()
            VStack {
                Text("$\(self.settings.result)").padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
                HStack {
                    Button(action: {self.opClick(op: "+")}) {
                        Image(systemName: "plus.square").font(.system(size: 40)).foregroundColor(Color.Neumorphic.secondary).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
                    }
                    Button(action: {self.opClick(op: "-")}) {
                        Image(systemName: "minus.square").font(.system(size: 40)).foregroundColor(Color.Neumorphic.secondary).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding(.trailing)
                    Button(action: {self.opClick(op: "*")}) {
                        Image(systemName: "multiply.square").font(.system(size: 40)).foregroundColor(Color.Neumorphic.secondary).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding(.trailing)
                    Button(action: {self.opClick(op: "/")}) {
                        Image(systemName: "divide.square").font(.system(size: 40)).foregroundColor(Color.Neumorphic.secondary).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow())
                    }
                }.frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.largeTitle)
                Spacer()
                ForEach(self.model.matrix.indices, id:\.self) { i in self.makeNumRow(cols: self.model.matrix[i], index: i)
                    
                }
                Spacer()
                Button(action: {
                    self.settings.clearGame()
                }) {
                    Text("Cancel Game").foregroundColor(Color.Neumorphic.secondary)
                }.frame(width: 300, height: 50, alignment:.center ).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
            }
        }.environmentObject(settings).environmentObject(model)
    }
}

struct GameView_Previews: PreviewProvider {
    @EnvironmentObject var settings: GameSettings
    static var previews: some View {
        GameView().environmentObject(GameSettings()).environmentObject(GameSocketModel())
    }
}
