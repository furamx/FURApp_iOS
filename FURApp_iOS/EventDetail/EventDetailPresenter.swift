//
//  EventDetailPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/26/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import MapKit

class EventDetailPresenter {
    
    //MARK: - Properties
    var view: EventDetailViewController?
    var eventData: Event?
    
    // MARK: - Presenter
    init() { }
    
    func attach(view: EventDetailViewController){
        self.view = view
    }
    
    func dettachView(){
        self.view = nil
    }
    
    func load(data: Event?){
        if data != nil {
            self.eventData = data
        }
    }
    
    func show(){
        view?.titleLabel.text = eventData?.name
        view?.cityLabel.text = "\(eventData?.place?.location?.city ?? "Ciudad"), \(eventData?.place?.location?.country ?? "País")"
        if let imgString = eventData?.cover?.source! {
            let imageUrl = URL(string: imgString)
            view?.coverImageView.kf.setImage(with: imageUrl)
        }
        
        let eventsHelper = EventsHelper()
        if let date = eventData?.start_time {
            view?.dateLabel.text = eventsHelper.getDate(fromDate: date)
            view?.timeLabel.text = eventsHelper.getTime(fromDate: date)
        }
        
        view?.descriptionTextView.text = eventData?.description
        
        if let eventLocation = eventData?.place?.location {
            let mapLocation = CLLocationCoordinate2D(latitude: eventLocation.latitude as! CLLocationDegrees, longitude: eventLocation.longitud as! CLLocationDegrees)
            
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapLocation, regionRadius, regionRadius)
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapLocation
            annotation.title = eventLocation.street
            
            view?.locationMapView.setRegion(coordinateRegion, animated: true)
            view?.locationMapView.addAnnotation(annotation)
        }
    }
}
