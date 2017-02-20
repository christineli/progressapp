//
//  StatsViewController.swift
//  Journal
//
//  Created by Jonah May on 10/21/16.
//  Copyright © 2016 Your School. All rights reserved.
//

import UIKit
import Firebase
import Charts


class StatsViewController: UIViewController {


    @IBOutlet weak var energyLineChartView: LineChartView!
    @IBOutlet weak var happinessLineChartView: LineChartView!
    @IBOutlet weak var anxietyLineChartView: LineChartView!

    @IBOutlet weak var energyLevelAverage: UILabel!
    @IBOutlet weak var happinessLevelAverage: UILabel!
    @IBOutlet weak var anxietyLevelAverage: UILabel!
    
    var dates: [Int]! = []
    var energyLevels: [Double]! = []
    var happinessLevels: [Double]! = []
    var anxietyLevels: [Double]! = []
    var ref : FIRDatabaseReference!
    var journal: Journal?
    
    let formato:LineChartFormatter = LineChartFormatter()
    let xaxis:XAxis = XAxis()
    let yaxis:YAxis = YAxis()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference(withPath: "journalEntries")
        ref.observe(.value, with: { snapshot in
            let newJournal = Journal()
            
            for item in snapshot.children {
                let entry = JournalEntry(snapshot: item as! FIRDataSnapshot)
                if (entry.addedByUser == FIRAuth.auth()?.currentUser?.uid) {
                    newJournal.addEntry(entry)
                }
            }
            self.journal = newJournal
        })
    }

    func setChart(dataPoints: [Int], values: [Double]) -> [ChartDataEntry] {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        formato.setArray(arr: dataPoints)
        xaxis.valueFormatter = formato
        return dataEntries

    }
    
    func setAllCharts() {
        energyLineChartView.noDataText = "You need to provide data for the chart."
        let energyChartDataSet = LineChartDataSet(values: setChart(dataPoints: dates, values: energyLevels), label: "Energy Level")
        energyLineChartView.data = LineChartData(dataSet: energyChartDataSet)
        energyLineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        energyLineChartView.data?.setDrawValues(false)
        energyLineChartView.rightAxis.drawLabelsEnabled = false
        energyLineChartView.legend.enabled = false
        energyLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        energyLineChartView.leftAxis.axisMinimum = 1
        energyLineChartView.leftAxis.axisMaximum = 5
        energyLineChartView.leftAxis.labelCount = 4
        energyLineChartView.leftAxis.drawGridLinesEnabled = false
        energyLineChartView.rightAxis.drawGridLinesEnabled = false
        energyLineChartView.xAxis.drawGridLinesEnabled = false
        energyLineChartView.drawGridBackgroundEnabled = false


        happinessLineChartView.noDataText = "You need to provide data for the chart."
        let happinessChartDataSet = LineChartDataSet(values: setChart(dataPoints: dates, values: happinessLevels), label: "Happiness Level")
        happinessLineChartView.data = LineChartData(dataSet: happinessChartDataSet)
        happinessLineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        happinessLineChartView.data?.setDrawValues(false)
        happinessLineChartView.rightAxis.drawLabelsEnabled = false
        happinessLineChartView.legend.enabled = false
        happinessLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        happinessLineChartView.leftAxis.axisMinimum = 1
        happinessLineChartView.leftAxis.axisMaximum = 5
        happinessLineChartView.leftAxis.labelCount = 4
        happinessLineChartView.leftAxis.drawGridLinesEnabled = false
        happinessLineChartView.rightAxis.drawGridLinesEnabled = false
        happinessLineChartView.xAxis.drawGridLinesEnabled = false
        happinessLineChartView.drawGridBackgroundEnabled = false
        
        anxietyLineChartView.noDataText = "You need to provide data for the chart."
        let anxietyChartDataSet = LineChartDataSet(values: setChart(dataPoints: dates, values: anxietyLevels), label: "Anxiety Level")
        anxietyLineChartView.data = LineChartData(dataSet: anxietyChartDataSet)
        anxietyLineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        anxietyLineChartView.data?.setDrawValues(false)
        anxietyLineChartView.rightAxis.drawLabelsEnabled = false
        anxietyLineChartView.legend.enabled = false
        anxietyLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        anxietyLineChartView.leftAxis.axisMinimum = 1
        anxietyLineChartView.leftAxis.axisMaximum = 5
        anxietyLineChartView.leftAxis.labelCount = 4
        anxietyLineChartView.leftAxis.drawGridLinesEnabled = false
        anxietyLineChartView.rightAxis.drawGridLinesEnabled = false
        anxietyLineChartView.xAxis.drawGridLinesEnabled = false
        anxietyLineChartView.drawGridBackgroundEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        energyLevelAverage.text = NSString(format: "%.2f", (journal?.averageEnergy)!) as String
        happinessLevelAverage.text = NSString(format: "%.2f", (journal?.averageHappiness)!) as String
        anxietyLevelAverage.text = NSString(format: "%.2f", (journal?.averageAnxiety)!) as String
        
        for i in 0 ..< (journal?.count)! {
            let date = journal?.entry(i)?.date
            let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let components = cal?.components([.day, .month, .year], from: date!)

            //FIX: figure out how to turn month int into 3-letter month
            dates.append((components?.month)!)
            let energyLevel = Double((journal?.entry(i)?.energyLevel)!)
            let happinessLevel = Double((journal?.entry(i)?.happinessLevel)!)
            let anxietyLevel = Double((journal?.entry(i)?.anxietyLevel)!)
            energyLevels.append(energyLevel)
            happinessLevels.append(happinessLevel)
            anxietyLevels.append(anxietyLevel)
        }
        setAllCharts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
