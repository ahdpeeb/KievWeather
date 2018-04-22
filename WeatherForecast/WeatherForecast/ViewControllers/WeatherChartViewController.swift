//
//  WeatherChartViewController.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit
import Charts

class WeatherChartViewController: UIViewController {
    public var weathers: [Weather] = [] {
        didSet {
            self.updateChartView()
        }
    }
    
    @IBOutlet var chartView: LineChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chartViewConfig()
        self.updateChartView()
    }
    
    private func chartViewConfig() {
        guard let view = self.chartView else { return }
        view.chartDescription?.text = "Temperature indicators"
        view.backgroundColor = UIColor.white
        view.xAxis.labelPosition = .bottom
        view.dragEnabled = true
        view.setScaleEnabled(true)
        view.pinchZoomEnabled = true
        view.drawGridBackgroundEnabled = false
    }
    
    private func updateChartView() {
        var dayEntries: [ChartDataEntry] = []
        var nightEntries: [ChartDataEntry] = []
        
        let date: [Double] = self.weathers.map({ Double($0.data ?? 0) })
        let dayTemperature: [Double] = self.weathers.map({ $0.tempDay ?? 0 })
        let nightTemperature: [Double] = self.weathers.map({ $0.tempNight ?? 0 })
        
        for i in 0 ..< date.count {
            let dayEntry = ChartDataEntry(x: date[i], y: dayTemperature[i])
            dayEntries.append(dayEntry)
            
            let nightEntry = ChartDataEntry(x: date[i], y: nightTemperature[i])
            nightEntries.append(nightEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dayEntries,
                                             label: "Temperature statistic")
        
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        let chartData = LineChartData(dataSet: chartDataSet)
        self.chartView.data = chartData
    }
}

