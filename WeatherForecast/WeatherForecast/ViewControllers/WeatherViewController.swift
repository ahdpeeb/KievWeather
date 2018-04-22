//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit
import Reachability

struct WeatherConstans {
    static let interItemSpacing: CGFloat = 10
    static let cellsInScreen = 2
    static let cardHeight: CGFloat = 100
}

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
    fileprivate var chartViewController: WeatherChartViewController?
    @IBOutlet fileprivate var daysSegmentControl: UISegmentedControl?
    @IBOutlet fileprivate var chartContainerView: UIView?
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
                self.chartViewController?.weathers = self.weatherToDisplay
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
        self.bindChartController()
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
fileprivate extension WeatherViewController {
    func configureCollectionView() {
        let collection = self.collectionView
        collection?.registerCell(cls: WeatherCollectionViewCell.self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = WeatherConstans.interItemSpacing
        layout.itemSize = self.cardSize()
        collection?.collectionViewLayout = layout
    }
    
    func bindChartController() {
        if let container = self.chartContainerView,
            let controller = UIStoryboard.controllerFromMainStorybourd(cls: WeatherChartViewController.self)
        {
            self.addChildViewControoler(controller, toContainerView: container)
            self.chartViewController = controller
            controller.weathers = self.weatherToDisplay
        }
        
    }
    
    func cardSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        return CGSize(width: (screenWidth - WeatherConstans.interItemSpacing) / CGFloat(2).rounded(.down),
               height: WeatherConstans.cardHeight)
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
            let cityID = city.id.description
            DataManager.shared.lastLoadedCityID = cityID
            self.city = city
        }) { (error) in
            self.displayAlert(message: error.localizedDescription)
        }
    }
    
    func loadCachedCity(id: String) {
        let storedCity = ID(string: id).flatMap({ City(id: $0) })
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cls: WeatherCollectionViewCell.self, indexPath: indexPath)!
        let weather = self.weatherToDisplay[indexPath.row]
        cell.weatherDate = weather.weatherDate
        cell.weatherImageName = weather.icon
        cell.tempDay = weather.tempDay
        cell.tempNightn = weather.tempNight
        
        return cell
    }
}
