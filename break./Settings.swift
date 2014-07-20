//
//  Settings.swift
//  break.
//
//  Created by Andrew Clissold on 7/19/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import Foundation

struct Settings {
    static var silence:   Bool           = false      {didSet{synchronize()}}
    static var until:     NSDate         = NSDate()   {didSet{synchronize()}}
    static var frequency: NSTimeInterval = 60 * 60    {didSet{synchronize()}}
    static var from:      NSDate         = NSDate()   {didSet{synchronize()}}
    static var to:        NSDate         = NSDate()   {didSet{synchronize()}}
    static var repeat:    String         = "Weekdays" {didSet{synchronize()}}
}

func synchronize() {
    println("Should update user defaults")
}