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
    
    
    
    func updateViews() {
        
    }
    
}
