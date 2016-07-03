//
//  ViewController.swift
//  jool
//
//  Created by jangwonhee on 2016. 7. 3..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Cocoa
import SwiftColors
import SwiftyJSON

class ViewController: NSViewController {
    var jsonDataItem:JsonDataItem = JsonDataItem(key: nil, json:JSON.parse("{\"a\":\"b\",\"c\":[1,2,3.02],\"d\":\"e\",\"f\":true,\"g\":null}"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
}

extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(outlineView:NSOutlineView, numberOfChildrenOfItem item:AnyObject?) -> Int {
        guard let data = item as? JsonDataItem else {
            return 1
        }
        return data.numberOfChildren()
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        guard let data = item as? JsonDataItem else {
            return self.jsonDataItem
        }
        
        return data.childAtIndex(index)!
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        guard let data = item as? JsonDataItem else {
            return true
        }
        
        return data.numberOfChildren() > 0
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn: NSTableColumn?, byItem:AnyObject?) -> AnyObject? {
        guard let data = byItem as? JsonDataItem else {
            return nil
        }
        
        if objectValueForTableColumn?.title == "key" {
            if let key = data.key { return key }
        } else if objectValueForTableColumn?.title == "type" {
            return data.type
        } else if objectValueForTableColumn?.title == "value" {
            if let text = data.text { return text }
        }
        
        return nil
    }
}
