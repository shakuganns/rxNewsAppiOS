//
//  CollageViewController.swift
//  
//
//  Created by Shakugan on 15/10/5.
//
//

import UIKit

class CollageViewController: UIViewController,UITableViewDataSource {

    var newsArray = Array<AnyObject>()
    var articleID = Int()
    @IBOutlet weak var collageTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collageTable.header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.initData()
        })
        self.collageTable.footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.loadMoreData(self.articleID)
        })
        self.collageTable.header.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let vc = segue.destinationViewController as! WebViewController
        vc.id = cell.tag
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = collageTable.dequeueReusableCellWithIdentifier("collageCell")
        cell!.tag = newsArray[indexPath.row].objectForKey("id") as! Int
        let title = cell!.contentView.viewWithTag(1) as! UILabel
        let click = cell!.contentView.viewWithTag(2) as! UILabel
        let info = cell!.contentView.viewWithTag(3) as! UILabel
        let time = cell!.contentView.viewWithTag(4) as! UILabel
        title.text = newsArray[indexPath.row].objectForKey("title") as? String
        click.text = String(stringInterpolationSegment: newsArray[indexPath.row].objectForKey("click") as! Int)
        info.text = newsArray[indexPath.row].objectForKey("info") as? String
        time.text = newsArray[indexPath.row].objectForKey("created_at") as? String
        return cell!
    }
    
    func initData() {
        let afManager = AFHTTPRequestOperationManager()
        let op = afManager.GET("http://app.ecjtu.net/api/v1/schoolnews", parameters: nil,
            success: { (operation:AFHTTPRequestOperation, response:AnyObject) -> Void in
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response as! NSData , options:NSJSONReadingOptions() )
                self.newsArray = json?.objectForKey("articles") as! Array<AnyObject>
                self.articleID = self.newsArray[self.newsArray.count-1].objectForKey("id") as! Int
                print(self.newsArray)
                for index in 0...self.newsArray.count-1 {
                    let id:AnyObject! = self.newsArray[index].objectForKey("id")
                    print(id)
                }
                self.collageTable.reloadData()
                self.collageTable.header.endRefreshing()
            },
            failure:{ (operation:AFHTTPRequestOperation, error:NSError) -> Void in
                self.collageTable.header.endRefreshing()
        })
        op!.responseSerializer = AFHTTPResponseSerializer()
        op!.start()
    }

    func loadMoreData(id:Int) {
        let afManager = AFHTTPRequestOperationManager()
        let op = afManager.GET("http://app.ecjtu.net/api/v1/schoolnews?until=\(id)", parameters: nil,
            success: { (operation:AFHTTPRequestOperation, response:AnyObject) -> Void in
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response as! NSData , options:NSJSONReadingOptions() )
                let count = json?.objectForKey("count") as! Int
                if count==0 {
                    self.collageTable.footer.endRefreshing()
                    return
                }
                var array = json?.objectForKey("articles") as! Array<AnyObject>
                for index in 0...count-1 {
                    self.newsArray.append(array[index])
                }
                self.articleID = self.newsArray[self.newsArray.count-1].objectForKey("id") as! Int
                for index in 0...self.newsArray.count-1 {
                    let id:AnyObject! = self.newsArray[index].objectForKey("id")
                    print(id)
                }
                self.collageTable.reloadData()
                self.collageTable.footer.endRefreshing()
            },
            failure:{ (operation:AFHTTPRequestOperation, error:NSError) -> Void in
                self.collageTable.footer.endRefreshing()
        })
        op!.responseSerializer = AFHTTPResponseSerializer()
        op!.start()
    }
}
