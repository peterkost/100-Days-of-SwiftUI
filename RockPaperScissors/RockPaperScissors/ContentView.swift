//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Peter Kostin on 2021-06-05.
//

import SwiftUI

struct MoveImage: View {
    var moveContent: String
    
    var body: some View {
        ZStack {
            Color.blue
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(moveContent)
                .font(Font.system(size: 100))
        }
    }
}

struct ContentView: View {
    
    private let moves: [String] = ["🪨", "📄", "✂️"]
    
    @State private var computerChoiseIndex = Int.random(in: 0...2)
    @State private var userMustWin = Bool.random()
    @State private var userScore = 0
    @State private var moveNumber = 1
    @State private var gameOver = false
    
    var body: some View {
        VStack {
            Text("Score: \(userScore)")
            Text("Computer Chose: \(moves[computerChoiseIndex])")
            Text("Pick the move to \(userMustWin ? "win" : "lose").")
            ForEach(0..<moves.count) { i in
                Button(action: {
                    moveSelected(i)
                }) {
                    MoveImage(moveContent: moves[i])
                }
            }
        }
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Game Over!"), message: Text("Your final score was \(userScore)."), dismissButton: .default(Text("New Game")) {
                computerChoiseIndex = Int.random(in: 0...2)
                userMustWin = Bool.random()
                userScore = 0
                moveNumber = 1
            })
        })
    }
    
    func moveSelected(_ move: Int) {
        enum results {
            case win, lose, draw
        }
        var playerResult: results
        // I know you can use math to calculate the result, but I'm bad at math and couldn't get it to work correctly.
        if move == computerChoiseIndex {
            playerResult = results.draw
        } else if (move == 1 && computerChoiseIndex == 0) {
            playerResult = results.win
        } else if (move == 2 && computerChoiseIndex == 1) {
            playerResult = results.win
        } else if (move == 0 && computerChoiseIndex == 2) {
            playerResult = results.win
        } else {
            playerResult = results.lose
        }
        
        if (userMustWin && playerResult == results.win) || (!userMustWin && playerResult == results.lose){
            userScore += 1
        } else {
            userScore -= 1
        }
        computerChoiseIndex = Int.random(in: 0...2)
        userMustWin = Bool.random()
        moveNumber += 1
        if moveNumber == 11 {
            gameOver = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
