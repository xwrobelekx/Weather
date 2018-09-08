//
//  Weather.swift
//  Weather
//
//  Created by Kamil Wrobel on 9/8/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation

//Apple convention to call this "project name" plus "service"

struct WeatherService: Codable {
    
    var currently : CurrentWeather
    var weeklyWeatherData: WeeklyWeather
    
    private enum CodingKeys: String, CodingKey{
        case currently
        case weeklyWeatherData = "daily"
    }
}

struct CurrentWeather : Codable {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperature: Double
}

struct WeeklyWeather: Codable {
    
    var summary: String
    var icon: String
    var data: [DailyWeather]
}

struct DailyWeather: Codable {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperatureMax: Double
    var temperatureMin: Double
}




