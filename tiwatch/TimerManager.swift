//
//  TimerManager.swift
//  tiwatch
//
//  Created by magadir on 14/05/20.
//  Copyright © 2020 magadir. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondLeft = UserDefaults.standard.integer(forKey: "timerLength")

    
    var timer = Timer()
    
    func setTimerLenght(minutes:Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLenght")
        secondLeft = minutes
    }
    func start(){
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondLeft == 0 {
                self.reset()
            }
            self.secondLeft -= 1
        })
    }
    
    func reset(){
    self.timerMode = .initial
    self.secondLeft = UserDefaults.standard.integer(forKey: "timerLength")
    timer.invalidate()
        
    }
    
    func pause(){
    self.timerMode = .paused
    timer.invalidate()
        
    }
}
