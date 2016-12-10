//
//  WeatherViewController.swift
//  
//
//  Created by Larry on 11/30/16.
//
//

import UIKit
import CoreLocation


 class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
  
    
    
    let settingURL =
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    
    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "b0bdf0bfd2f5f3f843956c214fcef222")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       let coordinate = Coordinate(latitude: 31.2, longitude: 133.4)
        
        forecastAPIClient.fetchCurrentWeather(coordinate: coordinate ){
            result in
            switch result {
            case .Success(let currentWeather):
                print(currentWeather)
            case .Failure(let error as NSError):
                print(error)
            default:
                print("nothing")
            }
        }
              
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTBC
        
        
        return cell
    }
    
    //
    
    

    
    //Notification
    
    func showSimpleAlert( title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .default,
            handler: nil
        )
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
   
    
    
}
