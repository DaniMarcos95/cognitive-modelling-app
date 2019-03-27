//
//  cogmodel.swift
//  learning_guitar
//
//  Created by liam on 19/03/2019.
//  Copyright © 2019 liam. All rights reserved.
//

import Foundation

let cogmod = Model()
var indexcount = 0
var shownchunk : [Chunk] = []
let timer = ParkBenchTimer()
class testing {
    



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
    
    
    func printDM (){
        print("THis is our declarative memory of stored chunks")
        var chunkList: [(String,Double)] = []
        for (_,chunk) in cogmod.dm.chunks {
            let chunkTp = chunk.slotvals
            let chunkType = chunkTp == nil ? "No Type" : chunkTp.description
            chunkList.append((chunk.name,chunk.activation()))
        }
        print(chunkList)

    }
    func Firstaddnewchord (chordsList: [Chunk] ) {
        for i in 0...2{
            let something = cogmod.dm.addToDMOrStrengthen(chunk: chordsList[i])
            chordsList[i].setSlot(slot: "type", value: "Chord")
            chordsList[i].setSlot(slot: "ChordType", value: chordsList[i].name)
            chordsList[i].startTime()
            var temp = timer.stop()
            print("time is \(temp)")
            indexcount = i
            
        }
    }
    
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
        let something = cogmod.dm.addToDMOrStrengthen(chunk: chordsList[i])
        chordsList[i].setSlot(slot: "type", value: "Chord")
        chordsList[i].setSlot(slot: "ChordType", value: chordsList[i].name)
        indexcount += 1
        //self.shownchunk = chordsList[i]
        var temp = timer.stop()
        print("time is \(temp)")
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
        print("time is \(temp)")
        cogmod.time += temp
        let probechunk = cogmod.generateNewChunk(string: "toretrieve")
        probechunk.setSlot(slot: "type", value: "Chord")
        let (latency, retrieveResult) = cogmod.dm.retrieve(chunk: probechunk)
        printDM()
        

        print("We retrieved:")
        print (retrieveResult)
        if retrieveResult != nil{
        shownchunk.append(retrieveResult!)
        }
        //print(shownchunk)
        //self.shownchunk = retrieveResult!
        return retrieveResult
            
        }
    

// call this after they have played a chord

    func updateModel ( accuracyScore: Double){
        //print(indexcount)
        var i = shownchunk.endIndex
        var temp = timer.stop()
        print("time is \(temp)")
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
        
        shownchunk[i].beta = accuracyScore
        let something = cogmod.dm.addToDMOrStrengthen(chunk: shownchunk[i])
        cogmod.time += 1
        printDM()
        shownchunk[i].listBeta.append(accuracyScore)
        //print(shownchunk[i].referenceList)
        print("previous encounters listed: \(shownchunk[i].referenceList)")
        print("previous correctness listed: \(shownchunk[i].listBeta)")
    
    }
}
   

