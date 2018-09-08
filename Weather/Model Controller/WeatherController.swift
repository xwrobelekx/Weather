//
//  WeatherController.swift
//  Weather
//
//  Created by Kamil Wrobel on 9/8/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CoreLocation


//Weather Client
class WeatherController {
    
    static let shared = WeatherController()
    private init (){}
    
    var dailyWeathers: [DailyWeather] = []
    
    let location = CLLocationManager()
    
    
    let baseURL = URL(string: "https://api.darksky.net/forecast/")
    let apiSecret = "64eecaf19640a8c3d512d778d091a7ea"
    
    func fetchWeeklyWeather(latitude: Double, longitude: Double, completion: @escaping(([DailyWeather]?) -> Void)){
    
        //#1 step - Asembling the URL
        guard let baseURL = baseURL else {completion(nil); return}
        
        var url = baseURL.appendingPathComponent(apiSecret)
        
        url.appendPathComponent("\(latitude),\(longitude)")
        
        //this chops the url into components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "exclude", value: "[minutley,hourly,alerts,flags]")]
        
        guard let finishedURL = components?.url else {completion(nil); return}
        
        print("🙏🏻\(finishedURL.absoluteString)")
    
        
        //#2 step - Calling the dataTask  - and decoding
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("\(error.localizedDescription), \(error) in function: \(#function)")
                completion(nil)
                return
            }
            
            print("💥\(response ?? URLResponse())")
            
            guard let data = data else { completion(nil); return }
            
            let decoder = JSONDecoder()
            
            do {
            let weatherService = try decoder.decode(WeatherService.self, from: data)
                let dailyWeathers  = weatherService.weeklyWeatherData.data
                self.dailyWeathers = dailyWeathers
                completion(dailyWeathers)
                
            } catch {
                print("There was an error on \(#function): \(error) \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}





