//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Kostin on 2021-06-04.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    var animationAmount: Double
    var opactiyAmount: Double
    var flameSize: CGFloat
    
    var body: some View {
        ZStack {
            Image(imageName)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
                .opacity(opactiyAmount)
                .rotation3DEffect(
                    .degrees(animationAmount),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            HStack {
                Text("🔥")
                Text("🔥")
            }
            .font(.system(size: flameSize))
            .opacity(flameSize == 0.0 ? 0.0 : 1.0)
        }
    }
}

struct ContentView: View {
    @State private var  countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rotationAmounts = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var flameSize: [CGFloat] = [0.0, 0.0, 0.0]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of: ")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                VStack {
                    ForEach(0..<3){ number in
                        Button(action: {
                            withAnimation(.default) {
                                flagTapped(number)
                            }
                        }) {
                            FlagImage(imageName: countries[number], animationAmount: rotationAmounts[number], opactiyAmount: opacityAmount[number], flameSize: flameSize[number])
                        }
                    }
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)."), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            rotationAmounts[number] += 360
        } else {
            flameSize[number] = 60
            scoreTitle = "Wrong! \n You selected the flag of \(countries[number])."
        }
        // Change the opacity of the non selected flags
        for i in 0...2 {
            if i != number {
                opacityAmount[i] = 0.25
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // Reset opacity back to full
        opacityAmount = [1.0, 1.0, 1.0]
        flameSize = [0.0, 0.0, 0.0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
