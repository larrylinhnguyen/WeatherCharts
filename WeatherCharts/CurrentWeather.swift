//
//  CurrentWeather.swift
//  WeatherCharts
//
//  Created by Larry on 11/30/16.
//  Copyright © 2016 Savings iOS Dev. All rights reserved.
//

import Foundation
import UIKit
struct CurrentWeather {
    
    let temperature : Double
    let temperatureFeel : Double
    let windSpeed : Double
    let visibility: Double
    let pressure : Double
    let humidity : Double
    let precipitationProbability: Double
    let summary : String
    let icon : UIImage
    
}

// convert to starndard values

extension CurrentWeather:JSONDecodable{
    init?(JSON:[String: AnyObject]){
        guard let temperature = JSON["temperature"] as? Double, let temperatureFeel = JSON["apparentTemperature"] as? Double,let windSpeed = JSON["windSpeed"] as? Double,let visibility = JSON["visibility"] as? Double, let pressure = JSON["pressure"] as? Double, let humidity = JSON["humidity"] as? Double, let precipitationProbability = JSON["precipProbability"] as? Double, let summary = JSON["summary"] as? String,  let iconString = JSON["icon"] as? String else {return nil}
    let icon = WeatherIcon(rawValue: iconString).image
        
    self.temperature = temperature
    self.temperatureFeel = temperatureFeel
    self.windSpeed = windSpeed
    self.visibility = visibility
    self.pressure = pressure
    self.humidity = humidity
    self.precipitationProbability = precipitationProbability
    self.summary = summary
    self.icon = icon
        
        
    }
}

extension CurrentWeather {
    
    var temperatureString : String {
        return "\(Int(temperature))º"
    }
    
    var temperatureFeelString : String {
        return "\(Int(temperatureFeel))º"
    }
    
    var humidityString : String {
        let percentageValue = Int(humidity)*100
        return "\(percentageValue)%"
        
    }
    
    var PrecipitationProbString : String {
        let percentageValue = Int(precipitationProbability)
        return "\(percentageValue)%"
    }
    
    var pressureInchString : String {
        let inchValue = Int((pressure)*0.02953)
        return "\(inchValue) inches"
    }
}
