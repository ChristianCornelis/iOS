//
//  ViewController.swift
//  assignment2
//
//  Created by Christian Cornelis on 2018-02-08.
//  Copyright © 2018 Christian Cornelis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //outputting initial room to the textview
        curRoom = updateStoryOutput(currentRoom: "", rooms: parseInput(), input: "")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //if reset button is pressed
    @IBAction func btnPress(_ sender: UIButton) {
        //clear inventory, reset the current room
        curRoom = ""
        inv.clear()
        curRoom = updateStoryOutput(currentRoom: "", rooms: rooms, input: "")
    }
    
    @IBOutlet weak var userInput: UITextField!  //textfield for user input
    @IBOutlet weak var storyOutput: UITextView! //textview for the output of the story
    
    //variables to keep track of state of story
    let rooms = parseInput()
    var curRoom = ""
    let inv = Inventory()
    var viewInv = false
    var savedOutput = ""
    
    //function to handle grabbing user input
    @IBAction func userInput(_ sender: UITextField) {
        if (curRoom == ""){
            curRoom = updateStoryOutput(currentRoom: "", rooms: parseInput(), input: "")
        }
        let input:String = sender.text!
        sender.text = ""
        let testInt:Int? = Int(input)
        //clear inventory if at the end
        if (rooms[curRoom]?.isEnd)!{
            if (testInt == 1){
                inv.clear()
            }
            //if the user wants to exit, suspend the application.
            if (testInt == 2){
                inv.clear()
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }
        }
        //getting range of options that are available to make sure that the user input is valid
        let optRange = (rooms[curRoom]?.options.count)
        //if the input isn't a call to the inventory
        if (input != "i" && input != "I"){
            //if the input is a valid integer
            if (testInt != nil && optRange != nil){
                //if the input is a valid option
                if (testInt!-1 >= 0 && testInt!-1 < optRange!){
                    curRoom  = updateStoryOutput(currentRoom: curRoom, rooms: rooms, input: input)
                    if curRoom != ""{
                        updateInventory(rooms: rooms)
                    }
                }
            }
        }
        //else if input IS a call to the inventory
        else{
            //if the user is currently viewing the input, restore the state of the story
            if (viewInv){
                viewInv = false
                storyOutput.text = savedOutput
            }
            //else let the user see the inventory
            else{
                savedOutput = storyOutput.text
                viewInv = true
                viewInventory()
            }
        }
    }
    
    //function to view the inventory
    func viewInventory(){
        storyOutput.text = "Inventory:\n\n"
        if inv.getItems() != []{
            for i in inv.getItems(){
                storyOutput.text = storyOutput.text + i + "\n\n"
            }
        }
        else{
            storyOutput.text = storyOutput.text + "Empty"
        }
    }
    
    //function to go through the story
    func getStart()->String{
        let rooms = parseInput()
        var start = ""
        for (key,value) in rooms{
            if value.isStart{
                start = key
                break
            }
        }
        return start
    }
    
    //function to update the story output to the textview. Returns the current room that the user is in after their desired move has been made if valid.
    func updateStoryOutput(currentRoom curRoom:String, rooms: Dictionary<String, Room>, input i:String)->String{
        //if the current room is blank and so is input, initialize the story
        if (curRoom == "" && i == ""){
            let start = getStart()
            storyOutput.text = (rooms[start]?.printDesc())!
            storyOutput.text = storyOutput.text + (rooms[start]?.printItems())!
            for (key,value) in (rooms[start]?.transformations)!{
                if inv.getItems().contains(key) {
                    //inv.addItem(toAdd: value[1])
                    if (inv.transform(oldName: key, newName: value[0])){
                        storyOutput.text = storyOutput.text + value[1] + "\n\n"
                    }
                }
            }
            storyOutput.text = storyOutput.text + (rooms[start]?.printOptions())!
            return start
        }
        else {
            var r = ""
            if (curRoom == "" && i != ""){
                r = getStart()
            }
            else{
                r = curRoom
            }
            if ((rooms[r]?.options[Int(i)!-1]) != nil){
                //storyOutput.text = rooms[
                var nextRoom = rooms[r]?.options[Int(i)!-1].room
                if (nextRoom != ""){
                    storyOutput.text = rooms[nextRoom!]?.printDesc()
                    
                    var printItemMsg = false
                    for i in (rooms[nextRoom!]?.invItems)!{
                        if (inv.contains(item: i)){
                            printItemMsg = false
                        }
                        else{
                            printItemMsg = true
                        }
                    }
                    if printItemMsg{
                        storyOutput.text = storyOutput.text + (rooms[nextRoom!]?.printItems())!
                    }
                    
                    //transforming items
                    for (key,value) in (rooms[nextRoom!]?.transformations)!{
                        if inv.getItems().contains(key) {
                            //inv.addItem(toAdd: value[1])
                            if(inv.transform(oldName: key, newName: value[0])){
                                storyOutput.text = storyOutput.text + value[1] + "\n\n"
                            }
                        }
                    }
                    storyOutput.text = storyOutput.text + (rooms[nextRoom!]?.printOptions())!
                    return nextRoom!
                }
                //if the option has conditions that must be checked
                else{
                    for (key, value) in (rooms[r]?.options[Int(i)!-1].conds)!{
                        if inv.contains(item: key){
                            nextRoom = value[0]
                            storyOutput.text = rooms[nextRoom!]?.printDesc()
                            storyOutput.text = storyOutput.text + (rooms[nextRoom!]?.printItems())!
                            //transforming items
                            for (key,value) in (rooms[nextRoom!]?.transformations)!{
                                if inv.getItems().contains(key) {
                                    //inv.addItem(toAdd: value[1])
                                    if (inv.transform(oldName: key, newName: value[0])){
                                        storyOutput.text = storyOutput.text + value[1] + "\n\n"
                                    }
                                }
                            }
                            storyOutput.text = storyOutput.text + (rooms[nextRoom!]?.printOptions())!
                            return nextRoom!
                        }
                        else{
                            storyOutput.text = storyOutput.text + value[1] + "\n\n"
                        }
                    }
                    return r
                }
            }
        }
        return ""
    }
    
    //function to update the user's inventory
    func updateInventory(rooms: Dictionary<String, Room>){
        for item in (rooms[curRoom]?.invItems)!{
            inv.addItem(toAdd: item)
        }
    }
}

//room object to hold all rooms in the input file.
public class Room {
    let name:String
    var options:[Option]
    let desc:String
    var invMsg:String
    var invItems:[String]
    var isStart:Bool
    var isEnd:Bool
    var transformations = Dictionary<String, [String]>()  //Value: value, description of change
    //initialize the object
    init(name n:String, desc d:String) {
        self.name = n
        self.options = []
        self.desc = d.trimmingCharacters(in: .punctuationCharacters)
        self.invMsg = " "
        self.invItems = []
        self.transformations = [:]
        self.isStart = false
        self.isEnd = false
    }
    
    //toString for debugging
    func toString()->String{
        return ("Room: \(self.name)\nDescription: \(self.desc)\nOptions:\(self.options)\nItems:\(self.invItems)\nInvDesc: \(self.invMsg)\nTransformations: \(self.transformations)")
    }
    
    //function to output description and options, also for debugging
    func output()->String{
        var toReturn:String = ""
        toReturn += self.desc
        for option in self.options{
            toReturn += option.toString()
        }
        
        return toReturn
    }
    
    //function to print to the room description
    func printDesc()->String{
        return self.desc.trimmingCharacters(in: .punctuationCharacters) + "\n\n"
    }
    
    //function to print all room options
    func printOptions()->String{
        var toReturn:String = ""
        for option in self.options{
            toReturn += option.toString()
        }
        return toReturn
    }
    
    //function to print all room item transformations
    func printTransformations(toChange t:String)->String{
        if (self.transformations[t] != nil){
            return self.transformations[t]![1] + "\n\n"
        }
        return ""
    }
    
    //function to print all room items
    func printItems()->String{
        if self.invMsg == ""{
            return " "
        }
        return (self.invMsg + "\n\n")
    }
    
    //function to return the maximum options array index
    func optionRange()->Int{
        return self.options.count-1
    }
}

//class for options
public class Option {
    let opt:Int
    var desc:String
    var room:String
    var conds = Dictionary<String, [String]>()
    
    //init
    init(opt o:Int, desc d:String, room r:String){
        self.opt = o
        self.desc = d
        self.conds = [:]
        self.room = r
    }
    
    //toString to return all options and their description
    func toString()->String{
        return "\(self.opt). \(self.desc)\n\n"
    }
}

//class for inventory.
public class Inventory{
    var items:[String]
    //init
    init(){
        self.items = []
    }
    
    //function to transform an item in the user's inventory
    func transform(oldName o:String, newName n:String)->Bool{
        if (self.items.contains(o) && !self.items.contains(n)){
            self.items[self.items.index(of: o)!] = n
            return true
        }
        else{
            return false
        }
    }
    
    //function to add an item to inventory
    func addItem(toAdd t:String){
        if self.items.contains(t) == false{
         self.items.append(t)
        }
    }
    
    //toString function for debugging
    func toString()->String{
        return "Items: \(self.items)"
    }
    
    //function to return the items in the inventory
    func getItems()->[String]{
        return self.items
    }
    
    //function to check if an item is contained in inventory
    //returns true or false
    func contains(item i:String)->Bool{
        if self.items.contains(i){
            return true
        }
        else{
            return false
        }
    }
    
    //function to clear the inventory
    func clear(){
        self.items = []
    }
}

//function to check if a regex yields any matches
//returns true or false
func regexMatch(pattern p: String, text t: String) -> Bool {
    do{
        let regex = try NSRegularExpression(pattern: p)
        let found = regex.matches(in: t, options: [], range: NSRange(t.startIndex..., in: t))

        if (found != []){
            return true
        }
        else {
            return false
        }
    }
    catch let error
    {
        print("Error: \(error.localizedDescription)")
        return false
    }
}

//function to extract all regex matches from a string
func regexExtract(pattern p: String, text t: String) -> [String] {
    do{
        let regex = try NSRegularExpression(pattern: p)
        let found = regex.matches(in: t, options: [], range: NSRange(t.startIndex..., in: t))
        var toReturn:[String] = []
        //add all valid matches to the array of Strings to return
        if (found.count > 0){
            for f in 0...found.count-1{
                toReturn.append(String(t[Range(found[f].range, in: t)!]))
            }
        }
        return toReturn
    }
    catch let error
    {
        print("Error: \(error.localizedDescription)")
        return []
    }
}

//function to parse the input file
func parseInput()->Dictionary<String,Room> {
    if let storyFile = Bundle.main.path(forResource: "input", ofType: "txt") {
        do {
            let fileData = try String(contentsOfFile: storyFile, encoding: .utf8)
            let fileLines = fileData.components(separatedBy: .newlines)
            var curRoom = ""
            var prevLine = ""
            var rooms = Dictionary<String, Room>()
            for line in fileLines{
                //if we have found a new room
                if (regexMatch(pattern: "^[<][a-zA-Z][>]", text: line)){
                    let splits = line.split(separator: ">", maxSplits: 1, omittingEmptySubsequences: true)
                    curRoom = String(splits[0].trimmingCharacters(in: .symbols))
                    var desc = String(splits[1].trimmingCharacters(in: .whitespaces))
                    desc = desc.trimmingCharacters(in: .punctuationCharacters)
                    let newRoom = Room(name: curRoom, desc: desc)
                    if (prevLine == ""){
                        newRoom.isStart = true
                    }
                    rooms[curRoom] = newRoom
                    prevLine = "r"
                }
                //if we have found a either an inventory modifier or an option condition
                else if (regexMatch(pattern: "^-if", text: line)){
                    //if the last read line was a room, a transformation, or an inventory addition, we know that this will be inventory modifying
                    if (prevLine == "r" || prevLine == "t" || prevLine == "inv"){
                        prevLine = "t"  //setting prevLine to a transformation
                        let splits = line.split(separator: "\"")
                        var key:String = ""
                        var desc:String = ""
                        var value:String = ""
                        for i in 1...splits.endIndex-1{
                            if (!regexMatch(pattern: "^[ ,]*$", text: String(splits[i]))){
                                //save transformation key
                                if (key == ""){
                                    key = String(splits[i])
                                }
                                    //save transformation value
                                else if (value == ""){
                                    value = String(splits[i])
                                }
                                    //end index will always be description of transformation
                                else if i == splits.endIndex-1{
                                    //save description
                                    desc = String(splits[i]).trimmingCharacters(in: .punctuationCharacters)
                                }
                            }
                        }
                        rooms[curRoom]?.transformations[key] = [value, desc]
                    }
                    //if the last read line was an option then we know this will check inventory to see if a user can do something. if MUST CONTAIN A ROOM TAG WITH A >
                    else if (prevLine == "o"){
                        prevLine = "c"
                        
                        var ifState = regexExtract(pattern: "-if [\"][^\"]*[\"]", text: line)[0]
                        var elseState = regexExtract(pattern: "else [\"][^\"]*[\"]", text: line)[0]
                        var move = regexExtract(pattern: "go [<][a-zA-Z][>]", text: line)[0]
                        ifState = regexExtract(pattern: "[\"][^\"]*[\"]", text: ifState)[0].trimmingCharacters(in: .punctuationCharacters)
                        elseState = regexExtract(pattern: "[\"][^\"]*[\"]", text: elseState)[0].trimmingCharacters(in: .punctuationCharacters)
                        move = regexExtract(pattern: "[<][a-zA-Z][>]", text: move)[0].trimmingCharacters(in: .symbols)
                        
                        rooms[curRoom]?.options[(rooms[curRoom]?.options.endIndex)!-1].conds[ifState] = [move, elseState]
                        
                    }
                }
                //if we've found an option
                else if (regexMatch(pattern: "^[0-9][.]", text: line)){
                    let optNum = (regexExtract(pattern: "^[0-9]", text: line))
                    let desc = regexExtract(pattern: "[\"][^\"]*[\"]", text: line)
                    var room = (regexExtract(pattern: "[<][a-zA-Z][>]", text: line))
                    if (room == []){
                        room = [""]
                    }
                    else{
                        for i in 0...room.count-1{
                            room[i] = room[i].trimmingCharacters(in: .symbols)
                        }
                    }
                    let newOption = Option(opt: Int(optNum[0])!, desc: desc[0].trimmingCharacters(in: .punctuationCharacters), room:room[0])
                    rooms[curRoom]?.options.append(newOption)
                    
                    prevLine = "o"
                    
                }
                //if we've found an inventory addition
                else if (regexMatch(pattern: "^-inventory", text: line)){
                    let splits = line.split(separator: "\"", maxSplits: 100, omittingEmptySubsequences: true)
                    prevLine = "inv"
                    for c in 0...splits.count-1{
                        if !regexMatch(pattern: "^[ ,]*$", text: String(splits[c])) && c != 0{
                            if c == 1{
                                rooms[curRoom]?.invMsg = String(splits[c])
                            }
                            else{
                                rooms[curRoom]?.invItems.append(String(splits[c]))
                            }
                        }
                    }
                }
                //if we've found the END
                else if (regexMatch(pattern: "^-end", text: line)){
                    var start = ""
                    for (key,value) in rooms{
                        if value.isStart{
                            start = key
                            break
                        }
                    }
                    //add options for restarting and ending
                    rooms[curRoom]?.options.append(Option(opt: 1, desc: "Start again.", room: start))
                    rooms[curRoom]?.options.append(Option(opt: 2, desc: "Exit.", room: start))
                    rooms[curRoom]?.isEnd = true
                }
            }
            return rooms
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    return [:]
}

