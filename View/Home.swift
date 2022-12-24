//
//  Home.swift
//  ChartsWithSwiftUI
//
//  Created by Abdullah Karaboğa on 17.12.2022.
//

import SwiftUI
import Charts

struct Home: View {
    @State var sampleAnalytics: [SiteView] = sample_analytics
    @State var currentTab: String = "7 days"
    var body: some View {

        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Views").fontWeight(.semibold)

                        Picker("", selection: $currentTab) {
                            Text("7 days").tag("7 days")
                            Text("Week").tag("Week")
                            Text("Month").tag("Month")
                        }.pickerStyle(.segmented)
                            .padding(.leading, 80)
                    }


                    let totalValue = sampleAnalytics.reduce(0.0) { partialResult, item in
                        item.views + partialResult
                    }

                    Text(totalValue.stringFormat)

                    AnimationChart()
                }.padding()
                    .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white.shadow(.drop(radius: 1)))
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding().navigationTitle("SwiftUI Charts")


        }

    }


    @ViewBuilder
    func AnimationChart() -> some View {

        let max = sampleAnalytics.max { item1, item2 in

            return item2.views > item1.views

        }?.views ?? 0


        Chart {
            ForEach(sampleAnalytics) { item in
                BarMark(x: .value("Hour", item.hour, unit: .hour), y: .value("Views", item.animate ? item.views : 0))

            }
        }.chartYScale(domain: 0...(max + 2000))
            .frame(height: 250)
            .onAppear {
                for (index, _) in sampleAnalytics.enumerated(){
                    withAnimation(.easeOut(duration: 0.8).delay(Double(index)*0.05)){
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension Double {
    var stringFormat: String {
        if self >= 10000 && self < 9999999 {
            return String (format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 99999 {
            return String (format: "%.1fK", self / 1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String (format: "%.1fK", self)
    }

}
