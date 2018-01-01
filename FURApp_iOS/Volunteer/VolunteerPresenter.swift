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
    private var view: VolunteerView!
    private let service: VolunteerService
    private var event: Event!
    private var auth: Auth
    private var locationManager: CLLocationManager!
    private let kDistanceAllowed: Double
    
    init(withService service: VolunteerService) {
        self.service = service
        kDistanceAllowed = 30
        auth = Auth.auth()
    }
    
    func attach(view: VolunteerView){
        self.view = view
    }
    
    func dettachView(){
        self.view = nil
    }
    
    // To load the presenter, it gets today's date and tomorrow's date + 2 days.
    // It is plus 2 days because the Graph Api has a bug which sometimes it doesn't get
    // the correct event, even though the dates are correct and an event exists.
    func load(){
        guard ConnectionHelper.isConnectedToNetwork() else {
            self.view.displayNoNetwork()
            return
        }
        
        let todayDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: todayDate)
        let month = calendar.component(.month, from: todayDate)
        let today = calendar.component(.day, from: todayDate)
        
        let tomorrowDate = calendar.date(byAdding: .day, value: 2, to: todayDate)
        let uYear = calendar.component(.year, from: tomorrowDate!)
        let uMonth = calendar.component(.month, from: tomorrowDate!)
        let uToday = calendar.component(.day, from: tomorrowDate!)
        
        let todayString = "\(year)-\(month)-\(today)"
        let untilString = "\(uYear)-\(uMonth)-\(uToday)"
        
        self.service.getEventOfToday(since: todayString, until: untilString, callback: show(data:))
    }
    
    // Before showing the information, it checks that the event's date corresponds to today's date.
    // For more information about the bug, check self.load() comments.
    func show(data: Event?){
        guard data != nil else {
            self.view.displayNoData()
            return
        }

        let today = Date()
        let calendar = Calendar.current

        let difference = calendar.dateComponents([.day], from: today, to: data!.start_time!)
        if (difference.day == 0) {
            self.event = data
            let viewData = VolunteerEventViewData(name: self.event.name ?? "Evento")
            self.view.display(data: viewData)
        }else {
            self.view.displayNoData()
        }
    }
    
    // MARK: - Business Logic
    
    // A leader needs to be registered in the system.
    // When a leader tries to access an event, we need to check that he is indeen at the event's location.
    // For more information check self.verify(userLocation:)
    func leaderAccessEvent() {
        guard auth.currentUser != nil else {
            self.view.requestRegistration()
            return
        }
        
        self.locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            switch (CLLocationManager.authorizationStatus()) {
                case .authorizedWhenInUse:
                    locationManager.startUpdatingLocation()
                    break
                case .denied:
                    view.requestLocationPermission()
                    break
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    break
                default:
                    break
            }
        }else {
            view.requestLocationPermission()
        }
    }
    
    // Gets the user location and compares it to the event's. If the distance between the 2 is greater than `kDistanceAllowed`
    // the leader's access is denied. Otherwise, the access is granted.
    func verify(userLocation: CLLocation) {
        let eventLocation:CLLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: event.place?.location?.latitude as! CLLocationDegrees, longitude: event.place?.location?.longitud as! CLLocationDegrees), altitude: CLLocationDistance(), horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
        
        let distance = eventLocation.distance(from: userLocation)
        
        if (distance < self.kDistanceAllowed) {
            self.leaderAccessGranted()
        }else {
            self.leaderAccessDenied()
        }
    }
    
    func leaderAccessGranted() {
        self.view.accessLeaderPermitted()
    }
    
    func leaderAccessDenied() {
        self.view.accessLeaderDenied()
    }
    
    // MARK: - Location Manager delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }
        
        self.verify(userLocation: userLocation)
        manager.stopUpdatingLocation()
    }
}
