//
//  ViewController.swift
//  assignment1
//
//  Created by Christian Cornelis on 2018-01-21.
//  Copyright © 2018 Christian Cornelis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var outputField: UITextView!
    
    //function to handle press of Calculate button
    @IBAction func btnPress(_ sender: UIButton) {
        //variables to hold all values needed for Flesch calculation
        var numSyllables = 0, numWords = 0, numSentences = 0
        //input string is whatever is in the UITextView "inputField"
        let input = String(inputField.text)
        
        //throw an error if inputField is empty
        if (input.isEmpty){
            outputField.text = "Please input a sentence to calculate its Flesch number."
        }
        //else, we can calculate the Flesch number
        else{
            let sentences = getSentences(input:input)  //getting sentences
            //if the user entered input that did not end in a : ; . ! or ?, an error message will be output
            if (sentences != []){
                //iterating through each sentence
                for sentence in sentences{
                    numSentences += 1
                    let words = getWords(input: sentence) //breaking up sentences into words
                    numWords += words.count
                    //iterating through each words\
                    for word in words{
                        /*var isInt = false
                        for char in word{
                            if ("0123456789".contains(char)){
                                isInt = true
                                break
                            }
                        }*/
                        
                        numSyllables += getSyllables(input: String(word)) //getting all syllables in each word
                    }
                }
                
                //calculating the Flesch number
                let flesch = calcIndex(numSyllables: numSyllables, numWords: numWords, numSentences: numSentences)
                //outputting results
                outputField.text = "Flesch Number: \(flesch)\nSentences: \(numSentences)\nWords: \(numWords)\nSyllables: \(numSyllables)"
            }
            //if a sentence was not ended properly, output an error message.
            else{
                outputField.text = "Please enter a valid sentence."
            }
            
        }
    }
    
    /*
     Function to break up user input into individual sentences.
     INPUT: a String inputted into the inputField UITextView
     OUTPUT: An array of strings that is comprised of all sentences.
    */
    func getSentences(input userStr:String) -> [String]{
        let separators = [".", "?", "!", ":", ";"]  //separators that end sentences
        var sepFound = false
        //cleaning numbers from user-inputted string
        var userStrCpy = userStr
        //cleaning quotes from user input
        userStrCpy = userStrCpy.replacingOccurrences(of: "\"", with: "")
        userStrCpy = userStrCpy.replacingOccurrences(of: "\'", with: "")
        //filtering any symbols from user input
        let str = String(userStrCpy.filter{!"/$@#%^&*(){}[]|\\<>-_=+`~,\n\t0123456789".contains($0)})
        //iteraitng through separators to see if the user input actually contains sentence-ending punctuation
        for c in separators{
            if (str.contains(c)){
                sepFound = true
                break
            }
        }
        
        //if there was no separator found OR there was no punctuation to end a 
        if (!sepFound || !separators.contains(String(str.suffix(1)))){
            return []
        }
        
        var sentences = str.components(separatedBy: [".", "?", "!", ":", ";"])  //separating input into individual sentences.
        sentences = sentences.filter {$0 != ""}  //filtering out blank strings that are produced by the separation
        
        return sentences
    }
    
    /*
     Function to break sentences up into words.
     INPUT: A string that is comprised of an individual sentence from user input
     OUTPUT: An array of subtrings containing each word in the inputted sentence.
    */
    func getWords(input sentences:String) ->Array<Substring>{
        let words = sentences.split(separator: " ")  //separating sentences by spaces.

        return words
    }
    
    /*
     Function to retrieve the number of syllables that a word contains
     INPUT: a string comprised of a word
     OUTPUT: an integer representing the number of syllables in the inputted word
    */
    func getSyllables(input origWord:String) -> Int{
        var word = origWord
        //if the word ends in an E, remove it so it is not counted as a syllable.
        if (word.hasSuffix("e") || word.hasSuffix("E")){
            word.remove(at: word.index(before: word.endIndex))
        }
        var numSyllables = 0
        let vowels = "aeiouyAEIOUY"  //string containing all syllables to be counted.
        //let digits = "0123456789"    //string containing all digits to be removed from a word.
        var prevChar = Character("~")  //initializing the var to hold the previous character seen
        //iterating through each character in the word.
        for char in word{
            //if we find a vowel
            if (vowels.contains(char) ){
                numSyllables += 1
            }
            
            //accounting for when we have two vowels next to eachother
            if (vowels.contains(prevChar) && vowels.contains(char)){
                numSyllables -= 1
            }
            prevChar = char
        }
        
        //accounting for if we find no syllables in the word
        if (numSyllables == 0){
            numSyllables = 1
        }
        return numSyllables
    }
    
    /*
     Function to calculate the Flesch number of a user input.
     INPUT: number of syllables, number of words, number of sentences in user input.
     OUTPUT: An integer representing the Flech number of the user-inputted sentence(s)
    */
    func calcIndex(numSyllables syllables: Int, numWords words: Int, numSentences sentences: Int) -> Int{
        
        //Index = 206.835 - 84.6 * (# syllables/# words) - 1.015 * (# words/# sentences)
        let expression1 = 84.6 * (Double(syllables)/Double(words))
        let expression2 = 1.015 * (Double(words)/Double(sentences))
        let expression3 = 206.835 - expression1 - expression2
        
        return Int(expression3)
    }
    
}
