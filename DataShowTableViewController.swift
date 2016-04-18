//
//  DataShowTableViewController.swift
//  bus terminals
//
//  Created by Nik on 16.04.16.
//  Copyright © 2016 Gafurov. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataShowTableViewController: UITableViewController , UISearchResultsUpdating {

    // SearchController - поиск
    var SearchController : UISearchController!
    // часть данных после перехода по segue
    var citiesByPressingCell : JSON = []
    // переменная для определения ячейки перехода (segue)
    // false - start ячейка |true - destination cell
    var whichCellWasPressed = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.citiesByPressingCell = parseJSON()
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //search settings
    func searchSettings() {
        SearchController = UISearchController(searchResultsController: nil)
        SearchController.dimsBackgroundDuringPresentation = false
        SearchController.searchResultsUpdater = self
        tableView.tableHeaderView = SearchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
  //          filterContent(searchText)
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Table view data source

    func parseJSON()->(JSON) {
    
        let path : String = NSBundle.mainBundle().pathForResource("allStations", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        //let jsonData = NSData(contentsOfURL: "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/ce9e69ded1fb5d35dad6fcce1c60920da7c7659e/allStations.json")!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        // в зависимости от whichCellWasPressed - выбирается часть данных
        var citiesByPressingCell = readableJSON
         
        if whichCellWasPressed {
        
            citiesByPressingCell = readableJSON["citiesTo"]
        } else {
        
            citiesByPressingCell = readableJSON["citiesFrom"]
        }
       
        return citiesByPressingCell
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // по количеству городов
        return citiesByPressingCell.count
    }

    override func tableView
        // #warning Incomplete implementation, return the number of rows
        //return filteredStations[].count
        
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //   cell.textLabel?.text = citiesTo[""][indexPath.section].stations[indexPath.row].station
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell

    
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
