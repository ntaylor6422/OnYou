//
//  ContentView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI
import Neumorphic

struct ContentView: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var socket: GameSocketModel

    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            if self.settings.view == "Main" {
                Main()
            } else if self.settings.view == "Game" {
                GameView()
            } else {
                GameOver()
            }
        }.environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    @EnvironmentObject var settings: GameSettings
    static var previews: some View {
        ContentView().environmentObject(GameSettings()).environmentObject(GameSocketModel())
    }
}
