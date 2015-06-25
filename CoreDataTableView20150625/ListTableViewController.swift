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
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName:"List")
        
        mylist = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier? == "update" {
            var indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var selectedItem: NSManagedObject = mylist[indexPath.row] as NSManagedObject
            let IVC: ItemViewController = segue.destinationViewController as ItemViewController
            
            IVC.item = selectedItem.valueForKey("item") as String
            IVC.quantity = selectedItem.valueForKey("quantity") as String
            IVC.info = selectedItem.valueForKey("info") as String
            IVC.existingItem = selectedItem
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //println("numberOfSectionsInTableView実行。返り値１")
        return 1
    }
    
    //指定されたセクション(section)のrowの数を戻り値として返す
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println("指定されたセクション(section)のrowの数。戻り値\(mylist.count)")
        return mylist.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        
        let CellID : NSString = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        if let ip = indexPath {
            var data : NSManagedObject = mylist[ip.row] as NSManagedObject
            var itemText = data.valueForKeyPath("item") as String
            var qnt = data.valueForKeyPath("quantity") as String
            var info = data.valueForKeyPath("info") as String
            cell.textLabel?.text = itemText
            cell.detailTextLabel?.text = "\(qnt), \(info)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable
        return true
    }
    
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
    
}