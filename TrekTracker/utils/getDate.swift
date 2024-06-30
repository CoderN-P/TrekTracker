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
    
    let calendar = Calendar.current
    
    if date >= calendar.date(byAdding: .day, value: -7, to: Date())!{
        return String(getDay(date: date).prefix(3))
    }
    
    let calendarDate = Calendar.current.dateComponents([.year], from: date)
    let currentCalendarDate = Calendar.current.dateComponents([.year], from: currentDate)
    
    
    if currentCalendarDate.year != calendarDate.year {
        let dateString = getDate(date: date)
        return "\(dateString.dropLast(3))\n\(calendarDate.year ?? 2024)"
    }
    
    return String(getDate(date: date).dropLast(3))
}

func getPastDate() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.date(from: "2016/10/08 22:31") ?? Date()
}

func formatSeconds(_ seconds: Int) -> String {
    if seconds < 60 {
        if seconds < 10 {
            return "00:0\(seconds)"
        }
        return "00:\(seconds)"
    }
    
    if seconds < 3600 {
        let minutes = Int(seconds/60)
        let remainingSeconds = seconds%60

        if remainingSeconds < 10 {
            return "\(minutes):0\(remainingSeconds)"
        }
        return "\(minutes):\(remainingSeconds)"
    }
    
    return ""
}
