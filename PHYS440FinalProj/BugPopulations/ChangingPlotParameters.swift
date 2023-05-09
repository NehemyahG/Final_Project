//
//  ChangingPlotParameters.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//

import SwiftUI

class ChangingPlotParameters: NSObject, ObservableObject {
    
    //These plot parameters are adjustable
    
    var xLabel: String = "x"
    var yLabel: String = "y"
    var xMax : Double = 2.0
    var yMax : Double = 2.0
    var yMin : Double = -1.0
    var xMin : Double = -1.0
    var theta_label: String = "Theta"
    var dtheta_label: String = "Derivative Theta"
    var vel_label: String = "Velocity"
    var dtheta_start: Double = 3.0
    var dtheta_fin: Double = -3.0
    var theta_start: Double = -5.0
    var theta_fin: Double = 12.0
    var vel_start: Double = -10.0
    var vel_fin: Double = 10.0
    var lineColor: Color = Color.red
    var title: String = "Plot Title"
    
}
