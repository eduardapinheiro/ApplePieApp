//
//  ApplePieTests.swift
//  ApplePieTests
//
//  Created by Eduarda de Paula Paiva Pinheiro on 31/08/24.
//

import XCTest
@testable import ApplePie

class Apple_PieTests: XCTestCase {
    class ApplePieTests: XCTestCase {
        var game: ApplePieGame!
        override func setUp() {
            super.setUp()
            // Inicializa o jogo antes de cada teste
            game = ApplePieGame()
        }
        
        override func tearDown() {
            // Limpa o jogo após cada teste
            game = nil
            super.tearDown()
        }
        
        func testInitialGameState() {
            // Verifica o estado inicial do jogo
            XCTAssertEqual(game.incorrectGuesses, 0, "O número de tentativas incorretas deve ser 0 no início do jogo.")
            XCTAssertEqual(game.guessedLetters, [], "Nenhuma letra deve ser adivinhada no início do jogo.")
            XCTAssertFalse(game.isGameOver, "O jogo não deve estar terminado no início.")
        }
        
        func testCorrectGuess() {
            // Testa adivinhar uma letra correta
            game.wordToGuess = "EXAMPLE"
            game.makeGuess("E")
            
            XCTAssertTrue(game.guessedLetters.contains("E"), "A letra 'E' deve estar na lista de letras adivinhadas.")
            XCTAssertEqual(game.incorrectGuesses, 0, "Nenhuma tentativa incorreta deve ser registrada ao adivinhar corretamente.")
        }
        
        func testIncorrectGuess() {
            // Testa adivinhar uma letra incorreta
            game.wordToGuess = "EXAMPLE"
            game.makeGuess("Z")
            
            XCTAssertFalse(game.guessedLetters.contains("Z"), "A letra 'Z' não deve estar na lista de letras adivinhadas.")
            XCTAssertEqual(game.incorrectGuesses, 1, "Uma tentativa incorreta deve ser registrada ao adivinhar incorretamente.")
        }
        
        func testGameOverAfterMaxIncorrectGuesses() {
            // Testa o fim do jogo após o número máximo de tentativas incorretas
            game.wordToGuess = "EXAMPLE"
            game.incorrectGuesses = game.maxGuesses
            
            XCTAssertTrue(game.isGameOver, "O jogo deve estar terminado após o número máximo de tentativas incorretas.")
        }
        
        func testWinningGame() {
            // Testa ganhar o jogo
            game.wordToGuess = "EXAMPLE"
            game.makeGuess("E")
            game.makeGuess("X")
            game.makeGuess("A")
            game.makeGuess("M")
            game.makeGuess("P")
            game.makeGuess("L")
            game.makeGuess("E")
            
            XCTAssertTrue(game.isWordGuessed, "O jogo deve ser vencido quando todas as letras são adivinhadas.")
            XCTAssertTrue(game.isGameOver, "O jogo deve estar terminado após a vitória.")
        }
    }
}
