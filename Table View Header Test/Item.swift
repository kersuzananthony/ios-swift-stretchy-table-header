//
//  Item.swift
//  Table View Header Test
//
//  Created by Kersuzan on 28/12/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import Foundation

class Item {
    
    private var _title: String!
    private var _subTitle: String!
    
    var title: String {
        get {
            return self._title
        }
    }
    
    var subTitle: String {
        return self._subTitle
    }
    
    init(title: String, subTitle: String) {
        self._title = title
        self._subTitle = subTitle
    }
    
    
}