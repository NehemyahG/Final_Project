//
//  Total_Energy.swift
//  BugPopulations
//
//  Created by IIT PHYS 440 on 5/5/23.
//

import SwiftUI

class Total_Energy: NSObject {
    @Published var Ang_Vel = [Double] () //Angler Velocity
    @Published var Amp = [Double] () //Amplitude
    @Published var Time = [Double] () //Time
    @Published var Mass = [Double] () //Mass
    
    func Tot_En(Ang_Vel:Double, Amp:Double, Time:Double, Mass:Double) -> Double{
        var TE_Ans: Double = 0.0
        TE_Ans = (1/2) * Mass * Ang_Vel ↑ (2.0) * Amp ↑ (2.0)
        return TE_Ans
    }
}
