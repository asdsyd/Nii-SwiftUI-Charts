////
////  SunPathChartView.swift
////  Nii-SwiftUI-Charts
////
////  Created by Asad Sayeed on 29/07/25.
////
//
//import SwiftUI
//import Charts
//
//struct SunPathData: Identifiable {
//    let id = UUID()
//    let time: Date
//    let elevation: Double
//}
//
//struct SunPathChartView: View {
//    @State private var data: [SunPathData] = []
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Total daylight 16h 36m")
//                .font(.headline)
//                .foregroundStyle(.white)
//
//            Chart(data) {
//                LineMark(
//                    x: .value("Time", $0.time),
//                    y: .value("Elevation", $0.elevation)
//                )
//                .interpolationMethod(.catmullRom)
//                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
////                .foregroundStyle(.yellow)
//                .foregroundStyle(
//                    LinearGradient(
//                        colors: [
//                            .blue,
//                            .white,
//                            .yellow,
//                            .yellow,
//                            .yellow,
//                            .yellow,
//                            .white,
//                            .blue
//                        ],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//
//
//                AreaMark(
//                    x: .value("Time", $0.time),
//                    y: .value("Elevation", $0.elevation)
//                )
//                .foregroundStyle(.yellow.opacity(0.15))
//
//                // sunrise/sunset dots
//                if $0.time == data.first?.time || $0.time == data.last?.time {
//                    PointMark(
//                        x: .value("Time", $0.time),
//                        y: .value("Elevation", $0.elevation)
//                    )
//                    .symbolSize(40)
//                    .foregroundStyle(.cyan)
//                }
//                
//                // Add selector line from bottom to sun dot (at sunrise and sunset)
//                if $0.time == data.first?.time || $0.time == data.last?.time {
//                    RuleMark(
//                        x: .value("Time", $0.time)
//                    )
//                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
//                    .foregroundStyle(.white.opacity(0.4))
//                }
//
//            }
//            .chartXAxis {
//                AxisMarks(values: .stride(by: .hour, count: 2)) { _ in
//                    AxisTick().foregroundStyle(.white)
//                    AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
//                        .foregroundStyle(.white)
//                }
//            }
//            .chartYAxis {
//                AxisMarks(position: .leading) {
//                    AxisGridLine()
//                        .foregroundStyle(.white.opacity(0.3))
//                }
//            }
//            .chartYScale(domain: 0...50)
//            .frame(height: 103)
//
////            HStack(spacing: 40) {
////                VStack(alignment: .leading, spacing: 4) {
////                    HStack(spacing: 8) {
////                        Image(systemName: "thermometer.medium")
////                            .foregroundColor(.orange)
////                        Text("Temp")
////                            .foregroundColor(.white)
////                    }
////                    Text("78°H 51°L")
////                        .font(.system(size: 24, weight: .medium))
////                        .foregroundColor(.white)
////                }
////
////                VStack(alignment: .leading, spacing: 4) {
////                    HStack(spacing: 8) {
////                        Image(systemName: "thermometer.medium")
////                            .foregroundColor(.orange)
////                        Text("Feels like")
////                            .foregroundColor(.white)
////                    }
////                    Text("85°")
////                        .font(.system(size: 24, weight: .medium))
////                        .foregroundColor(.white)
////                }
////                Spacer()
////            }
////            .padding(.horizontal)
//        }
//        .padding()
////        .background(Color(red: 0.15, green: 0.2, blue: 0.4).cornerRadius(20))
//        .onAppear {
//            data = generateSunPathData()
//        }
//    }
//
//    func generateSunPathData() -> [SunPathData] {
//        let calendar = Calendar.current
//        let startOfDay = calendar.startOfDay(for: Date())
//        let totalMinutes = (20 - 6) * 60
//        let padding = 30 // minutes padding before 6am / after 8pm
//        let maxHeight: Double = 40
//
//        var result: [SunPathData] = []
//        for minute in stride(from: -padding, through: totalMinutes + padding, by: 5) {
//            let time = calendar.date(byAdding: .minute, value: (6 * 60) + minute, to: startOfDay)!
//            // Map minute → x ∈ [0,1]
//            let x = Double(minute + padding) / Double(totalMinutes + 2 * padding)
//            // Convert to z ∈ [-1,1]
//            let z = (x - 0.5) * 2
//            // Gaussian with σ controlling width (σ ~0.6 gives good spread)
//            let sigma: Double = 0.34
//            let gauss = exp(-0.5 * pow(z / sigma, 2))
//            let elevation = gauss * maxHeight
//            result.append(.init(time: time, elevation: elevation))
//        }
//
//        return result
//    }
//}
//
//#Preview {
//    SunPathChartView()
//        .preferredColorScheme(.dark)
//}
//  
