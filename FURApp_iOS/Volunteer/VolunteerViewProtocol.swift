//
//  VolunteerViewContract.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/29/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

protocol VolunteerViewProtocol {
    
    // MARK: - Display data
    func display(data: VolunteerEventViewData)
    func displayNoData()
    func displayNoNetwork()
    
    // MARK: - Response from presenter
    // To access as a leader, the user needs to be registered.
    func requestRegistration()
    // To access as a leader, the user needs to be at the event
    func requestLocationPermission()
    
    // MARK: Leader access resolution
    func accessLeaderGranted()
    func accessLeaderDenied()
}
