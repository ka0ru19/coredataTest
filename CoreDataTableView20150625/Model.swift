//
//  Model.swift
//  CoreDataTableView20150625
//
//  Created by 井上航 on 2015/06/25.
//  Copyright (c) 2015年 Wataru.I. All rights reserved.
//

import UIKit
import CoreData

class Model: NSManagedObject {
    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var info: String



}
