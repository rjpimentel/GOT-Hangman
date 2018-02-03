//
//  HangmanViewController.swift
//  Hangman
//
//  Created by RJ Pimentel on 9/25/17.
//  Copyright © 2017 iOS DeCal. All rights reserved.
//

import UIKit
class HangmanViewController: UIViewController {

    var currGame: HangmanGame = HangmanGame()
    @IBOutlet weak var wordProgress: UILabel!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var currentGuessLabel: UILabel!
    
    
    var hangmanImages: [UIImage] = [UIImage(named: "h0.png")!, UIImage(named: "h1.png")!,UIImage(named: "h2.png")!,UIImage(named: "h3.png")!,UIImage(named: "h4.png")!,UIImage(named: "h5.png")!,UIImage(named: "h6.png")!]
    var nextImageInt = 1
    var currentGuess = ""

    
    @IBAction func keyPressed(_ sender: UIButton) {
        currentGuess = sender.currentTitle!
        currentGuessLabel.text = currentGuess
    }
    
    
    @IBAction func makeGuess(_ sender: UIButton) {
        if currentGuessLabel.text == "Current Guess" {
            return
        }
        
        if let correct = currGame.makeGuess(letter: Character(currentGuess)) {
            if correct {
                updateProgress()
                if currGame.lettersLeft == 0 {
                    let winAlertController = UIAlertController(title: "You win!", message: "", preferredStyle: .alert)
                    let winAction = UIAlertAction(title: "Play again?", style: .default) { (action:UIAlertAction) in
                        self.resetGame();
                    }
                    winAlertController.addAction(winAction)
                    self.present(winAlertController, animated: true, completion: nil)
                }
            } else {
                updateHangmanImage()
                guessesLabel.text! += " " + currentGuess
                if currGame.guessesLeft == 0 {
                    let loseAlertController = UIAlertController(title: "You lose!", message: "Answer: " + currGame.word, preferredStyle: .alert)
                    let loseAction = UIAlertAction(title: "Play again?", style: .default) { (action:UIAlertAction) in
                        self.resetGame();
                    }
                    loseAlertController.addAction(loseAction)
                    self.present(loseAlertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateHangmanImage() {
        hangmanImageView.image = hangmanImages[nextImageInt]
        nextImageInt += 1
    }
    
    func updateProgress() {
        var newProgress = ""
        for c in currGame.word {
            if c == " " {
                newProgress += "  "
            } else if currGame.guessedLetters.contains(c) {
                newProgress += String(c)
            } else {
                newProgress += "_ "
            }
        }
        wordProgress.text! = newProgress
    }

    func resetGame() {
        currGame = HangmanGame()
        updateProgress()
        guessesLabel.text = "Incorrect:"
        currentGuess = ""
        currentGuessLabel.text = currentGuess
        nextImageInt = 0
        updateHangmanImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgress()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? EndgameViewController {
            dest.correctSolution = currGame.word
        }
        
        
        
    }
    */

}
