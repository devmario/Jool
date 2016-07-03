//
//  WindowController.swift
//  jool
//
//  Created by jangwonhee on 2016. 7. 3..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    deinit {
        print("\(#function) \(self)", terminator:"\n\n")
    }
}