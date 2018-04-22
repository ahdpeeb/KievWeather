//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    enum DisplayedDays {
        case five
        case ten
        case sixteen
    }
    
    @IBOutlet fileprivate var daysSegmentControl: UISegmentedControl?
    @IBOutlet fileprivate var collectionView: UICollectionView?
    @IBOutlet fileprivate var cartContainerView: UIView?
    
    fileprivate var presentedDays: WeatherViewController.DisplayedDays = .five
    fileprivate var weatherToDisplay: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Action
extension WeatherViewController {
    
}

//MARK: UI
extension WeatherViewController {
    
}
