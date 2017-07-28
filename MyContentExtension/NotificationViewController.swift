//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Nishant on 28/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        guard let attachment = notification.request.content.attachments.first else {
            
            return
        }
        
        // Our notificaion content operates outside the app, so we need to implement this.
        if attachment.url.startAccessingSecurityScopedResource() {
            
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let img = imageData {
                
                imageView.image = UIImage(data: img)
            }
        }
        
    }
    
    // Function for custom notification actions.
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        // Dismiss notification using custom notification actions.
        if response.actionIdentifier == "userAction" {
            
            completion(.dismissAndForwardAction)
            
        } else if response.actionIdentifier == "dismiss" {
            
            completion(.dismissAndForwardAction)
            
        }
    }

}

// After this ViewControllet we need to implement another function in the AppDelegate.swift
