//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Kamil Wrobel on 9/8/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayOFWeekLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var dailyWeather: DailyWeather? {
        didSet{
            updateViews()
        }
    }
    
    func stringFromTime(time: TimeInterval) -> String {
     let formater = DateFormatter()
        formater.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: time)
        return formater.string(from: date)
    }
    
    
    func updateViews() {
        guard let dailyWeather = dailyWeather else {return}
        
        summaryLabel.text = dailyWeather.summary
        dayOFWeekLabel.text = stringFromTime(time: dailyWeather.time)
        iconImageView.image = UIImage(named: dailyWeather.icon) ?? UIImage(named: "sunny")
        temperatureLabel.text = "\(Int((dailyWeather.temperatureMax + dailyWeather.temperatureMin)/2))℉"
       
    }
    
}
