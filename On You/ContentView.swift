//
//  ContentView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        ZStack {
            if self.settings.view == false {
                Main()
            } else {
                GameView()
            }
        }.environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    @EnvironmentObject var settings: GameSettings
    static var previews: some View {
        ContentView().environmentObject(GameSettings())
    }
}
