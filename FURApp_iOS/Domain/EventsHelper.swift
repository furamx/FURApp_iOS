//
//  EventsHelper.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/24/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

struct EventsHelper {
    
    func numberToText(_ number: Int) -> String {
        switch number {
            case 1:
                return "Enero"
            case 2:
                return "Febrero"
            case 3:
                return "Marzo"
            case 4:
                return "Abril"
            case 5:
                return "Mayo"
            case 6:
                return "Junio"
            case 7:
                return "Julio"
            case 8:
                return "Agosto"
            case 9:
                return "Septiembre"
            case 10:
                return "Octubre"
            case 11:
                return "Noviembre"
            case 12:
                return "Diciembre"
            default:
                return "??"
        }
    }
    
    func getTime(fromDate date: Date ) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        if minute < 10 {
            return "\(hour):\(minute)0 hrs."
        }else {
            return "\(hour):\(minute) hrs."
        }
    }
    
    func getDate(fromDate date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let monthNumber = calendar.component(.month, from: date)
        let monthText = numberToText(monthNumber)
        
        return "\(day) de \(monthText)"
    }
}
