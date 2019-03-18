//
//  frec.swift
//  Guitar_learner_UI
//
//  Created by Leonard Praetorius on 01/03/2019.
//  Copyright © 2019 Leonard Praetorius. All rights reserved.
//

import UIKit

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
            //light blue
            //UIColor.init(red: 0, green: 255, blue: 255, alpha: 1).setStroke()
            string.lineWidth = 3
            string.stroke()
        }
    }
    //Animate currently measured string
    var current_string = UIBezierPath()
    func current() {
        current_string.move(to: .init(x: sE, y:0))
        current_string.addLine(to: .init(x: sE, y: bounds.height))
        current_string.stroke()
        let animate_string = CAShapeLayer()
        animate_string.path = current_string.cgPath
        animate_string.strokeColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1).cgColor
        animate_string.strokeEnd = 0
        animate_string.lineWidth = 3;
        self.layer.addSublayer(animate_string)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animate_string.add(animation, forKey: "line")
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
    
    
    func Fingers(digit: String, string: Int, fret: Int) {
        var finger = UIBezierPath()
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
        func createTextLayer() {
            let textLayer = CATextLayer()
            textLayer.string = digit
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.font = UIFont(name: "Avenir", size: 20.0)
            textLayer.fontSize = 20.0
            /*textLayer.alignmentMode = CATextLayerAlignmentMode.center*/
            textLayer.frame = CGRect(x: string - 10, y: fret - 15, width: 20, height: 20)
            textLayer.contentsScale = UIScreen.main.scale
            self.layer.addSublayer(textLayer)
        }
        createTextLayer()
    }
    
    func draw() {
        self.createRectangle()
        Frets()
        Strings()
        current()
        Marks()
        let C = [[1, sB, p1],[2, sD, p2],[3, sA, p3]]
        for finger in C {
            Fingers(digit: String(Int(finger[0])), string: Int(finger[1]), fret: Int(finger[2]))
            print(finger[0])
        }
    }
}
