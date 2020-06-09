//
//  ContentView.swift
//  Bullseye
//
//  Created by Jonathan Deleon on 6/5/20.
//  Copyright © 2020 Jonathan Deleon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var random: Int = Int.random(in: 1...100)
    @State var roundScore: Int = 0
    @State var roundNum: Int = 1

    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(shadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
   
    struct numberStyle: ViewModifier {
           func body(content: Content) -> some View {
               return content
                    .foregroundColor(Color.yellow)
                    .modifier(shadowStyle())
                    .font(Font.custom("Arial Rounded MT Bold", size: 24))
           }
       }

    struct shadowStyle: ViewModifier {
          func body(content: Content) -> some View {
              return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
          }
      }
    
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .background(Image("Button"))
                .modifier(shadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))

        }
    }
    
    struct SmallerButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .background(Image("Button"))
                .modifier(shadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 12))

        }
    }

    var body: some View {
        
        VStack {
            Spacer()
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(self.random)").modifier(numberStyle())
                
            }
            Spacer()
            
            // Slider Row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            // Button Row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                let roundedValue: Int = sliderValueRounder()
                    return Alert(
                        title: Text("\(self.setTitle())"),
                        message: Text("This slider's value is \(roundedValue).\n" +
                            "You scored \(self.pointsForCurrentRound()) points this round"
                        ),
                        dismissButton: .default(Text("Awesome")) {
                            self.roundScore = self.setRoundPoints()
                            self.random = self.getRandomNum()
                            self.roundNum = self.newRound()
                        })
            }
            .modifier(ButtonStyle())
            Spacer()
            
            // Score Row
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over")
                    }
                }
                .modifier(SmallerButtonStyle())
                Spacer()
                
                Text("Score:").modifier(LabelStyle())
                Text("\(self.roundScore)").modifier(numberStyle())
                Spacer()
                
                Text("Round:").modifier(LabelStyle())
                Text("\(self.roundNum)").modifier(numberStyle())
                Spacer()
                
                NavigationLink (destination:AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                }
                .modifier(SmallerButtonStyle())
            }
            .padding(.bottom, 20)
            
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("Bullseye")
    }
    
    func newRound() -> Int {
        self.roundNum + 1
    }
    
    func getRandomNum() -> Int {
        Int.random(in: 1...100)
    }
    
    func setRoundPoints() -> Int {
        
        return self.roundScore + pointsForCurrentRound()
    }
    
    func amountOff() -> Int {
        abs(self.random - sliderValueRounder())
    }
    
    func sliderValueRounder() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        var extraPoints: Int
        let currPoints: Int = 100 - self.amountOff()
        
        if currPoints == 100 {
            extraPoints = 100
        } else if currPoints == 99 {
            extraPoints = 50
        } else {
            extraPoints = 0
        }
        
        return currPoints + extraPoints
        
    }
    
    func setTitle() -> String {
        let difference: Int = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect Job!"
        } else if difference < 10 {
            title = "Soo Close"
        } else if difference < 20 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func resetGame() {
        roundNum = 1
        roundScore = 0
        sliderValue = 50
        random = self.getRandomNum()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(
                .fixed(
                    width: 896,
                    height: 414
                )
            )
    }
}
