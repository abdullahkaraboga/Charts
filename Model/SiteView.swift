//
//  SiteView.swift
//  ChartsWithSwiftUI
//
//  Created by Abdullah Karaboğa on 17.12.2022.
//

import SwiftUI


struct SiteView: Identifiable {

    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false

}

extension Date {

    func updateHour(value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var sample_analytics : [SiteView] = [
    SiteView(hour: Date().updateHour(value: 1), views: 1400),
    SiteView(hour: Date().updateHour(value: 2), views: 1050),
    SiteView(hour: Date().updateHour(value: 2), views: 1050),
    SiteView(hour: Date().updateHour(value: 3), views: 1600),
    SiteView(hour: Date().updateHour(value: 4), views: 1070),
    SiteView(hour: Date().updateHour(value: 5), views: 1000),
    SiteView(hour: Date().updateHour(value: 6), views: 1400),
    SiteView(hour: Date().updateHour(value: 7), views: 1040),
    SiteView(hour: Date().updateHour(value: 8), views: 1500),
    SiteView(hour: Date().updateHour(value: 9), views: 1500),
    SiteView(hour: Date().updateHour(value: 10), views: 1500),
    SiteView(hour: Date().updateHour(value: 11), views: 1040),
    SiteView(hour: Date().updateHour(value: 12), views: 1040),


]
