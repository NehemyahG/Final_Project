//
//  ContentView.swift
//  Test Plot Threaded Charts
//
//  Created by Nehemyah Green 5/8/2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var plotData :PlotClass
    
    @StateObject private var calculator = CalculatePlotData()
    @StateObject private var myPendulum = Pendulum()
    @State var plotLine:Bool = false
    @State var muInput = "3.0"
    @State var selector = 0
    // dictionary for Runge Kutta Method
    @State var RU_KU_Parameters: [String: Double] = ["Omg": 1.0, "Alpha": 1.0]
    @MainActor func setupPlotDataModel(selector: Int){
        
        calculator.plotDataModel = self.plotData.plotArray[selector]
    }
    func calculate() async {
        
        //pass the plotDataModel to the Calculator
        // calculator.plotDataModel = self.plotData.plotArray[0]
        
        setupPlotDataModel(selector: 0)
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
        
            taskGroup.addTask {
              
                let mu = await Double(muInput)!
               
                //Calculate the new plotting data and place in the plotDataModel
                await calculator.calculateOneCycle(mu: mu)
                
                // This forces a SwiftUI update. Force a SwiftUI update.
                //await self.plotData.objectWillChange.send()
                
                await setObjectWillChange(theObject: self.plotData)
            }
        }
    }
    @MainActor func setObjectWillChange(theObject:PlotClass){
        
        theObject.objectWillChange.send()
        
    }
    func bifurcation() async {
        //pass the plotDataModel to the Calculator
        // calculator.plotDataModel = self.plotData.plotArray[0]
        setupPlotDataModel(selector: 1)
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            taskGroup.addTask {
                //Calculate the new plotting data and place in the plotDataModel
                await calculator.bifurcationCaclulation(muMin: 1.0, muMax: 4.0, step: 0.005)
                // This forces a SwiftUI update. Force a SwiftUI update.
                // await self.plotData.objectWillChange.send()
            }
        }
    }
    func pendulumCalculation() async {
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            taskGroup.addTask {
                await myPendulum.singleWaveFunctionFinder(initialThetaPrime: 1.0, numberOfXSteps: 10000, omega: 1.0)
                await plotData.plotArray[selector].zeroData()
                for i in await 0..<myPendulum.theta.count{
                    let dataPoint: (x: Double, y: Double) = await (x: myPendulum.time[i], y: myPendulum.theta[i])
                    await plotData.plotArray[selector].appendData(dataPoint: [dataPoint])
                }
                //set the Plot Parameters
                await plotData.plotArray[selector].changingPlotParameters.yMax = 5.0
                await plotData.plotArray[selector].changingPlotParameters.yMin = -5.0
                await plotData.plotArray[selector].changingPlotParameters.xMax = 100
                await plotData.plotArray[selector].changingPlotParameters.xMin = -1.0
                await plotData.plotArray[selector].changingPlotParameters.xLabel = "time"
                await plotData.plotArray[selector].changingPlotParameters.yLabel = "theta"
                
                await setObjectWillChange(theObject: self.plotData)
                
            }
        }
    }
    
    func potentialAndKineticEnergyCalculator() async {
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            taskGroup.addTask {
                
                await myPendulum.singleWaveFunctionFinder(initialThetaPrime: 1.0, numberOfXSteps: 10000, omega: 1.0)
                
                await plotData.plotArray[selector].zeroData()
                
                for i in await 0..<myPendulum.potentialEnergy.count{
                    let dataPoint: (x: Double, y: Double) = await (x: myPendulum.time[i], y: myPendulum.potentialEnergy[i])
                    await plotData.plotArray[selector].appendData(dataPoint: [dataPoint])
                    
                }
                //set the Plot Parameters
                
                await plotData.plotArray[selector].changingPlotParameters.theta_start = 3.0
                await plotData.plotArray[selector].changingPlotParameters.dtheta_start = -3.0
                
                
                await setObjectWillChange(theObject: self.plotData)
            }
        }
    }
    
    func Phase_Space_Traject_1() async {
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            taskGroup.addTask {
                
                await myPendulum.singleWaveFunctionFinder(initialThetaPrime: 1.0, numberOfXSteps: 10000, omega: 1.0)
                
                await plotData.plotArray[selector].zeroData()
                
                for i in await 0..<myPendulum.potentialEnergy.count{
                    let dataPoint: (x: Double, y: Double) = await (x: myPendulum.time[i], y: myPendulum.potentialEnergy[i])
                    await plotData.plotArray[selector].appendData(dataPoint: [dataPoint])
                    
                }
                //set the Plot Parameters
                
                await plotData.plotArray[selector].changingPlotParameters.theta_fin = 3.0
                await plotData.plotArray[selector].changingPlotParameters.theta_start = -3.0
                await plotData.plotArray[selector].changingPlotParameters.vel_fin = 100
                await plotData.plotArray[selector].changingPlotParameters.vel_start = -1.0
                await plotData.plotArray[selector].changingPlotParameters.theta_label = "Theta"
                await plotData.plotArray[selector].changingPlotParameters.vel_label = "Velocity"
                
                await setObjectWillChange(theObject: self.plotData)
            }
        }
    }
    
    func Phase_Space_Traject_2() async {
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            taskGroup.addTask {
                
                await myPendulum.singleWaveFunctionFinder(initialThetaPrime: 1.0, numberOfXSteps: 10000, omega: 1.0)
                
                await plotData.plotArray[selector].zeroData()
                
                for i in await 0..<myPendulum.potentialEnergy.count{
                    let dataPoint: (x: Double, y: Double) = await (x: myPendulum.time[i], y: myPendulum.potentialEnergy[i])
                    await plotData.plotArray[selector].appendData(dataPoint: [dataPoint])
                    
                }
                //set the Plot Parameters
                
                await plotData.plotArray[selector].changingPlotParameters.theta_fin = 3.0
                await plotData.plotArray[selector].changingPlotParameters.theta_start = -3.0
                await plotData.plotArray[selector].changingPlotParameters.dtheta_fin = 100
                await plotData.plotArray[selector].changingPlotParameters.dtheta_start = -1.0
                await plotData.plotArray[selector].changingPlotParameters.theta_label = "Theta"
                await plotData.plotArray[selector].changingPlotParameters.dtheta_label = "D Theta"
                
                await setObjectWillChange(theObject: self.plotData)
            }
        }
    }
    var body: some View {
        
        VStack{
            
            Group{
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Text($plotData.plotArray[selector].changingPlotParameters.yLabel.wrappedValue)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(.red)
                        .padding()
                    VStack {
                        Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                            if plotLine {
                                
                                LineMark(
                                    x: .value("Position", $0.xVal),
                                    y: .value("Height", $0.yVal)
                                    
                                )
                                .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                            }
                            PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                            
                                .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                          
                        }
                        .chartYScale(domain: [ plotData.plotArray[selector].changingPlotParameters.yMin ,  plotData.plotArray[selector].changingPlotParameters.yMax ])
                        .chartXScale(domain: [ plotData.plotArray[selector].changingPlotParameters.xMin ,  plotData.plotArray[selector].changingPlotParameters.xMax ])
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                        Text($plotData.plotArray[selector].changingPlotParameters.xLabel.wrappedValue)
                            .foregroundColor(.red)
                    }
                }
                // .frame(width: 350, height: 400, alignment: .center)
                .frame(alignment: .center)
                
            }
            .padding()
            
            Divider()
            
            HStack{
                HStack(alignment: .center) {
                    Text("mu:")
                        .font(.callout)
                        .bold()
                    TextField("mu", text: $muInput)
                        .padding()
                }.padding()
                
                Toggle(isOn: $plotLine) {
                    Text("plot Line")
                }
                .padding()
            }
            
            // Button for one cycle of the function
            HStack{
                Button("One Cycle", action: {
                    Task.init{
                        self.plotLine = true
                        self.selector = 0
                        await self.calculate()
                    }
                })
                .padding()
            }
            
            //Button for Bifurcation
            HStack{
                Button("Bifurcation", action: {
                    Task.init{
                        self.selector = 1
                        self.plotLine = false
                        await self.bifurcation()
                    }
                })
                .padding()
            }
            HStack{
                Button("Pendulum", action: { Task.init{
                    // self.selector = 1
                    //self.plotLine = false
                    await self.pendulumCalculation()
                }
                })
                
                .padding()
            }
            HStack{
                Button("Potential Energy Graph", action: { Task.init{
                    // self.selector = 1
                    //self.plotLine = false
                    await self.potentialAndKineticEnergyCalculator()
                                }
                            })
                        .padding()
                        
                HStack{
                    Button("Phase Space Trajectories: Rotation soultion", action: { Task.init{
                        // self.selector = 1
                        //self.plotLine = false
                        await self.potentialAndKineticEnergyCalculator()
                    }
                    })
                    .padding()
                }
                    }
                }
            }
        }

