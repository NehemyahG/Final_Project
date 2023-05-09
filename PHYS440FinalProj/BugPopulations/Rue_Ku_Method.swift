//
//  Rue_Ku_Method.swift
//  BugPopulations
//
//  Created by IIT PHYS 440 on 5/7/23.
//
// This is the Runge-Kutta Method
import Foundation
    

func Pendulum_RK4(theta: Double, theta_der: Double, Npts: Int, int_time: Double, en_time: Double, a: Double, RU_KU_Parameters: [String: Double]) -> ([Double], [Double], [Double]) {
    
  
    func p_a(time: Double) -> Double{
        let a = cos(((RU_KU_Parameters ["Omg"] ?? 1.0) * time))
        return a
    }
    //First part of the Runge-Kutta Method
    @inline(__always) func f(theta: Double, time: Double, theta_der: Double) -> Double{
        return  theta_der
    }
    //Second part of the Runge-Kutta Method
    @inline(__always) func g(theta_der: Double, theta: Double, time: Double) -> Double{
        // Split up function for second order so that the compiler can handle the full function
        
        let a = cos(((RU_KU_Parameters ["Omg"] ?? 1.0) * time))
        
        //Main part of the second part of the Runge-Kutta Method
        return (-1) * (RU_KU_Parameters ["Omg"] ?? 1.0) ↑ (2) * sin(theta) - (RU_KU_Parameters ["Alpha"] ?? 1.0) * theta_der + f(theta: a, time: a, theta_der: a)
    }
    var calc_theta: [Double] = Array(repeating: 0.0, count: Npts)
    var calc_time: [Double] = Array(repeating: 0.0, count: Npts)
    var calc_theta_der: [Double] = Array(repeating: 0.0, count: Npts)
    let h = (en_time - int_time) / Double(Npts)
    
    //calculation for theta
    calc_theta[0] = theta
    //calculation for the deravative for theta
    calc_theta_der[0] = theta_der
    //calculation for the time
    calc_time[0] = int_time
    
    for i in 1..<Npts {
        let k1 = f(theta: calc_theta[i-1], time: calc_time[i-1], theta_der: calc_theta_der[i-1])
        let j1 = g(theta_der: calc_theta_der[i-1], theta: calc_theta[i-1], time: calc_time[i-1])
        let k2 = f(theta: calc_theta[i-1] + h * (k1 / 2), time: calc_time[i-1] + h / 2, theta_der: calc_theta_der[i-1] + h * (j1 / 2))
        let j2 = g(theta_der: calc_theta_der[i-1], theta: calc_theta[i-1], time: calc_time[i-1])
        let k3 = f(theta: calc_theta[i-1] + h * (k2 / 2), time: calc_time[i-1] + h / 2, theta_der: calc_theta_der[i-1] + h * (j2 / 2))
        let j3 = g(theta_der: calc_theta[i-1], theta: calc_theta[i-1], time: calc_time[i-1])
        let k4 = f(theta: calc_theta[i-1] + h * k3, time: calc_time[i-1] + h, theta_der: calc_theta_der[i-1] + h * j3)
        let j4 = g(theta_der: calc_theta_der[i-1], theta: calc_theta[i-1], time: calc_time[i-1])
        
        calc_theta[i] = calc_theta[i-1] + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4)
        calc_theta_der[i] = calc_theta_der[i-1]
        calc_time[i] = calc_time[i-1] + h
    }
  
        return (calc_theta_der, calc_theta, calc_time)
}

//
//func gen_Rue_Ku_Method(fun: (Double, Double) -> Double, initTime: Double, initVal: Double, npts: Int) {
//    var tmp = fun(initVal, initTime)
//}
