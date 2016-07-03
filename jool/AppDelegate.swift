//
//  AppDelegate.swift
//  jool
//
//  Created by jangwonhee on 2016. 7. 3..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers: [String:WindowController] = [:] {
        didSet {
            print("windowControllers \(windowControllers)", terminator:"\n\n")
        }
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.openWindow(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("\(#function)", terminator:"\n\n")
    }
    
    func arrangementWindow(window: NSWindow) {
        for (key, windowController) in windowControllers {
            if window == windowController.window {
                windowControllers.removeValueForKey(key)
                if windowControllers.isEmpty {
                    NSApp.terminate(self)
                }
                return
            }
        }
    }
    
    @IBAction func openWindow(sender: AnyObject) {
        if let windowController = NSStoryboard(name: "Window", bundle: NSBundle.mainBundle()).instantiateControllerWithIdentifier("WindowController") as? WindowController {
            windowController.showWindow(self)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(closeWindow), name: NSWindowWillCloseNotification, object: windowController.window)
            
            windowControllers["\(unsafeAddressOf(windowController))"] = windowController
        }
    }
    
    func closeWindow(sender: AnyObject) {
        if let notification = sender as? NSNotification, let window = notification.object as? NSWindow where notification.name == NSWindowWillCloseNotification {
            return self.arrangementWindow(window)
        }
        
        if let window = sender as? NSWindow {
            return self.arrangementWindow(window)
        }
        
        if let windowController = sender as? WindowController, let window = windowController.window {
            return self.arrangementWindow(window)
        }
    }


}

