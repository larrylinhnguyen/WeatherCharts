//
//  WeatherViewController.swift
//  
//
//  Created by Larry on 11/30/16.
//
//

import UIKit


 class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
   

    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "b0bdf0bfd2f5f3f843956c214fcef222")
    
    let coordinate = Coordinate(latitude: 33.0, longitude: -122)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastAPIClient.fetchCurrentWeather(coordinate: coordinate){
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
}
