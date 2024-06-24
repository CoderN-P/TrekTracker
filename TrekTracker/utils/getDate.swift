//
//  getDate.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation


let MILLISECONDS_IN_WEEK = 168*24*60*100

func getDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter.string(from: date)
}

func getDay(date: Date) -> String{
    let index = Calendar.current.component(.weekday, from: date) // this returns an Int
    return Calendar.current.weekdaySymbols[index - 1]
}

func getBarString(_ date: Date) -> String {
    let currentDate = Date()
    
    let timeInterval = Int(currentDate.timeIntervalSince(date).rounded())
    
    if timeInterval < MILLISECONDS_IN_WEEK {
        return String(getDay(date: date).prefix(3))
    }
    
    let calendarDate = Calendar.current.dateComponents([.year], from: date)
    let currentCalendarDate = Calendar.current.dateComponents([.year], from: currentDate)
    
    
    if currentCalendarDate.year != calendarDate.year {
        let dateString = getDate(date: date)
        return "\(dateString.dropLast(3))\n\(calendarDate.year ?? 2024)"
    }
    
    return String(getDate(date: date).prefix(5))
}

func getPastDate() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.date(from: "2016/10/08 22:31") ?? Date()
}
