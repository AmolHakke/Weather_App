//
//  CustomDB.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 24/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import Foundation
import SQLite3

class CustomDB
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "Location.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print("SQLPath : \(fileURL.path)")
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS LocationInfo(Id INTEGER PRIMARY KEY autoincrement, areaName TEXT NOT NULL,country TEXT,latitude TEXT, longitude TEXT, population TEXT, region TEXT, WeatherUrl TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("LocationInfo table created.")
            } else {
                print("LocationInfo table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(areaName:String, country:String, latitude:String, longitude:String, population:String, region:String, WeatherUrl:String)
    {
        let locations = read()
        for p in locations
        {
            if p.areaName == areaName
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO LocationInfo (areaName, country, latitude, longitude, population, region, WeatherUrl) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (areaName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (country as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (latitude as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (longitude as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (population as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (region as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (WeatherUrl as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [LocationInfo] {
        let queryStatementString = "SELECT * FROM locationinfo order by Id desc LIMIT 10;"
        var queryStatement: OpaquePointer? = nil
        var psns : [LocationInfo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let areaName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let latitude = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let longitude = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let population = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let region = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let WeatherUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                
                psns.append(LocationInfo().initWithLocationInfoResult(l_areaName: areaName, l_country: country, l_latitude: latitude, l_longitude: longitude, l_population: population, l_region: region, l_WeatherUrl: WeatherUrl))
                print("Query Result:")
                print(" \(areaName) | \(country)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}

