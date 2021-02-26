//
//  ButtonView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/23.
//

import SwiftUI
import Neumorphic

extension Color {
    static let neuBackground = Color(hex: "f0f0f3")
    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
    static let dropLight = Color(hex: "ffffff")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

struct MyButtonStyle: ButtonStyle {
    @EnvironmentObject var settings: GameSettings
    var position: [Int]
    var isEnabled:Bool
  func makeBody(configuration: Self.Configuration) -> some View {
    MyButtonStyleView(position:position, isEnabled: isEnabled,configuration: configuration).environmentObject(GameSettings())
  }
}


private extension MyButtonStyle {
  struct MyButtonStyleView: View {
    var position:[Int]
    var isEnabled:Bool
    // tracks if the button is enabled or not
    // tracks the pressed state
    let configuration: MyButtonStyle.Configuration
    

    var body: some View {
            return configuration.label
              .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.primary)
              /*.background(
                  RoundedRectangle(cornerRadius: 10)
                      .fill(Color.Neumorphic.main).softOuterShadow())
              .opacity(configuration.isPressed ? 0.8 : 1.0)
              .scaleEffect(configuration.isPressed ? 0.98 : 1.0).environmentObject(GameSettings())*/
    }
  }
}

struct ButtonView: View {
    @EnvironmentObject var settings: GameSettings
    @State var num: Int
    @State var position:[Int]
    @State var isEnabled:Bool
    
    var body: some View {
        Button(action: {
            self.settings.selectedNum = num
            self.settings.setSelectedPosition(position: position)
            self.settings.calculate()
        })
        {
            Text("\(num)").font(.system(size: 20)).frame(width: 40, height: 40, alignment:/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(!self.settings.boolMatrix[position[0]][position[1]] ? Color.Neumorphic.secondary : Color.Neumorphic.main)
        }.frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 20).fill(!self.settings.boolMatrix[position[0]][position[1]] ? Color.Neumorphic.main : Color.Neumorphic.secondary).softOuterShadow()).disabled(self.settings.boolMatrix[position[0]][position[1]])
        
        /*.softButtonStyle(RoundedRectangle(cornerRadius: 20), mainColor: isEnabled ? Color.Neumorphic.main : Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), textColor: isEnabled ? Color.Neumorphic.secondary : .white ,pressedEffect: .hard)*/
        
        
        /*.buttonStyle(MyButtonStyle(position: position, isEnabled: isEnabled)).padding(.horizontal, 10).padding(.bottom, 10).disabled(self.settings.boolMatrix[position[0]][position[1]]).softButtonStyle(Capsule(), pressedEffect: .flat).environmentObject(GameSettings())*/
    }
}

struct ButtonView_Previews: PreviewProvider {
    @EnvironmentObject var settings: GameSettings
    static var previews: some View {
        ButtonView(num: 5, position: [0,0], isEnabled: true)
            .environmentObject(GameSettings())
    }
}
