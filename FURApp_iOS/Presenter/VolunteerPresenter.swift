//
//  VolunteerPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/6/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseAuth

class VolunteerPresenter: NSObject, CLLocationManagerDelegate {
    
    //MARK: - Properties
    private var view: VolunteerViewController!
    private let dataManager: DataManager
    private var event: Event!
    private var auth: Auth
    private var locationManager: CLLocationManager!
    private let kDistanceAllowed: Double
    
    //MARK: - IBOutlets
    
    
    override init() {
        self.dataManager = DataManager()
        kDistanceAllowed = 30
        auth = Auth.auth()
    }
    
    func attach(view: VolunteerViewController){
        self.view = view
    }
    
    func dettachView(){
        self.view = nil
    }
    
    func loadData(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let today = calendar.component(.day, from: date)
        
        let todayString = "\(year)-\(month)-\(today)"
        let tomorrowString = "\(year)-\(month)-\(today + 2)"
        dataManager.getEventOfToday(fromPresenter: self, today: todayString, tomorrow: tomorrowString)
    }
    
    func show(data: Event?){
        if (data == nil){
            view.displayNoData()
        }else {
            self.event = data
            view.display(data: event)
        }
    }
    
    // MARK: - Business Logic
    func leaderAccessEvent() {
        if (auth.currentUser != nil) {
            self.locationManager = CLLocationManager()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                
                switch (CLLocationManager.authorizationStatus()) {
                    case .authorizedWhenInUse:
                        locationManager.startUpdatingLocation()
                        break
                    case .denied:
                        view.requestForLocation()
                        break
                    case .notDetermined:
                        locationManager.requestWhenInUseAuthorization()
                        break
                    default:
                        break
                }
            }else {
                view.requestForLocation()
            }
        }else {
            self.view.requestRegistration()
        }
    }
    
    func leaderAccessPermitted() {
        self.view.accessLeaderPermitted()
    }
    
    func leaderAccessDenied() {
        self.view.accessLeaderDenied()
    }
    
    // MARK: - Location Manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = CLLocation(coordinate: (manager.location?.coordinate)!, altitude: CLLocationDistance(), horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
        
        let eventLocation:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: event.place?.location?.latitude as! CLLocationDegrees, longitude: event.place?.location?.longitud as! CLLocationDegrees), altitude: CLLocationDistance(), horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
        
        let distance = eventLocation.distance(from: userLocation)
        
        print("user location = \(userLocation.coordinate.latitude) \(userLocation.coordinate.longitude)")
        print("event location = \(eventLocation.coordinate.latitude) \(eventLocation.coordinate.longitude)")
        print("distance = \(distance.description)")
        
        if (distance < self.kDistanceAllowed) {
            self.leaderAccessPermitted()
        }else {
            self.leaderAccessDenied()
        }
        manager.stopUpdatingLocation()
    }
}
