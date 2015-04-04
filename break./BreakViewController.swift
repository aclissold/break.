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
        NSCalendarUnit.DayCalendarUnit.rawValue: "Daily",
        NSCalendarUnit.WeekdayCalendarUnit.rawValue: "Weekdays"]

    let logo = UIImage(named: "Logo")!

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView = tableView
        tableView.addParallaxWithImage(logo, andHeight: logo.size.height)
        navigationController!.navigationBarHidden = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animateWithDuration(0.4) {
            self.navigationController!.navigationBarHidden = true
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController!.navigationBar.layer.removeAllAnimations()

        UIView.animateWithDuration(0.4) {
            self.navigationController!.navigationBarHidden = false
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        }
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

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Settings.silence ? 1 : 2
    }

    // MARK: Actions

    @IBAction func silenceSwitchToggled(sender: UISwitch) {
        let silence = sender.on
        Settings.silence = silence
        if silence {
            tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
        } else {
            tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
        }
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
