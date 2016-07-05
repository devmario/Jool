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
import Alamofire

class ViewController: NSViewController {
    @IBOutlet var responseView:NSOutlineView?
    @IBOutlet var urlField:NSTextField?
    @IBOutlet var methodPopup:NSPopUpButton?
    @IBOutlet var requestButton:NSButton?
    
    var method:String = Method.GET.rawValue
    
    var jsonDataItem:JsonDataItem = JsonDataItem(key: nil, json:JSON.parse(""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func responseData(data:NSData?) -> (success:Bool, error:NSError?, json:JSON) {
        if data == nil {
            return (false, nil, JSON.null)
        }
        let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
        if body == nil {
            return (false, nil, JSON.null)
        } else if body!.isEqualToString("") {
            return (false, nil, JSON.null)
        }
        let json = JSON.parse(body as! String)
        
        if json.error != nil {
            return (false, json.error, JSON.null)
        }
        return (true, nil, json)
    }
    
    @IBAction func changeMethod(sender:AnyObject) {
        if let menu = sender as? NSMenuItem {
            method = menu.title
        }
    }
    
    @IBAction func request(sender:AnyObject) {
        self.requestButton?.enabled = false
        guard let url = urlField?.stringValue else { return }
        guard let method = Method(rawValue:method) else { return }
        Alamofire.request(method, url, parameters: [:]).response { request, response, data, error in
            let response = self.responseData(data)
            self.jsonDataItem = JsonDataItem(key: nil, json:response.json)
            
            self.responseView?.reloadData()
            self.requestButton?.enabled = true
        }
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
