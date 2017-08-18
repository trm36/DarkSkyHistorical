//
//  Weather.swift
//  DarkSkyWeatherHistory
//
//  Created by Taylor Mott on 17-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation

struct Weather {
    
    var iconName: String
    var summary: String
    var temp: Measurement<UnitTemperature>
    
    init?(jsonResponse: [String : Any]) {
        
        guard let hourlyDictionary = jsonResponse["hourly"] as? [String : Any],
        let summary = hourlyDictionary["summary"] as? String,
        let hourlyDataArray = hourlyDictionary["data"] as? [[String : Any]],
        let weatherData = hourlyDataArray.first,
        let iconString = weatherData["icon"] as? String,
            let tempDouble = weatherData["temperature"] as? Double else { return nil }
        
        
        self.iconName = iconString
        self.summary = summary
        self.temp = Measurement(value: tempDouble, unit: UnitTemperature.fahrenheit)
    }
    
}
