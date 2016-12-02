//
//  ForecaseAPIClient.swift
//  WeatherCharts
//
//  Created by Larry on 12/1/16.
//  Copyright © 2016 Savings iOS Dev. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude : Double
    let longitude : Double
}

enum Forecast: Endpoint {
    case Current(token: String, coordinate: Coordinate)
    
    var baseURL: URL{
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case .Current(let token, let coordinate):
            return "/forecast/\(token)/\(coordinate.latitude),\(coordinate.longitude)"
        }
    }
    
    var request: URLRequest{
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}


final class ForecastAPIClient : APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
            return URLSession(configuration:self.configuration)
    }()
    
    private let token : String
    
    init(config: URLSessionConfiguration, APIKey: String){
        self.configuration = config
        self.token = APIKey
    }
    
    
    convenience init(APIKey: String ){
        self.init(config: URLSessionConfiguration.default, APIKey:APIKey)
    }
    
    func fetchCurrentWeather(coordinate: Coordinate, completion: @escaping (APIResults<CurrentWeather>) -> Void){
        
        let request = Forecast.Current(token: self.token, coordinate: coordinate).request
        fetch(request:request, parse: {
            json -> CurrentWeather? in
            if let currentWeatherDict = json["currently"] as? [String: AnyObject]{
                return CurrentWeather(JSON: currentWeatherDict)
            } else {
                return nil
            }
            
            
        }, completion: completion)
        
    }
    
}
