//
//  SettingsViewController.swift
//  break.
//
//  Created by Andrew Clissold on 6/16/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet var doNotDisturbSwitch: UISwitch

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
