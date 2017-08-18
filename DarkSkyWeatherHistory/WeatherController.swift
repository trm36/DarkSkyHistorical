//
//  WeatherController.swift
//  DarkSkyWeatherHistory
//
//  Created by Taylor Mott on 17-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CoreLocation


struct WeatherController {
    
    
    static func fetchWeather(at zipCode: String, at date: Date, completion: @escaping ((Weather?) -> Void)) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zipCode) { (placemarks: [CLPlacemark]?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemarks = placemarks,
                let firstPlacemark = placemarks.first,
                let location = firstPlacemark.location else { completion(nil); return }
            
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            let unixTime = date.timeIntervalSince1970
            let timeString = String(format: "%.0f", unixTime)
            let apiKey = "4150419951b8027408f2d2e849c9dad9"
            
            var urlString = "https://api.darksky.net/forecast/"
            urlString.append(apiKey)
            urlString.append("/")
            urlString.append("\(latitude)")
            urlString.append(",")
            urlString.append("\(longitude)")
            urlString.append(",")
            urlString.append("\(timeString)")
            print(urlString)
            
            guard let url = URL(string: urlString) else { completion(nil); return }
            
            let sharedURLSession = URLSession.shared
            
            let task = sharedURLSession.dataTask(with: url, completionHandler: { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                guard let data = data,
                    let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any],
                    let weather = Weather(jsonResponse: jsonDictionary)  else { completion(nil); return }
                
                completion(weather)
            })
            
            task.resume()
        }
    }
    
    
}
