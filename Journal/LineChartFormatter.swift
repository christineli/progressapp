//
//  LineChartFormatter.swift
//  Journal
//
//  Created by Christine Li on 12/4/16.
//  Copyright © 2016 Your School. All rights reserved.
//

import UIKit
import Foundation
import Charts

@objc(LineChartFormatter)
public class LineChartFormatter: NSObject, IAxisValueFormatter{
    
    var dates: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var newdates: [String]! = []
    
    //only display month above first entry and most recent entry
    public func setArray(arr: Array<Int>) {
        let numentries = arr.count
        if numentries > 0 {
            newdates.append(dates[arr[0]-1])
        }
        if numentries > 1 {
            for _ in 1..<arr.count-1 {
                newdates.append("")
            }
            newdates.append(dates[arr[numentries-1]-1])
        }
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Int(value) < newdates.count {
            return newdates[Int(value)]
        }
        return ""
    }
    
}
