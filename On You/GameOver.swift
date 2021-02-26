//
//  GameOver.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/25.
//

import SwiftUI

struct GameOver: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            VStack {
                Image(systemName: "banknote").resizable().frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.green).padding().padding(.bottom).padding(.top)
                Text("The target was: ").font(.system(size: 30))
                Text("$\(self.settings.totalPrice)").padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
                Text("You reached: ").font(.system(size: 30))
                Text("$\(self.settings.result)").padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
                Text("Difference: ").font(.system(size: 20))
                Text("\(self.settings.difference)").padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 120, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
                Spacer()
                Button(action: {
                    self.settings.clearGame()
                }) {
                    Text("Cancel Game").foregroundColor(Color.Neumorphic.secondary)
                }.frame(width: 300, height: 50, alignment:.center ).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
            }
        }.environmentObject(GameSettings()).environmentObject(GameSocketModel())
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver().environmentObject(GameSettings())
    }
}
