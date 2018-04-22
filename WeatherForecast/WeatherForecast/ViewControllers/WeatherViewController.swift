//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    // depends on sender.selectedSegmentIndex
    enum DisplayedDays: Int {
        case five, ten, sixteen
    }
    
    @IBOutlet fileprivate var daysSegmentControl: UISegmentedControl?
    @IBOutlet fileprivate var cartContainerView: UIView?
    @IBOutlet fileprivate var collectionView: UICollectionView? {
        didSet {
            self.configureCollectionView()
        }
    }
    
    fileprivate var presentedDays: WeatherViewController.DisplayedDays = .five {
        didSet {
            
        }
    }
    
    fileprivate var city: City? {
        didSet {
            self.cityWeather = city?.weather
        }
    }
    
    fileprivate var cityWeather: [Weather]? = [] {
        didSet {
            //sort weatherToDisplay, base on daysSegmentControl
        }
    }
    
    fileprivate var weatherToDisplay: [Weather] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                //child controller redraw graphic
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadKievWeather()
    }
}

//MARK: Action
extension WeatherViewController {
    @IBAction fileprivate func daysSegmentControlValueChanged(_ sender: UISegmentedControl) {
        guard let displayedDays = DisplayedDays(rawValue: sender.selectedSegmentIndex) else { return }
        self.presentedDays = displayedDays
    }
}

//MARK: UI
extension WeatherViewController {
    func configureCollectionView() {
        
    }
}

//Private: UI
extension WeatherViewController {
    func loadKievWeather() {
        ApiClient.shared.loadKievWeather(onCompletion: { (city) in
            self.city = city
            print(city?.weather?.count)
            self.weatherToDisplay = (city?.weather) ?? []
        }) { (error) in
            self.displayAlert(message: error.localizedDescription)
        }
    }
}
