//
//  ContentView.swift
//  a
//
//  Created by Benjamin Nakiwala on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var minutesSelection = 0
    @State var secondsSelection = 0
    @State var hoursSelection = 0
    @State var elapsedSeconds = 0
    @EnvironmentObject var timer: MyTimer
    func timeRemaining() -> String {
        // Int for modulo math
        var remainingSeconds = Int(timer.remainingSeconds.rounded(.up))
        // declaring all time components
        var hours, mins, secs: Int
        // finding how many hours fits
        hours = remainingSeconds / 3600
        // subtracting that from seconds
        remainingSeconds -= hours * 3600
        // same for mins
        mins = remainingSeconds / 60
        // alse subtracting
        remainingSeconds -= mins * 60
        secs = remainingSeconds
        var string = ""
        /* there are four possible true/ false and true/false conditions
         first is minutes less or greater than 10
         second is seconds less or greater than 10
         2 keys * 2 possible values = 4 possible combinations
         hence 4 conditionals
        */
        if hours == 0 {
            if secs < 10 {
                string = "\(mins):0\(secs)"
            } else  {
                string = "\(mins):\(secs)"
            }
        } else {
            if mins < 10 && secs >= 10 {
                string = "\(hours):0\(mins):\(secs)"
            } else if mins < 10 && secs < 10 {
                string = "\(hours):0\(mins):0\(secs)"
            } else if mins >= 10 && secs >= 10 {
                string = "\(hours):\(mins):\(secs)"
            } else if mins >= 10 && secs < 10 {
                string = "\(hours):\(mins):0\(secs)"
            }
        }
        return string
    }
    var body: some View {
        VStack {
            if timer.isFinished {
                HStack {
                    Picker("", selection: $hoursSelection) {
                        ForEach(0..<24) { index in
                            if index == 1 {
                                Text("\(index) hour")
                            } else {
                                Text("\(index) hours")
                            }
                        }                    }
                    Picker("", selection: $minutesSelection) {
                        ForEach(0..<60) { index in
                            if index == 1 {
                                Text("\(index) minute")
                            } else {
                                Text("\(index) minutes")
                            }
                        }
                    }
                    Picker("", selection: $secondsSelection) {
                        ForEach(0..<60) { index in
                            if index == 1 {
                                Text("\(index) second")
                            } else {
                                Text("\(index) seconds")
                            }
                        }
                    }
                }
            } else {
                Text(timeRemaining())
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            if timer.isFinished {
                Button(action: {
                    timer.startTiming((hoursSelection * 3600) + (minutesSelection * 60) + secondsSelection)
                    withAnimation {
                        self.timer.isFinished.toggle()
                    }
                }, label: {
                    Text("Start")
                        
                })
            } else {
                Button(action: {
                    timer.stopTiming()
                    Notifications.cancelNotifications()
                    withAnimation {
                        self.timer.isFinished.toggle()
                    }
                    
                }, label: {
                    Text("Stop")
                })
            }
        }
        .padding(10)
        .frame(minWidth: 400, idealWidth: 400, maxWidth: .infinity, minHeight: 70, idealHeight: 100, maxHeight: .infinity, alignment: .center)
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MyTimer())
    }
}
