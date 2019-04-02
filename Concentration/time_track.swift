//
//  time_track.swift
//  next_cogmod_attempt
//
//  Created by liam on 22/03/2019.
//  Copyright © 2019 liam. All rights reserved.
//
// this time tracker implementation was taken from Klaas answered Oct 26 '14 at 21:30 on stackoverflow: https://stackoverflow.com/questions/24755558/measure-elapsed-time-in-swift


import Foundation
import CoreFoundation

class ParkBenchTimer {
    
    let startTIme: CFAbsoluteTime
    var endTime: CFAbsoluteTime?
    
    init() {
        startTIme = CFAbsoluteTimeGetCurrent()
    }
    
    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()
        
        return duration!
    }
    
    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTIme
            
        } else {
            return nil
        }
    }
}
