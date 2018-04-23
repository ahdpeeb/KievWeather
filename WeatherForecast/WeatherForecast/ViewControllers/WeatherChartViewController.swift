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
    public var didSelectWeather: ((_ weather: Weather?) -> Void)?
    
    public var weathers: [Weather] = [] {
        didSet {
            self.updateChartView()
        }
    }
    
    fileprivate weak var axisFormatDelegate: IAxisValueFormatter?
    @IBOutlet fileprivate var chartView: LineChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.axisFormatDelegate = self
        self.chartViewConfig()
        
        self.updateChartView()
    }
    
    private func chartViewConfig() {
        guard let view = self.chartView else { return }
        view.delegate = self
        view.chartDescription?.text = "Temperature indicators"
        view.backgroundColor = UIColor.white
        
        view.dragEnabled = true
        view.setScaleEnabled(true)
        view.pinchZoomEnabled = true
        view.drawGridBackgroundEnabled = false
        
        let xaxis = view.xAxis
        xaxis.labelPosition = .bottom
        xaxis.valueFormatter = axisFormatDelegate
        xaxis.labelCount = weathers.count
        xaxis.granularityEnabled = true
        xaxis.granularity = 1.0
        xaxis.centerAxisLabelsEnabled = true
        xaxis.avoidFirstLastClippingEnabled = true
        xaxis.drawLimitLinesBehindDataEnabled = true
        
        let rightAxis = view.rightAxis
        rightAxis.enabled = false
        
        let leftAxis = view.leftAxis
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawGridLinesEnabled = true
    }
    
    private func updateChartView() {
        var dayEntries: [ChartDataEntry] = []
        var nightEntries: [ChartDataEntry] = []
        
        let date: [Double] = self.weathers.compactMap({ $0.date.map({ Double($0) }) })
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
        self.chartView?.data = chartData
    }
    
    private func valueFromDate(_ date: Date?) -> Double? {
        let stringDate: String? = date?.stringWith(format: "dd")
        
        let double = stringDate.flatMap({ Double($0) }) ?? 0.0
        return double
    }
}

extension WeatherChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        let date = Date(timeIntervalSince1970: value)
        
        return dateFormatter.string(from: date)
    }
}

extension WeatherChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let weatherDate = Int(entry.x)
        let selectedWeather = self.weathers.first(where: { $0.date == weatherDate })
        self.didSelectWeather?(selectedWeather)
    }
}
