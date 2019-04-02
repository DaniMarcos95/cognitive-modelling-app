//
//  frec.swift
//  Guitar_learner_UI
//
//  Created by Leonard Praetorius on 01/03/2019.
//  Copyright © 2019 Leonard Praetorius. All rights reserved.
//
import UIKit

var numOfRecords = 0
let chordNamesDataset = ["Em","E","Am","A","C","G","D","Dm","F"]


class UserInterface: UIView {

    //Positions
    //string
    lazy var sE = bounds.width * 1/7
    lazy var sA = bounds.width * 2/7
    lazy var sD = bounds.width * 3/7
    lazy var sG = bounds.width * 4/7
    lazy var sB = bounds.width * 5/7
    lazy var se = bounds.width * 6/7
    //fret
    lazy var p1 = bounds.height * 1/10
    lazy var p2 = bounds.height * 3/10
    lazy var p3 = bounds.height * 5/10
    lazy var p4 = bounds.height * 7/10
    lazy var p5 = bounds.height * 9/10
    
    var indexToDraw: Int = 0
    var displayOption = true
    var showFeedback = false
    var activationLevel = 0.0
    
    
    var chordToPresent: String = "initializing"
    var chordToCompare: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    
    
    var chunkList: [(String,Double,[Double])] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .white
    }
    
    //Draw Frame
    var path: UIBezierPath!
    func createRectangle(){
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
        UIColor.black.setStroke()
        path.lineWidth = 1
        path.stroke()
    }
    
    //Draw Markers
    var mark = UIBezierPath()
    func Marks() {
        let marks = [0.5, 0.9]
        for n in marks {
            mark.addArc(
                withCenter: CGPoint(x: bounds.width / 2, y: bounds.height * CGFloat(n)),
                radius: 13,
                startAngle: 0,
                endAngle: CGFloat(2 * Double.pi),
                clockwise: true)
            UIColor.gray.setStroke()
            UIColor.gray.setFill()
            mark.lineWidth = 0 //linewidth >0 results in line connecting markers
            mark.fill()
            mark.stroke()
        }
    }
    //DOTO: Create method to be able to change colors
    //Draw Strings
    var string = UIBezierPath()
    func Strings() {
        let strings = [sE, sA, sD, sG, sB, se]
        for n in strings {
            string.move(to: .init(x: n, y:0))
            string.addLine(to: .init(x: n, y: bounds.height))
            UIColor.black.setStroke()
            string.lineWidth = 3
            string.stroke()
        }
    }
    
    var current_string = UIBezierPath()
    func update(n: Int) {
        
        current_string.move(to: CGPoint(x: n, y:0))
        current_string.addLine(to: CGPoint(x: n, y: Int(bounds.height)))
        UIColor.blue.setStroke()
        current_string.lineWidth = 3
        current_string.stroke()
        /*let animate_string = CAShapeLayer()
        animate_string.path = current_string.cgPath
        animate_string.strokeColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1).cgColor
        animate_string.strokeEnd = 0
        animate_string.lineWidth = 3;
        self.layer.addSublayer(animate_string)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.autoreverses = false
        animation.repeatCount = .infinity
        animate_string.add(animation, forKey: "line")*/
    }
    
    var finished_string = UIBezierPath()
    func Finished(n: Int) {
        
        finished_string.move(to: CGPoint(x: n, y:0))
        finished_string.addLine(to: CGPoint(x: n, y: Int(bounds.height)))
        UIColor.green.setStroke()
        finished_string.lineWidth = 3
        finished_string.stroke()
    }
    
    func drawGreenFeedback(n: Int) {
        let feedback_green_string = UIBezierPath()
        feedback_green_string.move(to: CGPoint(x: n, y:0))
        feedback_green_string.addLine(to: CGPoint(x: n, y: Int(bounds.height)))
        UIColor.green.setStroke()
        feedback_green_string.lineWidth = 3
        feedback_green_string.stroke()
    }
    
    func drawRedFeedback(n: Int) {
        let feedback_red_string = UIBezierPath()
        feedback_red_string.move(to: CGPoint(x: n, y:0))
        feedback_red_string.addLine(to: CGPoint(x: n, y: Int(bounds.height)))
        UIColor.red.setStroke()
        feedback_red_string.lineWidth = 3
        feedback_red_string.stroke()
    }
    
    func drawGrayString(n: Int) {
        let feedback_gray_string = UIBezierPath()
        feedback_gray_string.move(to: CGPoint(x: n, y:0))
        feedback_gray_string.addLine(to: CGPoint(x: n, y: Int(bounds.height)))
        UIColor.lightGray.setStroke()
        feedback_gray_string.lineWidth = 3
        feedback_gray_string.stroke()
    }
    
    //Draw Frets
    var frets = UIBezierPath()
    func Frets() {
        for n in 1...4 {
            frets.move(to: .init(x: 0, y: bounds.height * CGFloat(n)/5))
            frets.addLine(to: .init(x: bounds.width, y: bounds.height * CGFloat(n)/5))
            UIColor.gray.setStroke()
            frets.lineWidth = 5
            frets.stroke()
        }
    }
    
    var blackline = UIBezierPath()
    func Bline() {
        blackline.move(to: .init(x: 0, y: 0))
        blackline.addLine(to: .init(x: bounds.width, y: 0))
        UIColor.black.setStroke()
        blackline.lineWidth = 10
        blackline.stroke()
    }
    
    func Fingers(digit: String, string: Int, fret: Int) {
        let finger = UIBezierPath()
        finger.addArc(
            withCenter: CGPoint(x: string, y: fret),
            radius: 13,
            startAngle: 0,
            endAngle: CGFloat(2 * Double.pi),
            clockwise: true)
        UIColor.black.setStroke()
        UIColor.black.setFill()
        finger.lineWidth = 0
        finger.fill()
        finger.stroke()
        
        createTextLayer(digit: digit, string: string, fret: fret)
    }
    
    
    func createTextLayer(digit: String, string: Int, fret: Int) {
        let textLayer = CATextLayer()
        textLayer.string = digit
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 20.0)
        textLayer.fontSize = 20.0
        textLayer.frame = CGRect(x: string - 5, y: fret - 13, width: 20, height: 20)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
    }

    override func draw(_ rect: CGRect) {
        
        let recordE = [sE]
        let recordA = [sA, sE]
        let recordD = [sD, sE, sA]
        let recordG = [sG, sD, sE, sA]
        let recordB = [sB, sG, sD, sE, sA]
        let recorde = [se, sB, sG, sD, sE, sA]
        let allrecorded = [se, se, sB, sG, sD, sE, sA]
        let stringOrder = [recordE, recordA, recordD, recordG, recordB, recorde, allrecorded]
        
        var index = 0
        for chord in chordNamesDataset{
            if chord == chordToPresent{
                index = chordNamesDataset.firstIndex(of: chord)!
            }
        }
        
        let C = [[3, sA, p3], [2, sD, p2], [1, sB, p1]]
        let G = [[2, sE, p3], [1, sA, p2], [4, se, p3], [3, sB, p3]]
        let A = [[1, sD, p2], [2, sG, p2], [3, sB, p2]]
        let D = [[1, sG, p2], [3, sB, p3], [2, se, p2]]
        let E = [[2, sA, p2], [3, sD, p2], [1, sG, p1]]
        let F = [[1, sE, p1], [3, sA, p3], [4, sD, p3], [2, sG, p2], [1, sB, p1], [1, se, p1]]
        let Am = [[2, sD, p2], [3, sG, p2], [1, sB, p1]]
        let Dm = [[2, sG, p2], [3, sB, p3], [1, se, p1]]
        let Em = [[2, sA, p2], [3, sD, p2]]
        
        let frequenciesC = [ 130.8, 155.56, 196.00, 261.94, 329.63]
        let frequenciesA = [110.0, 164.8, 220.0, 277.2, 329.6]
        let frequenciesE = [82.4, 123.5, 164.8, 207.6, 246.9, 329.6]
        let frequenciesEm = [82.41, 123.47, 164.81, 196.0, 246.94, 329.63]
        let frequenciesAm = [110.0, 164.81, 220.0, 261.63, 329.63]
        let frequenciesG = [98.0, 123.47, 146.83, 196.0, 293.66, 392.0]
        let frequenciesD = [146.83, 220.0, 293.66, 369.99]
        let frequenciesDm = [146.83, 220.0, 293.66, 349.23]
        let frequenciesF = [87.31, 130.81,174.61, 220.0, 261.63, 349.23]
        
        let stringToRecordEm = [true, true, true, true, true, true]
        let stringToRecordE = [true, true, true, true, true, true]
        let stringToRecordAm = [false, true, true, true, true, true]
        let stringToRecordA = [false, true, true, true, true, true]
        let stringToRecordC = [false, true, true, true, true, true]
        let stringToRecordG = [true, true, true, true, true, true]
        let stringToRecordD = [false, false, true, true, true, true]
        let stringToRecordDm = [false, false, true, true, true, true]
        let stringToRecordF = [true, true, true, true, true, true]
        
        let numberOfStrings = [6, 6, 5, 5, 5, 6, 4, 4, 6]
        
        let chordDataset = [Em,E,Am,A,C,G,D,Dm,F]
        let frequencyDataset = [frequenciesEm,frequenciesE,frequenciesAm,frequenciesA,frequenciesC,frequenciesG,frequenciesD,frequenciesDm,frequenciesF]
        
        let stringColorDataset = [stringToRecordEm,stringToRecordE,stringToRecordAm,stringToRecordA,stringToRecordC,stringToRecordG,stringToRecordD,stringToRecordDm,stringToRecordF]
        
        let currentChord = chordDataset[index]
        chordToCompare = frequencyDataset[index]
        self.createRectangle()
        Frets()
        Strings()
        Marks()
        Bline()
        
        retrieveActivation()
        
        for (chord,actLvl,numberOfTimes) in chunkList{
            if chord == chordToPresent{
                if(numberOfTimes.count > 1){
                    activationLevel = actLvl
                }else{
                    activationLevel = -300
                }
            }
        }
        
        numOfRecords = numberOfStrings[index]
        
        let aux = stringColorDataset[index]
        var count = 0
        for element in aux{
            if element == false{
                count += 1
            }
        }
        
        for (index_in, n) in stringOrder[self.indexToDraw+count].enumerated() {
            if index_in == 0 {
                update(n: Int(n))
            } else {
                Finished(n: Int(n))
            }
        }
        
        for (index_in, n) in recorde.enumerated() {
            var aux = stringColorDataset[index]
            let aux_var = aux[0]
            aux[0] = aux[1]
            aux[1] = aux_var
            if aux[5-index_in] == false {
                drawGrayString(n: Int(n))
            }
        }
        
        if(showFeedback == true){
            if correctStrings.count < 6{
                let diff = 6 - correctStrings.count
                for i in 0...diff{
                    correctStrings.insert(true, at: i)
                }
            }
            let aux = correctStrings[0]
            correctStrings[0] = correctStrings[1]
            correctStrings[1] = aux
            for (index_in, n) in recorde.enumerated() {
                if(correctStrings[5-index_in] == false){
                    drawRedFeedback(n: Int(n))
                }else{
                    var aux = stringColorDataset[index]
                    let aux_var = aux[0]
                    aux[0] = aux[1]
                    aux[1] = aux_var
                    if aux[5-index_in] == false{
                        drawGrayString(n: Int(n))
                    }else{
                        drawGreenFeedback(n: Int(n))
                    }
                }
            }
        }
        
        if(activationLevel < -1 || displayOption == false){
            for finger in currentChord {
                Fingers(digit: String(Int(finger[0])), string: Int(finger[1]), fret: Int(finger[2]))
            }
            displayOption = true
        }
    }
    
    func retrieveActivation (){
        for (_,chunk) in cogmod.dm.chunks {
            cogmod.time += 1
            
            let chunkTp = chunk.slotvals
            let chunkType = chunkTp == nil ? "No Type" : chunkTp.description
            chunkList.append((chunk.name,chunk.activation(),chunk.referenceList))
            
            
        }
    }
}
