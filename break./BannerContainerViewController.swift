//
//  BannerContainerViewController.swift
//  break.
//
//  Created by Andrew Clissold on 9/16/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import UIKit
import iAd

class BannerContainerViewController: UIViewController, ADBannerViewDelegate {

    var bannerView: ADBannerView!
    var constraint: NSLayoutConstraint!

    override func viewDidLoad() {
        bannerView = ADBannerView(frame: CGRect(x: 0, y: 0, width: 320, height: 66))
        view.addSubview(bannerView)

        bannerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let height = bannerView.frame.size.height
        addConstraint("H:|-0-[bannerView]-0-|")
        addConstraint("V:[bannerView]-(\(-height))-|")

    }

    func addConstraint(format: String) {
        let options = NSLayoutFormatOptions.fromRaw(0)!
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            format, options: options, metrics: nil, views: ["bannerView": bannerView])
        view.addConstraints(constraints)
        if constraints.count == 1 {
            constraint = constraints.first! as NSLayoutConstraint
        }
    }

    override func viewDidAppear(animated: Bool) {
        updateInsets()
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        updateInsets()
    }

    func updateInsets() {
        let insets = UIEdgeInsets(top: settingsTableView.contentInset.top, left: 0, bottom: bannerView.frame.size.height, right: 0)
        let contentSize = CGSize(width: settingsTableView.frame.size.width, height: settingsTableView.frame.size.height + bannerView.frame.size.height)
        settingsTableView.contentSize = contentSize
        settingsTableView.contentInset = insets
        settingsTableView.scrollIndicatorInsets = insets
        constraint.constant = -bannerView.frame.size.height
    }

    // MARK: ADBannerViewDelegate

    func bannerViewDidLoadAd(banner: ADBannerView!) {
    }

    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
    }

}
