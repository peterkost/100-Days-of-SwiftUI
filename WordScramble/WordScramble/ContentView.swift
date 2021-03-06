//
//  ContentView.swift
//  WordScramble
//
//  Created by Peter Kostin on 2021-06-05.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                GeometryReader { listGeo in
                    List(0..<usedWords.count, id: \.self) { i in
                        GeometryReader { itemGeo in
                            HStack {
                                Image(systemName: "\(usedWords[i].count).circle")
                                Text(usedWords[i])
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(usedWords[i]), \(usedWords[i].count) letters"))
                            .frame(width: itemGeo.size.width, alignment: .leading)
                            .offset(x: getOffset(listGeo: listGeo, itemGeo: itemGeo), y: 0)
                            .foregroundColor(getColor(listGeo: listGeo, itemGeo: itemGeo))
                        }

                    }
                }
                Text("Score: \(score)")
                    .font(.title)
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(trailing: Button(action: startGame) {
                        Text("New Word")
                }
                )

        }
    }
    
    func getOffset(listGeo: GeometryProxy, itemGeo: GeometryProxy) -> CGFloat {
        let listHeight = listGeo.size.height
        let listStart = listGeo.frame(in: .global).minY
        let itemStart = itemGeo.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        let thresholdPercent: CGFloat = 60
        let indent: CGFloat = 9

        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }

        return 0
    }
    
    func getColor(listGeo: GeometryProxy, itemGeo: GeometryProxy) -> Color {
        let listHeight = listGeo.size.height
        let listStart = listGeo.frame(in: .global).minY
        let itemStart = itemGeo.frame(in: .global).minY

        let itemPercent = (itemStart - listStart) / listHeight * 100
        let colorValue = Double(itemPercent / 100)
        
        return Color(red: 2 * colorValue, green: 2 * (1 - colorValue), blue: 0)
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "Think of a word longer then 2 letters.")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Word is root", message: "You can't just use the root word!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }
    
    func startGame() {
        if let startNewWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startNewWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from app bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
