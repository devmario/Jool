//
//  FileSystemItem.swift
//  NSOutlineViewInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

public class FileSystemItem: NSObject {
    
    var relativePath: String
    var parent: FileSystemItem?
    
    lazy var children: [FileSystemItem]? = {
        let fileManager = NSFileManager.defaultManager()
        let fullPath = self.fullPath()
        var isDir = ObjCBool(false)
        let valid = fileManager.fileExistsAtPath(fullPath as String, isDirectory: &isDir)
        var newChildren: [FileSystemItem] = []
        
        if (valid && isDir.boolValue) {
            let array: [AnyObject]?
            do {
                array = try fileManager.contentsOfDirectoryAtPath(fullPath as String)
            } catch _ {
                array = nil
            }
            
            if let ar = array as? [String] {
                for contents in ar {
                    let newChild = FileSystemItem(path: contents, parent: self)
                    newChildren.append(newChild)
                }
            }
            return newChildren
        } else {
            return  nil
        }
    }()
    
    public override var description: String {
        return "FileSystemItem:\(relativePath)"
    }
    
    init(path: NSString, parent: FileSystemItem?) {
        self.relativePath = path.lastPathComponent.copy() as! String
        self.parent = parent
    }
    
    class var rootItem: FileSystemItem {
        get {
            return FileSystemItem(path:"/", parent: nil)
        }
    }
    
    public func numberOfChildren() -> Int {
        guard let children = self.children else { return 0 }
        return children.count
    }
    
    public func childAtIndex(n: Int) -> FileSystemItem? {
        guard let children = self.children else { return nil }
        return children[n]
    }
    
    public func fullPath() -> NSString {
        guard let parent = self.parent else { return relativePath }
        return parent.fullPath().stringByAppendingPathComponent(relativePath as String)
    }
}