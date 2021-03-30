//
//  Notification.swift
//  a
//
//  Created by Benjamin Nakiwala on 3/15/21.
//

import UserNotifications
import AppKit

class Notifications {
    static unowned var timer: MyTimer?
    static func getAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, _) in
        }
    }
    static func scheduleNotification(_ seconds: Int) {
        let notification = UNMutableNotificationContent()
        notification.title = "Timer"
        notification.body = "Timer Done"
        notification.sound = UNNotificationSound(named: UNNotificationSoundName("Ring2x.m4a"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "TimerNotif", content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        timer?.stopTiming()
    }
    static func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
