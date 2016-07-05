//
//  JsonDataItem.swift
//  jool
//
//  Created by jangwonhee on 2016. 7. 3..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Foundation
import SwiftyJSON

public class JsonDataItem: NSObject {
    
    var key: String?
    var json: JSON?
    
    lazy var type: String = {
        if let type = self.json?.type {
            switch type {
            case .Number:
                return "Number"
            case .String:
                return "String"
            case .Bool:
                return "Bool"
            case .Array:
                return "Array"
            case .Dictionary:
                return "Dictionary"
            case .Null:
                return "Null"
            case .Unknown:
                return "Unknown"
            }
        }
        return "Unknown"
    } ()
    
    lazy var text: String? = {
        if let array = self.json?.array {
            return "(\(array.count) items)"
        }
        if let dictionary = self.json?.dictionary {
            return "(\(dictionary.count) items)"
        }
        return self.json?.description
    } ()
    
    lazy var children: [JsonDataItem]? = {
        var newChildren: [JsonDataItem] = []
        if let dict = self.json?.dictionary {
            for (key, json) in dict {
                newChildren.append(JsonDataItem(key:key, json:json))
            }
        } else if let array = self.json?.array {
            for json in array {
                newChildren.append(JsonDataItem(key:nil, json:json))
            }
        }
        return  newChildren
    } ()
    
    init(key:String?, json:JSON?) {
        self.key = key
        self.json = json
    }
    
    public func numberOfChildren() -> Int {
        guard let children = self.children else { return 0 }
        return children.count
    }
    
    public func childAtIndex(n: Int) -> JsonDataItem? {
        guard let children = self.children else { return nil }
        return children[n]
    }
}