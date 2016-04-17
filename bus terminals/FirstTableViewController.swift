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
    
    // ссылка на "дата отправления"
    @IBOutlet weak var PickedDateForCell: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating NSDate for now
        let TodayDate = NSDate()
        PickedDateForCell.minimumDate = TodayDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // кнопка для cell - "даты отправления", т.к. не получилось
    // default cell настроить на открытие PickerData
    // (возможна только ссылка , @IBAction нет)
    @IBOutlet weak var ButtonLabelChangeFor: UIButton!
    
    @IBAction func DatePickingButtonPressed(sender: UIButton) {
        
        
        // Сторонний метод
        //  DatePickerDialog().show("Выбор даты") {
        //     (date) in
        //     sender.setTitle("\(date)", forState: .Normal)}
        
        PickedDateForCell.hidden = false
        
    }
    
    
    @IBAction func DatePickerChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ru_RU")
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        let newDate = dateFormatter.stringFromDate(sender.date)
        
        ButtonLabelChangeFor.setTitle(String(newDate), forState: .Normal)
        
        
        // для того чтобы скрыть барабан
        // вообще можно, динамически создавать 4 строку
        // для барабана и удалять ее по мере нажатия на
        // другой cell 
        // override touchesbegan не сработал
        // PickedDateForCell.hidden = true
        
    }
    
    
    
    
    
}
