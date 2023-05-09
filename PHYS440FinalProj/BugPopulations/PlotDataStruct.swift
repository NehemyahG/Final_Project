//
//  PlotDataStruct.swift
//  Test Plot Threaded Charts
//
//  Created by Nehemyah Green on 5/8/2023
//


import Foundation
import Charts

struct PlotDataStruct: Identifiable {
    var id: Double { xVal }
    let xVal: Double
    let yVal: Double
}

