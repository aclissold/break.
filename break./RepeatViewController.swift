//
//  RepeatViewController.swift
//  break.
//
//  Created by Andrew Clissold on 8/29/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class RepeatViewController: UITableViewController {

    var previousCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repeat"
    }

    override func viewDidLayoutSubviews() {
        let raw = UInt(NSUserDefaults.standardUserDefaults().integerForKey("repeat"))
        let repeat = NSCalendarUnit.fromRaw(raw)!
        var indexPath: NSIndexPath!
        if repeat == .CalendarUnitDay {
            indexPath = NSIndexPath(forRow: 0, inSection: 0)
        } else if repeat == .CalendarUnitWeekday {
            indexPath = NSIndexPath(forRow: 1, inSection: 0)
        } else {
            fatalError("unknown repeat value")
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .Checkmark
        previousCell = cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectCellAtIndexPath(indexPath)
    }

    func selectCellAtIndexPath(indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if cell === previousCell { return }

        let repeat = (cell.contentView.subviews[0] as UILabel).text!

        switch repeat {
        case "Daily":
            Settings.repeat = .CalendarUnitDay
        case "Weekdays":
            Settings.repeat = .CalendarUnitWeekday
        default:
            Settings.repeat = .CalendarUnitWeekday
        }

        cell.accessoryType = .Checkmark

        previousCell?.accessoryType = .None
        previousCell = cell
    }

}
