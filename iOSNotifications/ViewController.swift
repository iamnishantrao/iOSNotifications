//
//  ViewController.swift
//  iOSNotifications
//
//  Created by Nishant on 28/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request Permission for User Notifications on initial loading of app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (request, error) in
            
            if request {
                
                print("Notification Access granted.")
            } else {
                
                print(error.debugDescription)
            }
        
        })
        
    }

    // Function to send notification when button is pressed.
    @IBAction func notificationButtonPressed(_ sender: Any) {
        
        scheduleNotification(inSeconds: 5, completion: { success in
            
            if success {
                
                print("Notification Scheduled Successfully")
            } else {
                
                print("Error Scheduling Notification")
            }
        
        })
    }
    
    // Schedule notifications.
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let notifyImage = "negan"
        
        guard let imageUrl = Bundle.main.url(forResource: notifyImage, withExtension: "gif") else {
            
            completion(false)
            return
        }
        
        // Create attachment for the notification.
        var attachment: UNNotificationAttachment!
        attachment = try! UNNotificationAttachment(identifier: "newNotification", url: imageUrl, options: .none)
        
        // Create Mutable Notification.
        let notify = UNMutableNotificationContent()
        
        // For NotificationContentExtension Only.
        // UNCOMMENT THE LINE BELOW CUSTOM NOTIFICATION.
//        notify.categoryIdentifier = "myNotificationCategory"
        
        notify.title = "New Notification"
        notify.subtitle = "iOS 10 Notifications Example"
        notify.body = "Notifications in iOS 10 are great."
        notify.attachments = [attachment]
        
        let notifyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "newNotification", content: notify, trigger: notifyTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil {
                
                print(error.debugDescription)
                completion(false)
                
            } else {
                
                completion(true)
            }
        
        })
    }
}

 
