//
//  Harmonic_Oscillator_Move.swift
//  BugPopulations
//
//  Created by IIT PHYS 440 on 5/5/23.
//

import SwiftUI


class Harmonic_Oscillator_Move: NSObject {
    @Published var Ang_Vel = [Double] () //Angler Velocity
    @Published var Amp = [Double] () //Amplitude
    @Published var Time = [Double] () //Time
    
    //Velocity of the Pendulum
    func Velocity_Pendulum(Ang_Vel:Double, Amp:Double, Time:Double) -> Double{
        var Vel_Pen: Double = 0.0
            Vel_Pen = Ang_Vel * Amp * cos (Amp * Time)
        return Vel_Pen
    }
    
    //Position of the Pendulum
    func Position_Pendulum(Ang_Vel:Double, Amp:Double, Time:Double) -> Double{
        var Pos_Pen: Double = 0.0
            Pos_Pen = Amp * sin (Amp * Time)
        return Pos_Pen
    }
    
}
