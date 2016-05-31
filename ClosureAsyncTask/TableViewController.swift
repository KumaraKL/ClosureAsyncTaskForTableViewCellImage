//
//  TableViewController.swift
//  ClosureAsyncTask
//
//  Created by Kumar on 31/05/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let imgLists = ["https://img1.goodfon.ru/wallpaper/big/6/a2/defense-of-the-ancients-dota-599.jpg","http://www.desivalley.com/wp-content/uploads/2011/09/86.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1000
    }

    typealias CompletionHandler = (image: UIImage) -> Void
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: testCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! testCell
        downloadFileFromURL(NSURL(string: imgLists[indexPath.row % 2])!, completionHandler:{(img) in
             dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imgView.image = img
             })
            })
        // Configure the cell...
        cell.lblTitle.text = "Row \(indexPath.row)"

        return cell
    }
 
    func downloadFileFromURL(url1: NSURL?,completionHandler: CompletionHandler) {
        // download code.
        if let url = url1{
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let data = NSData(contentsOfURL: url)
            if data != nil {
                print("image downloaded")
                completionHandler(image: UIImage(data: data!)!)
            }
            }
        }
    }
    
    
        /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
