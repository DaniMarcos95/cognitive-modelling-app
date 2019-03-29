//
//  cogmodel.swift
//  learning_guitar
//
//  Created by liam on 19/03/2019.
//  Copyright © 2019 liam. All rights reserved.
//

import Foundation

let cogmod = Model()
var indexcount =  0
var shownchunk : [Chunk] = []
let timer = ParkBenchTimer()

var username: String = "Undefined"

class testing {
    
    lazy var user_time = username + "time"
    lazy var user_references = username + "references"
    lazy var user_betalist = username + "betalist"
    lazy var user_storedChords = username + "storedChords"

    lazy var storedChords = UserDefaults.standard.integer(forKey: user_storedChords)
    let scoring = "beta"
    var registeredusers : [String] = []



    let c = cogmod.generateNewChunk(string: "C")
    let g = cogmod.generateNewChunk(string: "G")
    let a = cogmod.generateNewChunk(string: "A")
    let d = cogmod.generateNewChunk(string: "D")
    let f = cogmod.generateNewChunk(string: "F")
    let am = cogmod.generateNewChunk(string: "Am")
    let e = cogmod.generateNewChunk(string: "E")
    let em = cogmod.generateNewChunk(string: "Em")
    let dm = cogmod.generateNewChunk(string: "Dm")
    
    lazy var chordsList = [em,e,am,a,c,g,d,dm,f]
    
    func checkIfUserExists(InputUserName: String) {
        var check = 0
        registeredusers = UserDefaults.standard.array(forKey: "listOfUsers") as? [String] ?? [String]()
        let j = registeredusers.endIndex
        if j > 0 {
        for  i in 0..<j {
            if registeredusers[i] == InputUserName{
                username = InputUserName
                checkDefaultMem()
                print("existing user \(username) used")
                check = 1
            }
        }
            if check == 0 {
                username = InputUserName
                registeredusers.append(InputUserName)
                UserDefaults.standard.set(registeredusers, forKey: "listOfUsers")
                print("new user \(username) added")
            }
            
        } else {
                username = InputUserName
                registeredusers.append(InputUserName)
                UserDefaults.standard.set(registeredusers, forKey: "listOfUsers")
                print("first user \(username) added")

            }
        }
        
        
    
    
    
    func checkDefaultMem(){
        print("storedchords index is \(storedChords)")
        print(username)
        if storedChords > 0 {
            
        for i in 0..<storedChords{
            print("storedchords index is \(storedChords)")
            
            let something = cogmod.dm.addToDMOrStrengthen(chunk: chordsList[i])
            chordsList[i].setSlot(slot: "type", value: "Chord")
            chordsList[i].setSlot(slot: "ChordType", value: chordsList[i].name)
            
            var temp = timer.stop()
            print("time is \(temp)")
            
            let user_references_chord = user_references + chordsList[i].name
            chordsList[i].referenceList = UserDefaults.standard.array(forKey: user_references_chord)  as? [Double] ?? [Double]()
            
            let user_betalist_chord = user_betalist + chordsList[i].name
            print(user_betalist_chord)
            chordsList[i].listBeta = UserDefaults.standard.array(forKey: user_betalist_chord) as? [Double] ?? [Double]()
            
            print ("we loaded betalist \(chordsList[i].listBeta) of chord: \(chordsList[i].name)" )
            print("we loaded index: \(storedChords)")
            print ("we loaded referencelist \(chordsList[i].referenceList) of chord: \(chordsList[i].name)" )
            }
            
        indexcount =  UserDefaults.standard.integer(forKey: self.user_storedChords)
        cogmod.time = UserDefaults.standard.double(forKey: user_time)
        print("time loaded is \(cogmod.time)")
            cogmod.time += 1000
            
            printDM()
        }

    }
    
    func resetdata () {
        UserDefaults.standard.removeObject(forKey: user_time)
        for i in 0..<storedChords{
            let user_references_chord = user_references + chordsList[i].name
            UserDefaults.standard.removeObject(forKey: user_references_chord)
            
            let user_betalist_chord = user_betalist + chordsList[i].name
            UserDefaults.standard.removeObject(forKey: user_betalist_chord)

        }
        UserDefaults.standard.removeObject(forKey: user_storedChords)

    }
    
    func resetUsers () {
        UserDefaults.standard.removeObject(forKey: "listOfUsers")
        
    }
    func printDM (){
        print("THis is our declarative memory of stored chunks at time \(cogmod.time)")
        var chunkList: [(String,Double)] = []
        for (_,chunk) in cogmod.dm.chunks {
            let chunkTp = chunk.slotvals
            let chunkType = chunkTp == nil ? "No Type" : chunkTp.description
            chunkList.append((chunk.name,chunk.activation()))
        }
        print(chunkList)

    }
    
    //NOT USED
    func Firstaddnewchord (chordsList: [Chunk] ) {
        for i in 0...2{
            let something = cogmod.dm.addToDMOrStrengthen(chunk: chordsList[i])
            chordsList[i].setSlot(slot: "type", value: "Chord")
            chordsList[i].setSlot(slot: "ChordType", value: chordsList[i].name)
            var temp = timer.stop()
            print("time is \(temp)")
            indexcount = i
            
        }
    }
    //NOTUSED
    func startapp () -> Chunk?{
        Firstaddnewchord(chordsList: chordsList)
        var temp = timer.stop()
        print("time is \(temp)")
        cogmod.time = temp
        cogmod.time += 50
        let chosen = retrieveNext()
        //self.shownchunk = chosen!

        return chosen
    }
    //NOT USED
    func tester () {
        print(cogmod.time)
        var temp = startapp()
        updateModel(accuracyScore: 1)
        temp = nextORnew()
        updateModel(accuracyScore: 1)
        temp = nextORnew()
        updateModel(accuracyScore: 0.5)
    }
    
    func addnewchord (chordsList: [Chunk]) -> Chunk{
        let i = indexcount
        //print("we will add chord with index \(i)")
        let something = cogmod.dm.addToDMOrStrengthen(chunk: chordsList[i])
        chordsList[i].setSlot(slot: "type", value: "Chord")
        chordsList[i].setSlot(slot: "ChordType", value: chordsList[i].name)
        indexcount += 1
        
        UserDefaults.standard.set(indexcount, forKey: self.user_storedChords)
        //print("user defaults for index set to \(self.user_storedChords)")
        //self.shownchunk = chordsList[i]
        
        
        var temp = timer.stop()
        //print("when adding chord time is \(cogmod.time)")
        chordsList[i].listBeta.append(0.1)
        return chordsList[i]
    }
    
    func nextORnew () -> Chunk?{
        var chosenchord = retrieveNext()
        if chosenchord == nil {
            print("it was nil, we choose next chord")
            if indexcount < 8 {
                let temp = addnewchord(chordsList: chordsList )
                chosenchord = temp
                print("added a new chord")
                print(chosenchord)
                shownchunk.append(chosenchord!)

            } else if indexcount >= 8{
                print("all chords have been presentend")
                cogmod.dm.retrievalThreshold = -100000
                //print(cogmod.dm.retrievalThreshold)
                let temp = retrieveNext()
                chosenchord = temp
            }
        } else {
            print("we present chord:")
            print(chosenchord?.name )
        }
        //self.shownchunk = chosenchord!
        return chosenchord
    }
    
    //call this func before they want to play chord (to choose what comes next): "
    func retrieveNext ()  -> Chunk? {
        var temp = timer.stop()
        //print("time is \(temp)")
        cogmod.time += temp
        let probechunk = cogmod.generateNewChunk(string: "toretrieve")
        probechunk.setSlot(slot: "type", value: "Chord")
        let (latency, retrieveResult) = cogmod.dm.retrieve(chunk: probechunk)
        print("when retrtieving model time is /(model.time)")
        printDM()
        

        //print("We retrieved:")
        //print (retrieveResult)
        if retrieveResult != nil{
        shownchunk.append(retrieveResult!)
        }
        //print(shownchunk)
        //self.shownchunk = retrieveResult!
        UserDefaults.standard.set(cogmod.time, forKey: user_time)

        return retrieveResult
            
        }
    

// call this after they have played a chord

    func updateModel ( accuracyScore: Double){
        
        //WE ADJUST THE ACCURACY SCORE BECAUSE ACTIVATION DOESNT CLIMB
        let new_acc_score = accuracyScore*1.5
        
        
        //print(indexcount)
        var i = shownchunk.endIndex
        var temp = timer.stop()
        print("when updating model time is \(cogmod.time)")
        i -= 1
        cogmod.time += temp
        //print(shownchunk)
        //print(i)
        
        /*
        if accuracyScore == 1 {
        shownchunk[i].beta = 1
        } else if accuracyScore < 1 {
            shownchunk[i].beta = 0.3
        }
 */
        shownchunk[i].listBeta.append(new_acc_score)
        shownchunk[i].beta = new_acc_score
        
        let user_betalist_chord = self.user_betalist + shownchunk[i].name
        UserDefaults.standard.set(shownchunk[i].listBeta, forKey: user_betalist_chord)
        
        let something = cogmod.dm.addToDMOrStrengthen(chunk: shownchunk[i])
        cogmod.time += 1
        printDM()
        //print(shownchunk[i].referenceList)
        print("previous encounters listed: \(shownchunk[i].referenceList)")
        print("previous correctness listed: \(shownchunk[i].listBeta)")
        
        let user_references_chord = self.user_references + shownchunk[i].name

        UserDefaults.standard.set(shownchunk[i].referenceList, forKey: user_references_chord)
        UserDefaults.standard.set(cogmod.time, forKey: user_time)
        
        
        print("FINISHED UPDATING")
      

    
    }
}
   

