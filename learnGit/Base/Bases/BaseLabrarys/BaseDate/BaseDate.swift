//
//  BaseDate.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

let dateGlobal = Date() // khoi tao

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    var monthCurrent: String {
        // use : dateGlobal.monthCurrent
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MMMM" // August
        dateFormatter.dateFormat = "MM" // 08
        return dateFormatter.string(from: self)
    }
    
    var yearCurrent: String {
        // use : dateGlobal.monthCurrent
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MMMM" // August
        dateFormatter.dateFormat = "YYYY" // 08
        return dateFormatter.string(from: self)
    }
}


extension UIViewController {
    // string To Date ----------------------
    func stringToDate(txt: String) -> Date?{
        //let isoDate = "2016-04-14T10:44:00+0000"
        let isoDate = "2016-04-18"
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //let date = dateFormatter.date(from:isoDate)
        let date = dateFormatter.date(from:txt)
        return date
    }
    // get End Date Of Any Moth -----------------
    func getEndDateOfAnyMoth(dateFrom:String?) -> String?{
        var dateTo:String? = nil
        if let dateFrom1 = dateFrom, let dateFromString = stringToDate(txt: dateFrom1) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "yyyy-MM-dd"
            dateTo = formatter2.string(from: dateFromString.endOfMonth)
        }
        return dateTo
    }
}

