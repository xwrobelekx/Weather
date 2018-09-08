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
        fetchWeather()
        
        view.addVerticalGradientLayer(topColor: #colorLiteral(red: 0.9893657565, green: 0.8969728947, blue: 0.0122530302, alpha: 1), bottomColor: #colorLiteral(red: 0.01936318539, green: 0.997133553, blue: 0.3177120388, alpha: 1))
        //TODO: - Fix the location 
//        if CLLocationManager.locationServicesEnabled(){
//        WeatherController.shared.location.delegate = self
//            WeatherController.shared.location.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//    }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        curentLocation = locations.first
    }
    
    func updateCurrentWeather() {
        cityNameLabel.text = "Salt Lake City"
        weatherSummaryLabel.text = WeatherController.shared.curentWeather?.summary
        temperatureLabel.text = "\(Int(WeatherController.shared.curentWeather?.temperature ?? 0))℉"
    }


    func fetchWeather(){
//       guard let latitude = curentLocation?.coordinate.latitude,
//        let longitude = curentLocation?.coordinate.longitude else {return}
        let latitude = 40.7608
        let longitude = -111.8910
        
        
        WeatherController.shared.fetchWeeklyWeather(latitude: latitude, longitude: longitude) { (_) in
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
                self.updateCurrentWeather()
            }
            
        }
    }

}


extension UIView {
    
    /*
     Adds a vertical gradient layer with two **UIColors** to the **UIView**.
     - Parameter topColor: The top **UIColor**.
     - Parameter bottomColor: The bottom **UIColor**.
     */
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        
        //define starting position of the gradient - screen starts at 0.0
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
