//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Peter Kostin on 2021-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var onMenu = true
    
    // Game settings
    @State private var uptoTable = 7
    @State private var numQuestionsList = [5, 10, 20, 99] // 99 = all
    @State private var numQuestionsIndex = 0
    
    var numQuestions: Int {
        if numQuestionsIndex == (numQuestionsList.count - 1) {
            return uptoTable * uptoTable
        } else {
            return numQuestionsList[numQuestionsIndex]
        }
    }
    
    // [[x, y, x*y]]
    @State private var questionList: [[Int]] = [[]]
    
    // game variables
    @State private var score = 0
    @State private var answer = ""
    @State private var questionIndex = 0
    @State private var gameOver = false

    
    
    var body: some View {
        // These should be seperate view files, but I haven't learned how to manage passing variables between them yet.
        if onMenu {
            NavigationView {
                Form {
                    Section(header: Text("Multiplication table up to")) {
                        Stepper(value: $uptoTable, in: 1...12) {
                            Text("\(uptoTable)x\(uptoTable)")
                        }
                    }
                    Section(header: Text("Number of questions")) {
                        Picker("", selection: $numQuestionsIndex) {
                            ForEach (0 ..< numQuestionsList.count) {
                                Text("\(numQuestionsList[$0] == 99 ? "ALL" : String(numQuestionsList[$0]))")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section {
                        Button(action: startGame) {
                            Text("Start game")
                        }
                    }
                }
                .navigationBarTitle(Text("Multiplication Tables"))
            }
        } else {
            NavigationView {
                Form {
                    Section(header: Text("Question #\(questionIndex + 1)")) {
                        HStack {
                            Spacer()
                            Text("\(questionList[questionIndex][0]) x \(questionList[questionIndex][1])")
                                .font(.largeTitle.weight(.semibold))
                            Spacer()
                        }
                    }
                    Section {
                        TextField("Answer", text: $answer, onCommit: checkAnswer)
                            .keyboardType(.numberPad)
                    }
                }
                .navigationBarTitle(Text("Score \(score)"))
                .alert(isPresented: $gameOver, content: {
                    Alert(
                        title: Text("Game Over!"),
                        message: Text("You got \(score)/\(numQuestions) correct!"),
                        primaryButton: .default(Text("Back to Menu")) {
                            onMenu = true
                        },
                        secondaryButton: .cancel(Text("Play Again")) {
                            startGame()
                        }
                    )
                })
            }
        }
    }
    
    func checkAnswer() {
        let intAnswer = Int(answer) ?? 9999
        if intAnswer == questionList[questionIndex][2] {
            score += 1
        }
        
        if questionIndex+1 == numQuestions {
            gameOver = true
        } else {
            questionIndex += 1
        }
        answer = ""
    }
    
    func generateQuestions() {
        questionList.removeAll()
        for _ in 1...numQuestions {
            let x = Int.random(in: 0...uptoTable)
            let y = Int.random(in: 0...uptoTable)
            let result = x * y
            questionList.append([x,y,result])
        }
    }
    
    func startGame() {
        questionIndex = 0
        score = 0
        onMenu = false
        gameOver = false
        generateQuestions()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
