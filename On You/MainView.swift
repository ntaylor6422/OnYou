//
//  MainView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

struct Main: View {
    
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var socket: GameSocketModel
    
    private func startGame() -> Void {
        
    }
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            VStack {
                VStack {
                    Image(systemName: "banknote").resizable().frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.green).padding().padding(.bottom)
                    Text("On You").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.bottom, 30)
                }.frame(width: 350, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Insert Check Price").frame(width: 350, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("Check Price", text: $settings.totalPrice).font(.system(size: 30)).frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 1).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
                    
                }.frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    if self.settings.totalPrice != "" {
                        self.socket.connect()
                        self.socket.send(total: self.settings.totalPrice)
                        self.startGame()
                        self.settings.view = "Game"
                    }
                }) {
                    Text("Start Game").foregroundColor(Color.Neumorphic.secondary)
                }.frame(width: 300, height: 50, alignment:.center ).background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()).padding()
            }.frame(width: 350, height: 700, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).environmentObject(settings).environmentObject(socket)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main().environmentObject(GameSettings()).environmentObject(GameSocketModel())
    }
    
}
