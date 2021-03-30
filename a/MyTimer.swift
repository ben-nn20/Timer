//
//  MyTimer.swift
//  a
//
//  Created by Benjamin Nakiwala on 3/15/21.
//

import Foundation
import Combine
import AppKit


class MyTimer: ObservableObject {
    private var timer = Timer()
    @Published var remainingSeconds = 0.0
    @Published var isFinished = true
    private var startDate: Date!
    deinit {
        stopTiming()
    }
    func startTiming(_ seconds: Int) {
        remainingSeconds = Double(seconds)
        Notifications.timer = self
        Notifications.scheduleNotification(seconds)
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.elaspedTimeSelector()
            self.timingSelector()
        })
    }
    func stopTiming() {
        if remainingSeconds <= 0 {
            let hapticPerfomer = NSHapticFeedbackManager.defaultPerformer
            hapticPerfomer.perform(.generic, performanceTime: .now)
        }
        timer.invalidate()
    }
   private func elaspedTimeSelector() {
        remainingSeconds += startDate.timeIntervalSinceNow
        startDate = Date()
    }
    private func timingSelector() {
        if remainingSeconds <= 0.0 {
            isFinished.toggle()
            stopTiming()
        }
    }
   
    
}
