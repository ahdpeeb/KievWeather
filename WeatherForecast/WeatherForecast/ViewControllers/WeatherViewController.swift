//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit
import Reachability

class WeatherViewController: UIViewController {
    // depends on sender.selectedSegmentIndex
    enum DisplayedDays: Int {
        case five, ten, sixteen
        var count: Int {
            switch self {
            case .five: return 5
            case .sixteen: return 16
            case .ten: return 10
            }
        }
    }
    
    fileprivate let reachability = Reachability()
    @IBOutlet fileprivate var daysSegmentControl: UISegmentedControl?
    @IBOutlet fileprivate var cartContainerView: UIView?
    @IBOutlet fileprivate var collectionView: UICollectionView? {
        didSet {
            self.configureCollectionView()
        }
    }
    
    fileprivate var presentedDays: WeatherViewController.DisplayedDays = .five {
        didSet {
            self.fillDataSoarce(with: presentedDays)
        }
    }
    
    fileprivate var city: City? {
        didSet {
            self.cityWeather = city?.weather
        }
    }
    
    fileprivate var cityWeather: [Weather]? = [] {
        didSet {
            self.fillDataSoarce(with: self.presentedDays)
        }
    }
    
    fileprivate var weatherToDisplay: [Weather] = [] {
        didSet {
            print("Presented days - \(weatherToDisplay.count)")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                //child controller redraw graphic
            }
        }
    }
    
    deinit {
        self.reachability?.stopNotifier()
    }
    
    //MARK: View live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cachedCityID = DataManager.shared.lastLoadedCityID {
            self.loadCachedCity(id: cachedCityID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listenNetworkConnection()
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
    
    func listenNetworkConnection() {
        let reachability = self.reachability
        reachability?.whenReachable = { reachability in
            self.loadKievWeather()
        }
        
        reachability?.whenUnreachable = { _ in
            self.displayAlert(message: Constans.ErrorMessage.internetConnection)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

//Private: UI
extension WeatherViewController {
    func loadKievWeather() {
        ApiClient.shared.loadKievWeather(onCompletion: { (city) in
            guard let city = city else { return }
            DataManager.shared.lastLoadedCityID = city.id.description
            self.city = city
        }) { (error) in
            self.displayAlert(message: error.localizedDescription)
        }
    }
    
    func loadCachedCity(id: String) {
        let storedCity = ID.init(string: id).map({ City(id: $0) })
        self.city = storedCity
    }
    
    func fillDataSoarce(with days: DisplayedDays) {
        let allWeather = self.cityWeather ?? []
        guard allWeather.count - 1 >= days.count else {
            self.weatherToDisplay = allWeather
            
            return
        }
        
        self.weatherToDisplay = Array(allWeather.prefix(days.count))
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
}
