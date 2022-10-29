//
//  ViewController.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 22.10.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - UI ELEMENTS
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPrecipitation: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    // MARK: - PROPERTİES
    
    let client = WeatherApiClient()
   var locationManager = CLLocationManager()

    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    // MARK: - FUNCTİONS
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue = manager.location!.coordinate
        let clientCordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        updateWeather(coordinate: clientCordinate)
    }
    
    func showWeather(model: CurrentWeatherModel) {
        lblSummary.text = model.summary
        lblHumidity.text = model.humidity
        lblTemperature.text = model.temperature
        lblPrecipitation.text = model.precipitationProbability
        weatherIcon.image = model.icon
        
        indicator.stopAnimating()
        
    }
    
    func updateWeather(coordinate: Coordinate){
        client.getCurrentWeather(at: coordinate) {currentWeather,error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                DispatchQueue.main.async {
                    self.showWeather(model: viewModel)
                }
            }
        }
    }
    
    // MARK: - ACTİONS
    
    
    @IBAction func refeshButtonClicked(_ sender: UIButton) {
        
        indicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
    }
    
}

