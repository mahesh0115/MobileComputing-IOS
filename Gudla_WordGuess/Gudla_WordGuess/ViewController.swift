//
//  ViewController.swift
//  Gudla_WordGuess
//
//  Created by MaheshGudla on 3/7/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    
    @IBOutlet weak var totalWordsLabel: UILabel!
    
    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessLetterField: UITextField!
    
    @IBOutlet weak var guessBtn: UIButton!
    
    @IBOutlet weak var playAgainBtn: UIButton!
    
    var guess : String = ""
    var correct=false
    var wordLevel : Int = 0
    var numofWords = 0
    var remainingAttempts = 5
    var flagged = false
    var resetFlag = false
    var secretWord = ""
    var guessedCount = 0
    let maxNumOfWrongGuesses = 10
    var updatedString=""
    var guessCount=0
    var hintWord=""
    var inputString=""
    var image = [["Apple","It's a common fruit often associated with teachers and doctors", "apple"],["Banana","It's a long, curved fruit with a yellow peel","banana"],["Strawberry","It's a small, red fruit with seeds on the outside, often used in desserts.","strawberry"],["Orange","It's a citrus fruit known for its bright color and tangy flavor.","orange"],["Pineapple","It's a tropical fruit with a prickly exterior and sweet, juicy flesh.","pine"]]
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=false
        
        if(guessCount<maxNumOfWrongGuesses && remainingAttempts>0){
        
            inputString=""
            
            inputString=guessLetterField.text!
            let lastIndex = inputString.index(before: inputString.endIndex)
            let lastCharacter = inputString[lastIndex]
            //print(lastCharacter)
            
            secretWord.append(lastCharacter)
            guessCount=guessCount+1
            
            updatedString=""
            hintWord=image[wordLevel][0].uppercased()
          
            //print(word,hintword.contains(word.uppercased()),hintword)
            
            //if(hintword.contains(word.uppercased())){
                for l in hintWord {
                    if(secretWord.uppercased().contains(l.uppercased())) {
                        updatedString+="\(l.uppercased())"
                    }
                    else {
                        updatedString+="_ "
                    }
                }
                userGuessLabel.text=updatedString
            
            if( !hintWord.contains(secretWord.uppercased())){
                guessedCount=guessedCount+1
            }
            
           
            //check if the guessed word is matched with the word
            if userGuessLabel.text!.contains("_") == false{
                if(remainingAttempts>0 && wordLevel<5){
                    guessBtn.isEnabled=false
                    displayImage.isHidden=false
                    displayImage.image=UIImage(named: image[wordLevel][2])
                    
                    
                    guessCountLabel.text="Wow! You have made \(guessCount) guesses to guess the word!"
                    playAgainBtn.isHidden=false
                    playAgainBtn.isEnabled=true
                    numofWords=numofWords+1
                    remainingAttempts=remainingAttempts-1
                    wordLevel=wordLevel+1
                    guessLetterField.text=""
                    
                    wordsGuessedLabel.text="Total number of words guessed successfully: \(numofWords)"
                    wordsRemainingLabel.text="Total number of words remaining in game: \(remainingAttempts)"
                    totalWordsLabel.text="Total number of words in game: \(image.count)"
                    //updateUser(l:wordLevel)
                    secretWord=""
                    guessCount=0
                    guessedCount=0
                    
                    
                }
                
            }else{
                guessCountLabel.text="You have made \(guessCount) guesses"
            }}
        
        
        else{
            guessCountLabel.text="You have used all the available guesses, Please play again"
            hintLabel.text=""
            guessLetterField.text=""
                guessBtn.isEnabled=false
                playAgainBtn.isHidden=false
                playAgainBtn.isEnabled=true
            guessCount=0
        }
        
        
    }
    
    func GameDone(){
        statusLabel.isHidden=false
        statusLabel.text="Congratulations! You are done with the game! Please start over again"
        displayImage.isHidden=false
        displayImage.image = UIImage(named: "alldone")
    }
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        if(numofWords==5) {
            
            statusLabel.isHidden=false
            //statusLabel.isEnabled=true
            statusLabel.text="Congratulations! You are done with the game! Please start over again"
            displayImage.isHidden=false
            displayImage.image = UIImage(named: "alldone")
            wordLevel=0
            remainingAttempts=5
            numofWords=0
            guessCount=0
            secretWord=""
            hintLabel.text=""
            guessCountLabel.text=""
            userGuessLabel.text=""
            wordsGuessedLabel.text="Total number of words guessed successfully: \(numofWords)"
            wordsRemainingLabel.text="Total number of words remaining in game: \(remainingAttempts)"
            totalWordsLabel.text="Total number of words in game: \(image.count)"
        }else{
            updateUser(l:wordLevel)
        }
        
        
        
    }
    
    @IBOutlet weak var displayImage: UIImageView!
    
    
    @IBAction func CharEntered(_ sender: UITextField) {
        
        let textEnterd = guessLetterField.text!
        
        if(textEnterd.isEmpty) {
            guessBtn.isEnabled = false
        }
        else {
            guessBtn.isEnabled = true
        }
    }
    
    
    
    func updateUser(l:Int){
        wordsGuessedLabel.text="Total number of words guessed successfully: \(numofWords)"
        wordsRemainingLabel.text="Total number of words remaining in game: \(remainingAttempts)"
        totalWordsLabel.text="Total number of words in game: \(image.count)"
        guessCountLabel.text = "You have made 0 guesses"
        displayImage.isHidden=true
        guessLetterField.text=""
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=true
        statusLabel.isHidden=true
        statusLabel.isEnabled=false
        
        var ans=""
        let str=image[l][0]
        for _ in str{
            ans=ans+"_"+" "
        }
        userGuessLabel.text="\(ans)"
        hintLabel.text="Hint: \(image[l][1])"
        updatedString=""
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUser(l: wordLevel)
        
        guessCountLabel.text = "You have made 0 guesses"
        statusLabel.isEnabled=false
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=false
        
        guessBtn.isEnabled = false
        guessLetterField.addTarget(self, action: #selector(CharEntered(_:)), for: .editingChanged)

    }


}

