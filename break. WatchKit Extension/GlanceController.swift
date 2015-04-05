//
//  GlanceController.swift
//  break. WatchKit Extension
//
//  Created by Andrew Clissold on 4/4/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var timer: WKInterfaceTimer!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()

        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let date = calendar.dateByAddingUnit(.SecondCalendarUnit, value: 60, toDate: today, options: NSCalendarOptions.SearchBackwards)!
        timer.setDate(date)
        timer.start()
    }

}
