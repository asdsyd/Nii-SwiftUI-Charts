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
//struct SunPathData: Identifiable, Equatable {
//    let id = UUID()
//    let time: Date
//    let elevation: Double
//}
//
//struct SunPathChartView: View {
//    @State private var data: [SunPathData] = []
//    @State private var selectedPoint: SunPathData?
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Total daylight 16h 36m")
//                .font(.headline)
//                .foregroundStyle(.white)
//
//            Chart {
//                ForEach(data) { point in
//                    LineMark(
//                        x: .value("Time", point.time),
//                        y: .value("Elevation", point.elevation)
//                    )
//                    .interpolationMethod(.catmullRom)
//                    .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
//                    .foregroundStyle(
//                        LinearGradient(
//                            colors: [.blue, .white, .yellow, .yellow, .white, .blue],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
//
//                    // Only show dots at 7 AM and 7 PM
//                    if isTime(point.time, equalToHour: 7) || isTime(point.time, equalToHour: 19) {
//                        PointMark(
//                            x: .value("Time", point.time),
//                            y: .value("Elevation", point.elevation)
//                        )
//                        .symbolSize(40)
//                        .foregroundStyle(.cyan)
//                    }
//                }
//            }
//            .chartYScale(domain: 0...50)
////            .chartXAxis {
////                AxisMarks(values: .stride(by: .hour, count: 2)) { value in
////                    AxisTick().foregroundStyle(.white)
////                    AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
////                        .foregroundStyle(.white)
////                }
////            }
//            .chartYAxis {
//                AxisMarks(position: .leading) {
//                    AxisGridLine().foregroundStyle(.white.opacity(0.3))
//                }
//            }
//            .frame(height: 130)
//
//            // Handle tap via chartOverlay
//            .chartOverlay { proxy in
//                GeometryReader { geo in
//                    Rectangle()
//                        .fill(.clear)
//                        .contentShape(Rectangle())
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onEnded { value in
//                                    let location = value.location
//                                    if let date: Date = proxy.value(atX: location.x),
//                                       let nearest = nearestSunDot(to: date) {
//                                        selectedPoint = nearest
//                                    }
//                                }
//                        )
//                }
//            }
//
//            // Popover for selected point
//            .popover(item: $selectedPoint, arrowEdge: .top) { point in
//                VStack(spacing: 6) {
//                    Text(hourFormatter.string(from: point.time))
//                        .font(.headline)
//                    Text("\(Int(point.elevation))°")
//                        .font(.subheadline)
//                }
//                .padding(10)
//                .background(.ultraThinMaterial)
//                .cornerRadius(10)
//                .foregroundColor(.white)
//            }
//        }
//        .padding()
//        .onAppear {
//            data = generateSunPathData()
//        }
//    }
//
//    // MARK: - Helpers
//
//    func isTime(_ date: Date, equalToHour hour: Int) -> Bool {
//        let calendar = Calendar.current
//        return calendar.component(.hour, from: date) == hour &&
//               calendar.component(.minute, from: date) == 0
//    }
//
//    func nearestSunDot(to tappedTime: Date) -> SunPathData? {
//        let calendar = Calendar.current
//        return data.first(where: {
//            (isTime($0.time, equalToHour: 7) || isTime($0.time, equalToHour: 19)) &&
//            abs($0.time.timeIntervalSince(tappedTime)) < 60 * 30
//        })
//    }
//
//    func generateSunPathData() -> [SunPathData] {
//        let calendar = Calendar.current
//        let startOfDay = calendar.startOfDay(for: Date())
//        let totalMinutes = (20 - 6) * 60
//        let padding = 30
//        let maxHeight: Double = 40
//
//        var result: [SunPathData] = []
//        for minute in stride(from: -padding, through: totalMinutes + padding, by: 5) {
//            let time = calendar.date(byAdding: .minute, value: (6 * 60) + minute, to: startOfDay)!
//            let x = Double(minute + padding) / Double(totalMinutes + 2 * padding)
//            let z = (x - 0.5) * 2
//            let sigma: Double = 0.34
//            let gauss = exp(-0.5 * pow(z / sigma, 2))
//            let elevation = gauss * maxHeight
//            result.append(.init(time: time, elevation: elevation))
//        }
//
//        return result
//    }
//
//    var hourFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "h a"
//        return formatter
//    }
//}
//
//#Preview {
//    SunPathChartView()
//        .preferredColorScheme(.dark)
//}
