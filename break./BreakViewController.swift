//
//  SettingsViewController.swift
//  break.
//
//  Created by Andrew Clissold on 6/16/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

weak var settingsTableView: UITableView! // for BannerContainerViewController

class BreakViewController: UITableViewController {

    @IBOutlet weak var silenceSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!

    let frequencies = [20: "20", 30: "30", 60: "60", 90: "90"]
    let repeats: [UInt: String] = [
        NSCalendarUnit.DayCalendarUnit.toRaw(): "Daily",
        NSCalendarUnit.WeekdayCalendarUnit.toRaw(): "Weekdays"]

    let logo = UIImage(named: "Logo")

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView = tableView
        tableView.addParallaxWithImage(logo, andHeight: logo.size.height)
    }

    override func viewDidLayoutSubviews() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let frequency = defaults.integerForKey("frequency")
        let repeat = defaults.integerForKey("repeat")
        let silence = defaults.boolForKey("silence")

        silenceSwitch.on = silence
        frequencyLabel.text = "Every \(frequency) minutes"
        repeatLabel.text = repeats[UInt(repeat)]
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    @IBAction func silenceSwitchToggled(sender: UISwitch) {
        Settings.silence = sender.on
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
