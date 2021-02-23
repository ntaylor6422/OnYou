//
//  MainView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

struct Main: View {
    
    @EnvironmentObject var settings: GameSettings
    
    private func startGame() -> Void {
        
    }
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("On You").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.bottom, 30)
                VStack {
                    Text("Insert Check Price")
                    TextField("Check Price", text: $settings.totalPrice).frame(width: 350, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Insert Grid Size")
                    Spacer()
                }.frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    if self.settings.totalPrice != "" {
                        self.settings.createMatrix()
                        self.startGame()
                        self.settings.view = true
                    }
                }) {
                    Text("Start Game")
                }.padding(.bottom, 10)
            }.frame(width: 350, height: 700, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.environmentObject(settings)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main().environmentObject(GameSettings())
    }
    
}
