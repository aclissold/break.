//
//  SettingsViewController.swift
//  break.
//
//  Created by Andrew Clissold on 6/16/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet var silenceSwitch: UISwitch
    @IBOutlet var datePicker: UIDatePicker
    @IBOutlet var untilCell: UITableViewCell
    @IBOutlet var untilLabel: UILabel
    @IBOutlet var untilDateLabel: UILabel

    let untilCellID = "untilCell"
    let datePickerIndexPath = NSIndexPath(forRow: 1, inSection: 1)

    var datePickerIsVisible = true

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)

        if cell.reuseIdentifier == untilCellID {
            let datePickerIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
            toggleDatePicker()
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if !datePickerIsVisible && section == 1 {
            return 1
        } else {
            return section + 1 // convenient coincidence
        }

    }

    @IBAction func toggleUntilCell(sender: UISwitch) {
        if sender.on {
            untilCell.userInteractionEnabled = true
            untilLabel.textColor = UIColor.blackColor()
            untilDateLabel.textColor = UIColor.blackColor()
        } else {
            untilCell.userInteractionEnabled = false
            untilLabel.textColor = UIColor.lightGrayColor()
            untilDateLabel.textColor = UIColor.lightGrayColor()
            if datePickerIsVisible {
                toggleDatePicker()
            }
        }
    }

    func toggleDatePicker() {
        tableView.beginUpdates()

        if datePickerIsVisible {
            datePickerIsVisible = !datePickerIsVisible
            tableView.deleteRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
        } else {
            datePickerIsVisible = !datePickerIsVisible
            tableView.insertRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
        }

        tableView.endUpdates()
    }

    override func viewDidLoad() {
        toggleDatePicker()
    }

}
