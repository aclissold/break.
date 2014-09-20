//
//  AppDelegate.swift
//  break.
//
//  Created by Andrew Clissold on 6/15/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

let globalTintColor = UIColor(red: 220.0/255, green: 47.0/255, blue: 43.0/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Theme.
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clearColor()]

        // Configure notifications.
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = "Snooze"
        snoozeAction.title = "Snooze"
        snoozeAction.activationMode = .Background

        let category = UIMutableUserNotificationCategory()
        category.identifier = "Snooze"
        category.setActions([snoozeAction], forContext: .Default)
        category.setActions([snoozeAction], forContext: .Minimal)

        let categories = NSSet(object: category)
        let notificationSettings = UIUserNotificationSettings(forTypes: .Alert | .Sound, categories: categories)
        application.registerUserNotificationSettings(notificationSettings)

        return true
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?,
    forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        p("Received \(identifier)")
        completionHandler()
    }

}
