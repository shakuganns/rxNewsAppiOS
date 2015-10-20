//
//  UserViewController.swift
//  rxNewsApp
//
//  Created by Shakugan on 15/10/19.
//  Copyright © 2015年 Shakugan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDataSource {
    
    var array = Array<AnyObject>()
    @IBOutlet weak var rxServiceTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        array = ["成绩查询","课表查询","一卡通查询","图书馆查询"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = rxServiceTable.dequeueReusableCellWithIdentifier("rxServiceCell")!
        let text = cell.viewWithTag(2) as! UILabel
        text.text = array[indexPath.row] as? String
        return cell
    }


}
