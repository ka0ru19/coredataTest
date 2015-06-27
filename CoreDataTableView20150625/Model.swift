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

//    @NSManaged var recordTime: NSDate
//
//    var sectionIdentifier:String{
//        get{
//            self.willAccessValueForKey("sectionIdentifier")
//            var tmp:String? = self.primitiveValueForKey("sectionIdentifier") as? String
//            self.didAccessValueForKey("sectionIdentifier")
//            
//            if tmp == nil{
//                let calendar:NSCalendar = NSCalendar.currentCalendar()
//                let components:NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay, fromDate: self.recordTime )
//                
//                tmp = String(format: "%ld", components.year * 10000 + components.month * 100 + components.day)
//                self.setPrimitiveValue(tmp, forKey: "sectionIdentifier")
//            }
//            
//            return tmp!
//        }
//    }

}
