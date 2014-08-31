//
//  SettingsViewController.swift
//  break.
//
//  Created by Andrew Clissold on 6/16/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var silenceSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var untilCell: UITableViewCell!
    @IBOutlet weak var untilLabel: UILabel!
    @IBOutlet weak var untilDateLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!

    let untilCellID = "untilCell"
    let datePickerIndexPath = NSIndexPath(forRow: 1, inSection: 1)

    var datePickerIsVisible = true

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    let frequencies = [20: "20", 30: "30", 60: "60", 90: "90"]
    let repeats: [UInt: String] =
        [NSCalendarUnit.DayCalendarUnit.toRaw(): "Daily",
         NSCalendarUnit.WeekdayCalendarUnit.toRaw(): "Weekdays"]

    override func viewDidLayoutSubviews() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let frequency = defaults.integerForKey("frequency")
        let repeat = defaults.integerForKey("repeat")
        let silence = defaults.boolForKey("silence")
        silenceSwitch.on = silence
        toggleUntilCell(silence)
        frequencyLabel.text = "Every \(frequencies[frequency]!) minutes"
        repeatLabel.text = repeats[UInt(repeat)]
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

    @IBAction func silenceSwitchToggled(sender: UISwitch) {
        Settings.silence = sender.on
        toggleUntilCell(sender.on)
    }

    func toggleUntilCell(on: Bool) {
        if on {
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
