//
//  TableViewController.swift
//  CoreDataTableView20150625
//
//  Created by 井上航 on 2015/06/25.
//  Copyright (c) 2015年 Wataru.I. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    var mylist:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("テスト。TBのviewDidLoad完了")
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName:"List")
        
        mylist = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
        
        ("テスト。TBのviewDidAppearALL完了")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier? == "update" {
            var indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var selectedItem: NSManagedObject = mylist[indexPath.row] as NSManagedObject
            let IVC: ItemViewController = segue.destinationViewController as ItemViewController
            
            IVC.item = selectedItem.valueForKey("item") as String
            IVC.quantity = selectedItem.valueForKey("quantity") as String
            IVC.info = selectedItem.valueForKey("info") as String
//            IVC.time = selectedItem.valueForKey("recordTime") as NSDate

            IVC.existingItem = selectedItem
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        
        let CellID : NSString = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        if let ip = indexPath {
            var data : NSManagedObject = mylist[ip.row] as NSManagedObject
            var itemText = data.valueForKeyPath("item") as String
            var qnt = data.valueForKeyPath("quantity") as String
            var info = data.valueForKeyPath("info") as String
//            var time = data.valueForKey("recordTime") as NSDate
            cell.textLabel?.text = itemText
            cell.detailTextLabel?.text = "\(qnt), date:\(info)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable
        return true
    }
    
    //編集モード
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView {
                context.deleteObject(mylist[indexPath!.row] as NSManagedObject)
                mylist.removeAtIndex(indexPath!.row)
                tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var error: NSError? = nil
            if !context.save(&error) {
                abort()
            }
        }
    }
//    
//    var _fetchedResultsController: NSFetchedResultsController? = nil
//    var fetchedResultsController: NSFetchedResultsController {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        
//        // get start day and last day for request predicate
//        
//        let today:NSDate = NSDate()
//        let formatter: NSDateFormatter = NSDateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        
//        // calendar and get this month startday and lastday
//        
//        let calendar = NSCalendar.currentCalendar()
//        var components = calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit, fromDate: today)
//        components.day = 1
//        components.hour = 0
//        components.minute = 0
//        components.second = 0
//        let startDate:NSDate? = calendar.dateFromComponents(components)
//        let range = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: today)
//        components.day = range.length
//        components.hour = 23
//        components.minute = 59
//        components.second = 59
//        let lastDate:NSDate? = calendar.dateFromComponents(components)
//        
//        // get coredata instances
//        
//        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        let context: NSManagedObjectContext? = appDel.managedObjectContext
//        let sort:NSSortDescriptor = NSSortDescriptor(key: "recordTime", ascending: false)
//        let predicate:NSPredicate? = NSPredicate(format: "%@ <= recordTime && recordTime <= %@", startDate!, lastDate!)
//        
//        let request = NSFetchRequest(entityName: "Record")
//        request.predicate = predicate
//        request.sortDescriptors = [sort]
//        request.returnsObjectsAsFaults = false
//        
//        // get an instance of NSFetchedResultsController
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: "sectionIdentifier", cacheName: nil)
//        _fetchedResultsController = aFetchedResultsController
//        
//        var error: NSError? = nil
//        if !_fetchedResultsController!.performFetch(&error) {
//            abort()
//        }
//        return _fetchedResultsController!
//    }
//    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var dateString = ""
//        if let sec = self.fetchedResultsController.sections as? [NSFetchedResultsSectionInfo] {
//            dateString = sec[section].name!
//        }
//        return dateString
//    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //println("numberOfSectionsInTableView実行。返り値１")
//        return mylist.count
        return 1
    }
    
    //指定されたセクション(section)のrowの数を戻り値として返す
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println("指定されたセクション(section)のrowの数。戻り値\(mylist.count)")
//        return mylist[section].numberOfObjects
        return mylist.count
    }

    
}