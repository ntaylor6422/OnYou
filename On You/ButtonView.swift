//
//  ButtonView.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/23.
//

import SwiftUI

extension Color {
  static let defaultBlue = Color(red: 0, green: 97 / 255.0, blue: 205 / 255.0)
  static let paleBlue = Color(red: 188 / 255.0, green: 224 / 255.0, blue: 253 / 255.0)
  static let paleWhite = Color(white: 1, opacity: 179 / 255.0)
}

struct MyButtonStyle: ButtonStyle {
    var isEnabled: Bool
  func makeBody(configuration: Self.Configuration) -> some View {
    MyButtonStyleView(isEnabled: isEnabled, configuration: configuration)
  }
}

private extension MyButtonStyle {
  struct MyButtonStyleView: View {
    var isEnabled:Bool
    // tracks if the button is enabled or not
    // tracks the pressed state
    let configuration: MyButtonStyle.Configuration

    var body: some View {
      return configuration.label
        .foregroundColor(isEnabled ? .white : .paleWhite)
        .background(RoundedRectangle(cornerRadius: 5)
          .fill(isEnabled ? Color.defaultBlue : Color.paleBlue)
        )
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
  }
}

struct ButtonView: View {
    @State var isEnabled:Bool = true
    var body: some View {
        Button(action: {
            print("Hello World")
            isEnabled = true
        })
        {
            Text("This is a button!").padding()
        }.buttonStyle(MyButtonStyle(isEnabled: isEnabled))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
