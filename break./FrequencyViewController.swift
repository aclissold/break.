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
    let timeIntervals: [NSTimeInterval] = [20*60, 30*60, 60*60, 90*60]

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        selectCellAtIndexPath(indexPath)
    }

    func selectCellAtIndexPath(indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if cell === previousCell { return }

        if indexPath.section == 0 {
            Settings.frequency = timeIntervals[indexPath.row]
        }

        cell.accessoryType = .Checkmark

        previousCell?.accessoryType = .None
        previousCell = cell
    }

}
