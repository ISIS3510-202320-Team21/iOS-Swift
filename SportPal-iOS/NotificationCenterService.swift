//
//  NotificationCenterService.swift
//  SportPal
//
//  Created by Laura Monzon on 9/11/23.
//

import Foundation
import UIKit
import UserNotifications

class NotificationCenterService: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    func checkPermison(){
        let fechaAct = Date()
        let fechaNoti = fechaAct.addingTimeInterval(-5*60)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ settings in
            switch settings.authorizationStatus {
            case .denied:
                return
            case .authorized:
                self.dispatchNotification(title: "xD", body: "Sirvio", detalle: fechaNoti, identifier: "si")
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) {didAllow, error in if didAllow {
                    self.dispatchNotification(title: "xD", body: "Sirvio", detalle: fechaNoti, identifier: "si")
                }}
            default:
                return
            }
            
            
        }
    }
    
    func dispatchNotification(title: String, body: String, detalle: Date, identifier: String ){
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let hour = 21
        let minute = 17
        
        let calendar = Calendar.current
        // var dateComponents = calendar.dateComponents( [.year, .month, .day, .hour, .minute], from: detalle)
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        
    }
}
