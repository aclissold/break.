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

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        selectCellAtIndexPath(indexPath)
    }

    func selectCellAtIndexPath(indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        cell.accessoryType = .Checkmark

        if cell !== previousCell {
            previousCell?.accessoryType = .None
            previousCell = cell
        }
    }

}
