//
//  HangmanGame.swift
//  Hangman
//
//  Created by RJ Pimentel on 9/25/17.
//  Copyright © 2017 iOS DeCal. All rights reserved.
//

import Foundation
class HangmanGame {
    let phrases: HangmanPhrases
    let word: String
    var guessedLetters: [Character] = []
    var guessesLeft = 6
    var lettersLeft: Int

    init() {
        phrases = HangmanPhrases()
        word = phrases.getRandomPhrase()
        var uniqueLetters: [Character] = []
        for c in word {
            if c != " " && !(uniqueLetters.contains(c)) {
                uniqueLetters.append(c)
            }
        }
        lettersLeft = uniqueLetters.count
    }
    
    
    
    func makeGuess(letter: Character) -> Bool? {
        if guessedLetters.contains(letter) {
            return nil
        }
        
        guessedLetters.append(letter)
        if !word.contains(letter) {
            guessesLeft -= 1
            return false
        }
        
        lettersLeft -= 1
        return true
    }
}
