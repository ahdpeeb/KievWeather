//
//  WeatherCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/22/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate var weatherIcon: UIImageView?
    @IBOutlet fileprivate var weatherDateLabel: UILabel?
    @IBOutlet fileprivate var tempDayLabel: UILabel?
    @IBOutlet fileprivate var tempNightLabel: UILabel?
    
    public var weatherDate: Date? {
        didSet {
            self.weatherDateLabel?.text = weatherDate?.stringWith(format: "dd/MM/yy")
        }
    }
    
    public var weatherImageName: String? {
        didSet {
            self.weatherIcon?.image = weatherImageName.flatMap({ UIImage(named: $0) })
        }
    }
    
    public var tempDay: Double? {
        didSet {
            self.tempDayLabel?.text = self.string(temp: tempDay)
        }
    }
    
    public var tempNightn: Double? {
        didSet {
            self.tempNightLabel?.text = self.string(temp: tempNightn)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundCorners(radius: 8)
    }
    
    private func string(temp: Double?) -> String? {
        return (temp.flatMap({ String(format: "%2.0f", $0) })?[0 ... 1]).map({ String($0) })
    }
}
