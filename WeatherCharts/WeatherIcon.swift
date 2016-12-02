//
//  WeatherIcon.swift
//  WeatherCharts
//
//  Created by Larry on 12/1/16.
//  Copyright © 2016 Savings iOS Dev. All rights reserved.
//

import Foundation
import UIKit
enum WeatherIcon: String {
    
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Wind = "wind"
    case Fog = "fog"
    case Sleet = "sleet"
    case Rain = "rain"
    case Snow = "snow"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudNight = "partly-cloudy-night"
    case Unexpected = "default"
    
    
    init (rawValue: String) {
        switch rawValue {
            
        case "clear-day": self = .ClearDay
        case "clear-night": self = .ClearNight
        case "wind" : self = .Wind
        case "fog" :  self = .Fog
        case "sleet": self = .Sleet
        case "rain" :  self = .Rain
        case "snow" : self = .Snow
        case "cloudy" : self = .Cloudy
        case "partly-cloudy-day" : self = .PartlyCloudyDay
        case "partly-cloudy-night" : self = .PartlyCloudNight
        default: self = .Unexpected
            
        }
    }
  
}


extension WeatherIcon {
    
    var image : UIImage{
        return UIImage(named: self.rawValue)!
    }
}
