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
        NSCalendarUnit.CalendarUnitWeekday.rawValue: "Weekdays"]

    var numberOfSections = Settings.silence ? 1 : 2
    let logo = UIImage(named: "Logo")!

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        settingsTableView = tableView
        tableView.addParallaxWithImage(logo, andHeight: logo.size.height)
        navigationController!.navigationBarHidden = true

        silenceSwitch.on = Settings.silence
        frequencyLabel.text = "Every \(Settings.frequency.rawValue) Minutes"
        repeatLabel.text = repeats[Settings.repeat.rawValue]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()

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

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }

    // MARK: Actions

    @IBAction func silenceSwitchToggled(sender: UISwitch) {
        Settings.silence = sender.on
        Settings.synchronize()
        updateTableViewForSilenceState(sender.on)
    }

    func updateTableViewForSilenceState(on: Bool) {
        if on {
            numberOfSections = 1
            tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
        } else {
            numberOfSections = 2
            tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
        }
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
