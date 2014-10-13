//
//  AppDelegate.swift
//  break.
//
//  Created by Andrew Clissold on 6/15/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

let globalTintColor = UIColor(red: 220.0/255, green: 47.0/255, blue: 43.0/255, alpha: 1)
let snooze = "Snooze"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Create a translucent background image for the navigation bar.
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        UIColor(white: 1, alpha: 0.85).setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Theme.
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor(white: 1, alpha: 0.2)
        appearance.translucent = true
        appearance.alpha = 0.2
        appearance.setBackgroundImage(image, forBarMetrics: .Default)
        appearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clearColor()]

        // Configure notifications.
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = snooze
        snoozeAction.title = snooze
        snoozeAction.activationMode = .Background

        let category = UIMutableUserNotificationCategory()
        category.identifier = snooze
        category.setActions([snoozeAction], forContext: .Default)
        category.setActions([snoozeAction], forContext: .Minimal)

        let categories = NSSet(object: category)
        let notificationSettings = UIUserNotificationSettings(forTypes: .Alert | .Sound, categories: categories)
        application.registerUserNotificationSettings(notificationSettings)

        // Force Settings to synchronize the first time the app is ever launched.
        if NSUserDefaults.standardUserDefaults().objectForKey("silence") == nil { // arbitrary key
            Settings.synchronize()
        }

        return true
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?,
    forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if identifier == snooze {
            // Schedule a new notification 9 minutes from now.
            let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
            var components = calendar.componentsInTimeZone(NSTimeZone.defaultTimeZone(), fromDate: NSDate())
            components.minute += 9
            let fireDate = calendar.dateFromComponents(components)!
            let notification = TypingBreakNotification(date: fireDate)

            UIApplication.sharedApplication().scheduleLocalNotification(notification)

            completionHandler()
        }
    }

}
