//
//  FrequencyViewController.swift
//  break.
//
//  Created by Andrew Clissold on 8/29/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit

class FrequencyViewController: UITableViewController {

    var previousCell: UITableViewCell?
    let frequencies = [20, 30, 60, 90]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frequency"
    }

    override func viewDidLayoutSubviews() {
        let frequency = userDefaults.integerForKey("frequency")
        for (index, element) in enumerate(frequencies) {
            if element == frequency {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                let cell = tableView.cellForRowAtIndexPath(indexPath)!
                cell.accessoryType = .Checkmark
                previousCell = cell
            }
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectCellAtIndexPath(indexPath)
    }

    func selectCellAtIndexPath(indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if cell === previousCell { return }

        if indexPath.section == 0 {
            Settings.frequency = Frequency(rawValue: frequencies[indexPath.row])!
            Settings.synchronize()
        }

        cell.accessoryType = .Checkmark

        previousCell?.accessoryType = .None
        previousCell = cell
    }

}
