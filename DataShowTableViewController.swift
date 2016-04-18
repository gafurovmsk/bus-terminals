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

    // внутренний класс для станций
    class Station {
        
        var countryTitle = ""
        var cityTitle = ""
        var regionTitle = ""
        var stationTitle = ""
        
    }
    
    // класс для оформления секции (т.е. список станций в одном городе)
    class Section {
        
        var countryTitle = ""
        var cityTitle = ""
        var regionTitle = ""
        var stationTitle = [""]
    }
    
    //MARK: - variables
    
    
    // SearchController - поиск
    var SearchController : UISearchController!
    // нужная часть allStation.json
    var citiesOnJSONFormat : JSON = []
    // переменная для определения ячейки перехода (segue)
    // false - start ячейка |true - destination cell
    var whichCellWasPressed = Bool()
    // входящий массив станций после парсинга
    var stationsParsed = [Station]()
    // преобразованный массив станций для размещения в секциях таблицы
    var sectionsParsed = [Section]()
    // результаты поиска
    var searchResult = [Station]()
    
    var dataForSegue = Station()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //parseJSON(&self.citiesOnJSONFormat)
        
            }

    // MARK: - Table view data source
    
    func parseJSON(inout citiesByPressingCell: JSON) ->() {
        
        let path : String = NSBundle.mainBundle().pathForResource("allStations", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        //let jsonData = NSData(contentsOfURL: "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/ce9e69ded1fb5d35dad6fcce1c60920da7c7659e/allStations.json")!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        // в зависимости от whichCellWasPressed - выбирается часть данных
        // var citiesByPressingCell : JSON
        
        if whichCellWasPressed {
            
            citiesByPressingCell = readableJSON["citiesTo"]
            
        } else {
            
            citiesByPressingCell = readableJSON["citiesFrom"]
            
        }
        
        //выстаскиваем значения стаций и региона для каждого конкретного города
        for city in citiesByPressingCell {
            
            for station in city.1["stations"] {
                
                let tempStation = Station()
                
                //вытаскиваем значения города, страны, региона, станции и тип станции
                tempStation.countryTitle = station.1["countryTitle"].string!
                tempStation.cityTitle = station.1["cityTitle"].string!
                tempStation.regionTitle = station.1["regionTitle"].string!
                tempStation.stationTitle = station.1["stationTitle"].string!
                
                
                //добавляем в массив для обработанных станций
                stationsParsed.append(tempStation)
                
                
                // на самом деле к этому моменту, уже JSON стал понятен
                // и можно было обойтись без его хранения в массивах типа Station
                // UPD: оказалось не всегда это хорошо:
            }
            
        }
        
        
    }

    
    //формируем массив секций
    func creatingSectionsBy(stations: [Station]) {
        
        // переменная для новой секции
        var newSection : Section!
        
        var lastCityTitle = ""
        
        for (i,value) in stations.enumerate() {
            // перевод безимянных в конец
            if value.cityTitle != lastCityTitle {
                
                if newSection != nil {
                    sectionsParsed.append(newSection)
                }
                // добавление
                newSection = Section()
                
                newSection.cityTitle = value.cityTitle
                newSection.countryTitle = value.countryTitle
                newSection.regionTitle = value.regionTitle
                
                
                lastCityTitle = value.cityTitle
                newSection.stationTitle += [value.stationTitle]
                
                if i == (stationsParsed.count - 1) { sectionsParsed.append(newSection) }
                
            } else {
                
                if i == (stationsParsed.count - 1) { sectionsParsed.append(newSection) }
                newSection.stationTitle += [value.stationTitle]
            }
        }
    }
    
    
    
    

    // создание поиска (контроллер и бар в нем )
    func searchSettings() {
        SearchController = UISearchController(searchResultsController: nil)
        SearchController.dimsBackgroundDuringPresentation = false
        SearchController.searchResultsUpdater = self
        tableView.tableHeaderView = SearchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText)
            tableView.reloadData()
        }
    }
    
    
    //метод поиска
    func filterContent(searchText: String) {
        searchResult = stationsParsed.filter({ (station: Station) -> Bool in
            let matchStationTitle = station.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let matchCityTitle = station.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let matchCountry = station.countryTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return matchStationTitle != nil || matchCityTitle != nil || matchCountry != nil
        })
    }

    
   
    // наполнение ячеек
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        if SearchController.active && SearchController.searchBar.text != "" {
            cell.textLabel?.text = searchResult[indexPath.row].stationTitle
        } else {
            cell.textLabel?.text = sectionsParsed[indexPath.section].stationTitle[indexPath.row]
        }
        
        return cell

    }
    
    //название секций
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if SearchController.active {
            return ""
        } else {
            return sectionsParsed[section].cityTitle + ", " + sectionsParsed[section].countryTitle
        }
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesOnJSONFormat[1]["stations"].count
    }
    
    // количество секций
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // по количеству городов
        
        return citiesOnJSONFormat.count
    }

    
    
    
    

    

    
    /* //не работает ни первый ни второй случаи
    
    //количество строк в секции
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if SearchController.active {
    return searchResult.count
    } else {
    return sectionsParsed[section].stationTitle.count
    }
    }
    
    //количество секций
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    /*
    if SearchController.active {
    return 1
    } else {
    return sectionsParsed.count
    }*/
    return sectionsParsed.count
    }

    
    
    
  */

}
