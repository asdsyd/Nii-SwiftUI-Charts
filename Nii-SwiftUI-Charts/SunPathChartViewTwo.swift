//
//  SunPathChartView.swift
//  Nii-SwiftUI-Charts
//
//  Created by Asad Sayeed on 29/07/25.
//

import SwiftUI
import Charts

struct SunPathDataTwo: Identifiable {
    let id = UUID()
    let time: Date
    let elevation: Double
}

struct SunPathChartViewTwo: View {
    @State private var selectedDataPoint: SunPathDataTwo?
    
    @State private var rawSelectedDate: Date?

    @State private var data: [SunPathDataTwo] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Total daylight 16h 36m")
                .font(.headline)
                .foregroundStyle(.white)

//            Chart(data) {
//                LineMark(
//                    x: .value("Time", $0.time),
//                    y: .value("Elevation", $0.elevation)
//                )
//                .interpolationMethod(.catmullRom)
//                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
//                .foregroundStyle(
//                    LinearGradient(
//                        colors: [.blue, .white, .yellow, .yellow, .yellow, .yellow, .white, .blue],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//
////                AreaMark(
////                    x: .value("Time", $0.time),
////                    y: .value("Elevation", $0.elevation)
////                )
////                .foregroundStyle(.yellow.opacity(0.15))
//
//                // Dot and line at 7 AM and 7 PM
//                if isTime($0.time, equalToHour: 7) || isTime($0.time, equalToHour: 19) {
//                    PointMark(
//                        x: .value("Time", $0.time),
//                        y: .value("Elevation", $0.elevation)
//                    )
//                    .symbolSize(40)
//                    .foregroundStyle(.cyan)
//                    .accessibilityLabel("\(hourFormatter.string(from: $0.time)), \(Int($0.elevation))° elevation")
//                    .annotation(position: .top, spacing: 4) {
//                        if selectedDataPoint?.id == $0.id {
//                            Text("\(hourFormatter.string(from: $0.time))\n\(Int($0.elevation))°")
//                                .padding(6)
//                                .background(.ultraThinMaterial)
//                                .cornerRadius(8)
//                                .foregroundStyle(.white)
//                        }
//                    }
//                }
//
//                
//                
////                if isTime($0.time, equalToHour: 7) || isTime($0.time, equalToHour: 19) {
////                    PointMark(
////                        x: .value("Time", $0.time),
////                        y: .value("Elevation", $0.elevation)
////                    )
////                    .symbolSize(40)
////                    .foregroundStyle(.cyan)
////                    
////                    
//////
//////                    RuleMark(
//////                        x: .value("Time", $0.time)
//////                    )
//////                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
//////                    .foregroundStyle(.white.opacity(0.4))
////                }
//                
//                if isTime($0.time, equalToHour: 7) {
//
//                    RuleMark(
//                        x: .value("Time", $0.time)
//                    )
//                    .lineStyle(StrokeStyle(lineWidth: 2))
//                    .foregroundStyle(.white.opacity(0.4))
//                }
//            }
            Chart(data) { item in
                LineMark(
                    x: .value("Time", item.time),
                    y: .value("Elevation", item.elevation)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .white, .yellow, .yellow, .yellow, .yellow, .white, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

                if isTime(item.time, equalToHour: 7) || isTime(item.time, equalToHour: 19) {
                    PointMark(
                        x: .value("Time", item.time),
                        y: .value("Elevation", item.elevation)
                    )
                    .symbolSize(40)
                    .foregroundStyle(.cyan)
                    .accessibilityLabel("\(hourFormatter.string(from: item.time)), \(Int(item.elevation))° elevation")
                }

                if isTime(item.time, equalToHour: 7) {
                    RuleMark(
                        x: .value("Time", item.time)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .foregroundStyle(.white.opacity(0.4))
                }
            }
            .chartXSelection(value: $rawSelectedDate)
            .onChange(of: rawSelectedDate, { oldValue, newValue in
                print(newValue)
            })
            
            
//            .chartOverlay { proxy in
//                GeometryReader { geometry in
//                    Rectangle()
//                        .fill(Color.clear)
//                        .contentShape(Rectangle())
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onEnded { value in
//                                    let location = value.location
//                                    if let date: Date = proxy.value(atX: location.x),
//                                       let closest = data.min(by: { abs($0.time.timeIntervalSince(date)) < abs($1.time.timeIntervalSince(date)) }),
//                                       isTime(closest.time, equalToHour: 7) || isTime(closest.time, equalToHour: 19) {
//                                        selectedDataPoint = closest
//                                    }
//                                }
//                        )
//                }
//            }
//            .chartOverlay { proxy in
//                GeometryReader { geometry in
//                    Rectangle()
//                        .fill(.clear)
//                        .contentShape(Rectangle())
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onEnded { value in
//                                    let location = value.location
//                                    if let date: Date = proxy.value(atX: location.x),
//                                       let closest = data.min(by: { abs($0.time.timeIntervalSince(date)) < abs($1.time.timeIntervalSince(date)) }) {
//                                        selectedDataPoint = closest
//                                    }
//                                }
//                        )
//                        // Position the popover
//                        .popover(item: $selectedDataPoint) { point in
//                            VStack(spacing: 4) {
//                                Text(hourFormatter.string(from: point.time))
//                                    .font(.headline)
//                                Text("\(Int(point.elevation))°")
//                                    .font(.subheadline)
//                            }
//                            .padding()
//                            .background(.ultraThinMaterial)
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                        }
//                }
//            }


//            .chartXAxis {
//                AxisMarks(values: .stride(by: .hour, count: 2)) { _ in
//                    AxisTick().foregroundStyle(.white)
//                    AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
//                        .foregroundStyle(.white)
//                }
//            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
            .chartYScale(domain: 0...50)
            .frame(height: 103)

//            HStack(spacing: 40) {
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "thermometer.medium")
//                            .foregroundColor(.orange)
//                        Text("Temp")
//                            .foregroundColor(.white)
//                    }
//                    Text("78°H 51°L")
//                        .font(.system(size: 24, weight: .medium))
//                        .foregroundColor(.white)
//                }
//
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "thermometer.medium")
//                            .foregroundColor(.orange)
//                        Text("Feels like")
//                            .foregroundColor(.white)
//                    }
//                    Text("85°")
//                        .font(.system(size: 24, weight: .medium))
//                        .foregroundColor(.white)
//                }
//                Spacer()
//            }
//            .padding(.horizontal)
        }
        .padding()
//        .background(Color(red: 0.15, green: 0.2, blue: 0.4).cornerRadius(20))
        .onAppear {
            data = generateSunPathDataTwo()
        }
    }
    
    func isTime(_ date: Date, equalToHour hour: Int) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date) == hour &&
               calendar.component(.minute, from: date) == 0
    }


    func generateSunPathDataTwo() -> [SunPathDataTwo] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let totalMinutes = (20 - 6) * 60
        let padding = 30 // minutes padding before 6am / after 8pm
        let maxHeight: Double = 40

        var result: [SunPathDataTwo] = []
        for minute in stride(from: -padding, through: totalMinutes + padding, by: 5) {
            let time = calendar.date(byAdding: .minute, value: (6 * 60) + minute, to: startOfDay)!
            // Map minute → x ∈ [0,1]
            let x = Double(minute + padding) / Double(totalMinutes + 2 * padding)
            // Convert to z ∈ [-1,1]
            let z = (x - 0.5) * 2
            // Gaussian with σ controlling width (σ ~0.6 gives good spread)
            let sigma: Double = 0.34
            let gauss = exp(-0.5 * pow(z / sigma, 2))
            let elevation = gauss * maxHeight
            result.append(.init(time: time, elevation: elevation))
        }

        return result
    }
    
    
    var hourFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }

}

#Preview {
    SunPathChartViewTwo()
        .preferredColorScheme(.dark)
}
  
