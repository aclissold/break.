//
//  FromToViewController.swift
//  break.
//
//  Created by Andrew Clissold on 8/29/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class FromToViewController: UITableViewController {

    var datePickerIsVisible = false
    let datePickerIndexPath = NSIndexPath(forRow: 0, inSection: 1)

    override func viewDidLoad() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if !datePickerIsVisible {
            tableView.beginUpdates()
            tableView.insertRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
            tableView.endUpdates()

            datePickerIsVisible = true
        }
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if datePickerIsVisible {
            return 1
        } else {
            return 0
        }
    }

}
