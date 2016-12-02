//
//  APIClient.swift
//  WeatherCharts
//
//  Created by Larry on 12/1/16.
//  Copyright © 2016 Savings iOS Dev. All rights reserved.
//

import Foundation
typealias JSON = [String: AnyObject]
typealias JSONTaskCompletion = (JSON?,HTTPURLResponse?,NSError?)-> Void
typealias JSONTask = URLSessionDataTask

public let TRENetworkingErrorDomain = "com.wixsite.ln10138.WeatherCharts"
public let MissingHTTPResponseError : Int = 10
public let UnexpectedResponseError:Int = 20

enum APIResults<T> {
    case Success(T)
    case Failure(Error)
}
protocol JSONDecodable {
    init?(JSON: [ String: AnyObject])
}
protocol Endpoint {
    var baseURL : URL{get}
    var path: String {get}
    var request : URLRequest {get}
}

protocol APIClient {
    var configuration: URLSessionConfiguration {get}
    var session : URLSession {get}
    
    init(config : URLSessionConfiguration,APIKey: String)
    

    func JSONTaskWithRequest (request: URLRequest, completion: @escaping  JSONTaskCompletion) -> JSONTask
    
    func fetch<T: JSONDecodable >(request: URLRequest,parse:  @escaping (JSON) -> T?, completion: @escaping (APIResults<T>) -> Void)
    
    
}

extension APIClient {
    func JSONTaskWithRequest (request: URLRequest, completion:  @escaping JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTask(with: request){
            data, response,error in
            guard let HTTPResponse = response as? HTTPURLResponse else {
                
                let userInfo = [ NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: TRENetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil,nil,error)
                return
            }
            
            if data == nil {
                if let error = error as? NSError{
                    completion(nil,HTTPResponse,error)
                }
            } else {
                switch HTTPResponse.statusCode{
                case 200:
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                        completion(json,HTTPResponse,nil)
                        
                    } catch let error as NSError{
                        completion(nil,HTTPResponse,error)
                    }
                    
                default: print("Received HTTP Response with \(HTTPResponse.statusCode) - not handled")
                }
                
            }
            
            
        }
        return task
    }
    
    
    
    func fetch<T: JSONDecodable >(request: URLRequest,parse:  @escaping (JSON) -> T?, completion: @escaping (APIResults<T>) -> Void){
       let task =  JSONTaskWithRequest(request: request){
            json, response,error in
            guard let json = json else {
                if let error = error {
                    completion(.Failure(error))
                } else {
                    //implement error handling
                }
              return
            }
        
        if let value = parse(json) {
            completion(.Success(value))
        } else {
            let error = NSError(domain: TRENetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
            completion(.Failure(error))
        }
            
        }
        task.resume()
    }
    
}
