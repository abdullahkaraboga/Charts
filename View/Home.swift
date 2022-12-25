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
    @State var currentActiveItem: SiteView?
    @State var plotWidth: CGFloat = 0
    @State var isLineGraph: Bool = false
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
                
                Toggle("Line Graph", isOn: $isLineGraph)

            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding().navigationTitle("SwiftUI Charts")
                .onChange(of: currentTab) {
                newValue in sampleAnalytics = sample_analytics

                if newValue != "7 days" {
                    for(index, _) in sampleAnalytics.enumerated() {
                        sampleAnalytics[index].views = .random(in: 1500...10000)
                    }
                }
                animateGraph(fromChange: true)
            }
        }
    }


    @ViewBuilder
    func AnimationChart() -> some View {

        let max = sampleAnalytics.max { item1, item2 in

            return item2.views > item1.views

        }?.views ?? 0


        Chart {
            ForEach(sampleAnalytics) { item in
                
                if isLineGraph{
                    LineMark(x: .value("Hour", item.hour, unit: .hour),
                            y: .value("Views", item.animate ? item.views : 0)
                    ).interpolationMethod(.catmullRom)
                    
                    //.interpolationMethod(.catmullRom)
                    
                }else{
                    BarMark(x: .value("Hour", item.hour, unit: .hour),
                            y: .value("Views", item.animate ? item.views : 0)
                    )
                }
                

                if let currentActiveItem, currentActiveItem.id == item.id {
                    RuleMark(x: .value("Hour", currentActiveItem.hour))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top) {
                        VStack(alignment: .leading, spacing: 6) {

                            Text("Viewv").font(.caption).foregroundColor(.gray)

                            Text(currentActiveItem.views.stringFormat).font(.title3.bold())

                        }.padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous).fill(.white.shadow(.drop(radius: 42)))
                        }
                    }
                }
            }
        }.chartYScale(domain: 0...(max + 2000))
            .chartOverlay(content: { proxy in
            GeometryReader {
                innerProxy in Rectangle().fill(.clear).contentShape(Rectangle()).gesture(DragGesture().onChanged {
                    value in
                    let location = value.location

                    if let date: Date = proxy.value(atX: location.x) {
                        let calendar = Calendar.current
                        let hour = calendar.component(.hour, from: date)
                        if let currentItem = sampleAnalytics.first(where: {
                            item in calendar.component(.hour, from: item.hour) == hour
                        }) {
                            self.currentActiveItem = currentItem
                        }
                    }

                }.onEnded { vale in

                    self.currentActiveItem = nil
                    self.plotWidth = proxy.plotAreaSize.width

                }
                )
            }
        })
            .frame(height: 250)
            .onAppear {
            animateGraph()

        }
    }

    func animateGraph(fromChange: Bool = false) {
        for (index, _) in sampleAnalytics.enumerated() {

            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {

                withAnimation(fromChange ? .easeOut (duration: 0.8): .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
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
