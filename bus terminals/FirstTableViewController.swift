//
//  FirstTableViewController.swift
//  bus terminals
//
//  Created by Nik on 16.04.16.
//  Copyright © 2016 Gafurov. All rights reserved.
//

import UIKit


class FirstTableViewController: UITableViewController {
    
    // ссылка на "откуда"
    @IBOutlet weak var StartPlaceOutlet: UITableViewCell!
    // ссылка на "куда"
    @IBOutlet weak var DestinationOutlet: UITableViewCell!
    // ссылка на "дату из барабана"
    @IBOutlet weak var PickedDateForCell: UIDatePicker!
    
    var whichCellWasPressed = Bool()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // creating NSDate for now
        let TodayDate = NSDate()
        PickedDateForCell.minimumDate = TodayDate
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    
    // кнопка для cell - "даты отправления", т.к. не получилось
    // default cell настроить на открытие PickerData
    // (возможна только ссылка , @IBAction нет)
    @IBOutlet weak var ButtonLabelChangeFor: UIButton!
    @IBOutlet weak var PickerDateCell: UITableViewCell!
    
    
    
    @IBAction func DatePickingButtonPressed(sender: UIButton) {
        
        // для скрытия/отображения ячейки с барабаном
        let check = PickerDateCell.hidden
        PickerDateCell.hidden = !check
        
    }
   
    
    
    
    @IBAction func DatePickerChanged(sender: UIDatePicker) {
        
        // форатирование отображаемой даты
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ru_RU")
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        let newDate = dateFormatter.stringFromDate(sender.date)
        
        // отображение выбранной даты
        ButtonLabelChangeFor.setTitle(String(newDate), forState: .Normal)
        
        
    }
    

    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        whichCellWasPressed
        
    }*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // передаем метки , какая именно кнопка была нажата
        let destinationVC = segue.destinationViewController as! DataShowTableViewController
        
        
        switch segue.identifier! {
        case "startCellSegue":
           
            
            destinationVC.whichCellWasPressed = false
            
           // NSLog("FIRST (1) CELL WAS PRESSED")
            
            
        case "destinationCellSegue":
            
            
            destinationVC.whichCellWasPressed = true
            
          //  NSLog("(2)SECOND CELL WAS PRESSED")

            
            
        default:break

            
        }
        
        
        
    }
    
    
    
    
    
}
