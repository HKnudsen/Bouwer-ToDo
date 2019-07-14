//
//  Category.swift
//  Bouwer ToDo
//
//  Created by Henrik Bouwer Knudsen on 19/05/2019.
//  Copyright © 2019 Henrik Bouwer Knudsen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    //Defines forward realtionship
    let items = List<Item>()
    
}
