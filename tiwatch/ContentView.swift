//
//  ContentView.swift
//  tiwatch
//
//  Created by magadir on 14/05/20.
//  Copyright © 2020 magadir. All rights reserved.
//
import Foundation
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text(secondToMinutesAndSecond(seconds: timerManager.secondLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.red)
                    .onTapGesture (perform:{
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLenght(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                })
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top , 40)
                        .onTapGesture(perform : {
                            self.timerManager.reset()
                    })
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                .labelsHidden()
                }
            Spacer()
            }
        .navigationBarTitle("Timer")
        }
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
