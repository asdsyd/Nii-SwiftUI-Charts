import SwiftUI
import Charts

struct SunPathData: Identifiable {
    let id = UUID()
    let time: Date
    let elevation: Double

    static let mockData: [SunPathData] = generateSunPathData()
}

struct SunPathChartView: View {
    @State private var tappedDate: Date? = nil
    @State private var data: [SunPathData] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Total daylight 16h 36m")
                .font(.headline)
                .foregroundStyle(.white)

            Chart(data) { item in
                LineMark(
                    x: .value("Time", item.time),
                    y: .value("Elevation", item.elevation)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .blue,
                            .white,
                            .yellow,
                            .yellow,
                            .yellow,
                            .yellow,
                            .yellow,
                            .white,
                            .blue
                        ],
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
                }

                // ✅ Only show RuleMark if tapped 7 AM or 7 PM
                if let tappedDate,
                   isTime(item.time, equalToHour: 7) || isTime(
                    item.time,
                    equalToHour: 19
                   ),
                   Calendar.current.isDate(tappedDate, equalTo: item.time, toGranularity: .hour) {
                    RuleMark(x: .value("Time", item.time))
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .foregroundStyle(.white.opacity(0.4))
                        .annotation(
                            position: .top,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )) {
                                Text("T")
                            }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
            .chartYScale(domain: 0...50)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let location = value.location
                                    if let date: Date = proxy.value(atX: location.x) {
                                        tappedDate = date
                                        print("Tapped date:", date)
                                    }
                                }
                        )
                }
            }
            .frame(height: 103)
        }
        .padding()
        .onAppear {
            data = SunPathData.mockData
        }
    }

    func isTime(_ date: Date, equalToHour hour: Int) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date) == hour &&
               calendar.component(.minute, from: date) == 0
    }
}

func generateSunPathData() -> [SunPathData] {
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: Date())
    let totalMinutes = (20 - 6) * 60
    let padding = 30
    let maxHeight: Double = 40

    var result: [SunPathData] = []
    for minute in stride(from: -padding, through: totalMinutes + padding, by: 5) {
        let time = calendar.date(byAdding: .minute, value: (6 * 60) + minute, to: startOfDay)!
        let x = Double(minute + padding) / Double(totalMinutes + 2 * padding)
        let z = (x - 0.5) * 2
        let sigma: Double = 0.34
        let gauss = exp(-0.5 * pow(z / sigma, 2))
        let elevation = gauss * maxHeight
        result.append(.init(time: time, elevation: elevation))
    }

    return result
}

#Preview {
    SunPathChartView()
        .preferredColorScheme(.dark)
}





//import SwiftUI
//import Charts
//
//struct SunPathData: Identifiable {
//    let id = UUID()
//    let time: Date
//    let elevation: Double
//
//    static let mockData: [SunPathData] = generateSunPathData()
//}
//
//struct SunPathChartView: View {
//    @State private var selectedDataPoint: SunPathData?
//    @State private var rawSelectedDataPoint: Date?
//    @State private var data: [SunPathData] = []
//
//    var selectedViewHour: SunPathData? {
//        guard let rawSelectedDataPoint else { return nil }
//        return SunPathData.mockData.first {
//            Calendar.current.isDate(rawSelectedDataPoint, equalTo: $0.time, toGranularity: .hour)
//        }
//    }
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Total daylight 16h 36m")
//                .font(.headline)
//                .foregroundStyle(.white)
//
//            Chart(data) { item in
//                
////                if let selectedViewHour {
////                    RuleMark(
////                        x:
////                                .value(
////                                    "Selected Hour",
////                                    selectedViewHour.time,
////                                    unit: .hour
////                                )
////                    )
////                }
//                
//                
//                LineMark(
//                    x: .value("Time", item.time),
//                    y: .value("Elevation", item.elevation)
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
//                
//
//                if isTime(item.time, equalToHour: 7) || isTime(item.time, equalToHour: 19) {
//                    
//                    PointMark(
//                        x: .value("Time", item.time),
//                        y: .value("Elevation", item.elevation)
//                    )
//                    .symbolSize(40)
//                    .foregroundStyle(.cyan)
//                    .accessibilityLabel("\(hourFormatter.string(from: item.time)), \(Int(item.elevation))° elevation")
//                }
//
//                if isTime(item.time, equalToHour: 7) {
//                    RuleMark(x: .value("Time", item.time))
//                        .lineStyle(StrokeStyle(lineWidth: 2))
//                        .foregroundStyle(.white.opacity(0.4))
//                }
//                
//            }
//            .chartXSelection(value: $rawSelectedDataPoint)
//            .onChange(of: rawSelectedDataPoint) { _, newValue in
//                print("Selected time:", newValue?.formatted() ?? "nil")
//                if let selected = selectedViewHour {
//                    print("Selected elevation: \(selected.elevation)")
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
//        }
//        .padding()
//        .onAppear {
//            data = SunPathData.mockData
//        }
//    }
//
//    func isTime(_ date: Date, equalToHour hour: Int) -> Bool {
//        let calendar = Calendar.current
//        return calendar.component(.hour, from: date) == hour &&
//               calendar.component(.minute, from: date) == 0
//    }
//
//    var hourFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "h a"
//        return formatter
//    }
//}
//
//func generateSunPathData() -> [SunPathData] {
//    let calendar = Calendar.current
//    let startOfDay = calendar.startOfDay(for: Date())
//    let totalMinutes = (20 - 6) * 60
//    let padding = 30
//    let maxHeight: Double = 40
//
//    var result: [SunPathData] = []
//    for minute in stride(from: -padding, through: totalMinutes + padding, by: 5) {
//        let time = calendar.date(byAdding: .minute, value: (6 * 60) + minute, to: startOfDay)!
//        let x = Double(minute + padding) / Double(totalMinutes + 2 * padding)
//        let z = (x - 0.5) * 2
//        let sigma: Double = 0.34
//        let gauss = exp(-0.5 * pow(z / sigma, 2))
//        let elevation = gauss * maxHeight
//        result.append(.init(time: time, elevation: elevation))
//    }
//
//    return result
//}
//
//#Preview {
//    SunPathChartView()
//        .preferredColorScheme(.dark)
//}
