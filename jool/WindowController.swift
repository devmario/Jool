//
//  WindowController.swift
//  jool
//
//  Created by jangwonhee on 2016. 7. 3..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Cocoa
import SwiftColors

class WindowController: NSWindowController {
    static let minimumWidth: CGFloat = 500
    static let minimumHeight: CGFloat = 700

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.backgroundColor = NSColor(hexString: "fff")
    }
    
    deinit {
        print("\(#function) \(self)", terminator:"\n\n")
    }
}

extension WindowController: NSWindowDelegate {
    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
        var frameSize = frameSize
        if frameSize.width < WindowController.minimumWidth {
            frameSize.width = WindowController.minimumWidth
        }
        if frameSize.height < WindowController.minimumHeight {
            frameSize.height = WindowController.minimumHeight
        }
        return frameSize
    }
}