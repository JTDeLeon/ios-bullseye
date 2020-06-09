//
//  AboutView.swift
//  Bullseye
//
//  Created by Jonathan Deleon on 6/7/20.
//  Copyright © 2020 Jonathan Deleon. All rights reserved.
//

import SwiftUI

struct HeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
        .foregroundColor(Color.black)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

struct TextView: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 16))
        .foregroundColor(Color.black)
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
    }
}



struct AboutView: View {
    var body: some View {
        VStack {
            Text("🎯 BULLSEYE 🎯").modifier(HeadingStyle())
            Text("This is Bullseye App, try and get the slider as close to the target number as possible and earn points!").modifier(TextView())
            Text("Enjoy!").modifier(TextView())
        }
        .background(Color.init(red: 255.0/255, green: 214.0/255, blue: 179.0/255))
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("About Bullseye")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        .previewLayout(
            .fixed(
                width: 896,
                height: 414
            )
        )
    }
}
