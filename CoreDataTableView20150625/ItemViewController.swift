//
//  ListViewController.swift
//  CoreDataTableView20150625
//
//  Created by 井上航 on 2015/06/25.
//  Copyright (c) 2015年 Wataru.I. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {
    @IBOutlet weak var textFieldItem: UITextField!
    @IBOutlet weak var textFieldQuantity: UITextField!
    @IBOutlet weak var textFieldInfo: UITextField!
    
    var item: String = ""
    var quantity: String = ""
    var info: String = ""
//    var time: NSDate! = nil
    var existingItem: NSManagedObject!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 現在日時の取得
//        let today:NSDate = NSDate()
//        let formatter: NSDateFormatter = NSDateFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let time:NSDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .ShortStyle
        info = String(dateFormatter.stringFromDate(time)) // -> 2014/06/24 11:14
        println(info)
        
        if (existingItem != nil) {
            textFieldItem.text = item
            textFieldQuantity.text = quantity
            textFieldInfo.text = info
        } else {
            textFieldInfo.text = info
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contxt)
        
        if (existingItem != nil) {
            
            existingItem.setValue(textFieldItem.text as String, forKey: "item")
            existingItem.setValue(textFieldQuantity.text as String, forKey: "quantity")
            existingItem.setValue(textFieldInfo.text as String, forKey: "info")
            
            
        } else {
            
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: contxt)
            newItem.item = textFieldItem.text
            newItem.quantity = textFieldQuantity.text
            newItem.info = textFieldInfo.text
            
            println(newItem)
        }
        contxt.save(nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
