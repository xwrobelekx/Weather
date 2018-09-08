//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kamil Wrobel on 9/8/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    
    
    var curentLocation: CLLocation? {
        didSet {
            fetchWeather()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return WeatherController.shared.dailyWeathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell
        let dailyWeather = WeatherController.shared.dailyWeathers[indexPath.row]
        cell?.dailyWeather = dailyWeather
        return cell ?? UICollectionViewCell()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        
        if CLLocationManager.locationServicesEnabled(){
        WeatherController.shared.location.delegate = self
            WeatherController.shared.location.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        curentLocation = locations.first
    }


    func fetchWeather(){
       guard let latitude = curentLocation?.coordinate.latitude,
        let longitude = curentLocation?.coordinate.longitude else {return}
        
        WeatherController.shared.fetchWeeklyWeather(latitude: latitude, longitude: longitude) { (_) in }
    }


}
