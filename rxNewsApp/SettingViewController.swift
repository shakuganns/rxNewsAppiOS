//
//  SettingViewController.swift
//  rxNewsApp
//
//  Created by Shakugan on 15/10/19.
//  Copyright © 2015年 Shakugan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource {
    
    var array = Array<AnyObject>()
    @IBOutlet weak var settingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        array = [""]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCellWithIdentifier("settingCell")!
        return cell
    }

}
