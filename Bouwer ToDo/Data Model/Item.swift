//
//  Item.swift
//  Bouwer ToDo
//
//  Created by Henrik Bouwer Knudsen on 19/05/2019.
//  Copyright © 2019 Henrik Bouwer Knudsen. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //Inverse relationship that links each item back to a parent category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
