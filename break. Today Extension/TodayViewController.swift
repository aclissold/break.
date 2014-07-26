//
//  TodayViewController.swift
//  break. Today Extension
//
//  Created by Andrew Clissold on 7/26/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(.NoData)
    }

}
