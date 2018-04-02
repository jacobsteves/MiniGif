//
//  About.swift
//  MiniGif
//
//  Created by Jacob Steves on 04/02/18.
//  Copyright © 2016 Jacob Steves. All rights reserved.
//

import Cocoa
import Foundation

class About: NSObject {
    @IBOutlet weak var aboutWindow: NSWindow!
    @IBOutlet weak var aboutIcon: NSImageView!
    @IBOutlet var aboutTextView: NSTextView!
    @IBOutlet weak var aboutOKButton: NSButton!
    @IBOutlet weak var resizer: Resizer!

    @IBAction func helpButtonClicked(_ sender: AnyObject) {
        aboutTextView.readRTFD(fromFile: Bundle.main.path(forResource: "HelpText", ofType: "rtf")!)
        aboutIcon.image = NSImage.init(imageLiteralResourceName: "AppIcon")
        resizer.resizerWindow.beginSheet(aboutWindow) { (response: NSModalResponse) in }
        aboutWindow.makeFirstResponder(aboutOKButton)
    }

    @IBAction func aboutOKClicked(_ sender: AnyObject) {
        resizer.resizerWindow?.endSheet(aboutWindow)
    }
}
