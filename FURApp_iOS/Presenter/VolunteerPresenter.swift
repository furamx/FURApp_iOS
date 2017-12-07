//
//  VolunteerPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/6/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

class VolunteerPresenter {
    
    //MARK: - Properties
    private var view: VolunteerViewController!
    private let dataManager: DataManager
    private var event: Event!
    
    //MARK: - IBOutlets
    
    
    init() {
        self.dataManager = DataManager()
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
}
