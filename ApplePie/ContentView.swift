//
//  ContentView.swift
//  ApplePie
//
//  Created by Eduarda de Paula Paiva Pinheiro on 31/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = ApplePieGame()

    var body: some View {
        VStack {
            // Exibição da árvore com frutas restantes
          Image("Tree\(game.maxGuesses - game.incorrectGuesses)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            // Exibição da palavra com letras adivinhadas
            Text(game.displayedWord)
                .font(.largeTitle)
                .padding()

            // Botões de letras no layout QWERTY
            LetterButtonsView(game: game)

            // Mensagem de status do jogo
            if game.isGameOver {
                Text(game.isWordGuessed ? "Parabéns, você ganhou!" : "Você perdeu! A palavra era \(game.wordToGuess)")
                    .font(.callout)
                    .padding()
            }
        }
        .padding()
    }
}

struct LetterButtonsView: View {
    @ObservedObject var game: ApplePieGame

    // Layout das letras QWERTY
    private let rows: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]

    var body: some View {
        VStack(spacing: 10) {
            // Para cada linha de letras
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 5) {
                    // Para cada letra na linha
                    ForEach(row, id: \.self) { letter in
                        Button(action: {
                            game.makeGuess(letter)
                        }) {
                            Text(letter)
                                .font(.callout)
                                .padding()
                                .frame(width: 60, height: 60) // Tamanho fixo para os botões
                                .background(Color.white)
                                .foregroundColor(Color.blue)
                                .cornerRadius(5)
                        }
                        .disabled(game.guessedLetters.contains(letter) || game.isGameOver)
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
}

class ApplePieGame: ObservableObject {
    @Published var wordToGuess = "MANAUS"
    @Published var incorrectGuesses = 0
    @Published var guessedLetters: [String] = []
    let maxGuesses = 7

    var displayedWord: String {
        // Gera a palavra a ser exibida com base nas letras adivinhadas
        wordToGuess.map { guessedLetters.contains(String($0)) ? String($0) : " - " }.joined()
    }

    var isWordGuessed: Bool {
        // Converte guessedLetters em um Set de caracteres
        let guessedSet = Set(guessedLetters.map { Character($0) })
        // Verifica se todas as letras da palavra foram adivinhadas
        return Set(wordToGuess).isSubset(of: guessedSet)
    }

    var isGameOver: Bool {
        incorrectGuesses >= maxGuesses || isWordGuessed
    }

    func makeGuess(_ letter: String) {
        // Lógica para adivinhar uma letra
        if wordToGuess.contains(letter) {
        } else {
            incorrectGuesses += 1
        }
    }
}

#Preview {
    ContentView()
}
