//
//  AppDelegate.swift
//  MiniGif
//
//  Created by Jacob Steves on 04/02/18.
//  Copyright © 2018 Jacob Steves. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var statusItem : NSStatusItem? = nil
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var resizer: Resizer!
    @IBOutlet weak var about: About!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusItem?.image = NSImage(named: "MiniGifIcon");
        
        let hasShownAboutWindowForFirstLaunchDefaultsKey =
            "MiniGifHasShownAboutWindowForFirstLaunch"

        let hasShownAbout = UserDefaults.standard.bool(forKey: hasShownAboutWindowForFirstLaunchDefaultsKey)

        if !hasShownAbout {
            about.helpButtonClicked(self)
            UserDefaults.standard.set(true, forKey: hasShownAboutWindowForFirstLaunchDefaultsKey)
        }

        window.delegate = self
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        /*  Clean up our copied GIF (in /tmp) if we can */

        if let gifPath = resizer.inputGIFPath {
            try? FileManager.default.removeItem(atPath: gifPath)
        }
    }

    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        guard let utiType = try? NSWorkspace.shared().type(ofFile: filename) else { return false }

        if utiType == (kUTTypeGIF as String) {
            resizer.loadGIFAtPath(pathToGIF: filename)

            return true
        }

        return false
    }
    
    @objc func showResizerWindow(_ sender: Any?) {
        resizer.resizerWindow.setIsVisible(true)
    }
    
    @objc func hideResizerWindow() {
        resizer.resizerWindow.setIsVisible(false)
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Resize", action: #selector(AppDelegate.showResizerWindow(_:)), keyEquivalent: "R"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
}
