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
    SiteView(hour: Date().updateHour(value: 8), views: 15400),
    SiteView(hour: Date().updateHour(value: 9), views: 15050),
    SiteView(hour: Date().updateHour(value: 18), views: 15600),
    SiteView(hour: Date().updateHour(value: 28), views: 15070),
    SiteView(hour: Date().updateHour(value: 28), views: 15004),
    SiteView(hour: Date().updateHour(value: 18), views: 15400),
    SiteView(hour: Date().updateHour(value: 8), views: 15040),
    SiteView(hour: Date().updateHour(value: 28), views: 14500),
    SiteView(hour: Date().updateHour(value: 18), views: 14500),
    SiteView(hour: Date().updateHour(value: 8), views: 15040),


]
