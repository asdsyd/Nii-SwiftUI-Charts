//
//  SunriseSunsetChart.swift
//  Nii-SwiftUI-Charts
//
//  Created by Asad Sayeed on 29/07/25.
//

import SwiftUI
import Charts

// 1. Define the data structure for each point on the curve
struct SunPosition: Identifiable {
    let id = UUID()
    let time: String // Using String for simple labeling
    let altitude: Double
}

// 2. Create the data for the curve
// We'll generate points that form a sine-like curve.
let sunPathData: [SunPosition] = [
    .init(time: "Sunrise", altitude: 0.0),
    .init(time: "Mid-morning", altitude: 0.7),
    .init(time: "Noon", altitude: 1.0),
    .init(time: "Afternoon", altitude: 0.7),
    .init(time: "Sunset", altitude: 0.0)
]

struct SunriseSunsetChart: View {
    // The current progress of the sun (e.g., 0.8 = 80% through the day)
    let currentSunAltitude = 0.8

    var body: some View {
        VStack(spacing: 8) {
            // Main Chart View
            Chart(sunPathData) { point in
                // The main smooth curve for the sun's path
                LineMark(
                    x: .value("Time", point.time),
                    y: .value("Altitude", point.altitude)
                )
                .interpolationMethod(.cardinal) // This makes the curve smooth!
                .foregroundStyle(Color.white.opacity(0.8))

                // The circle representing the current sun position
                if point.altitude == 0.7 && currentSunAltitude == 0.8 { // A simple check to place the dot
                    PointMark(
                        x: .value("Time", "Afternoon"),
                        y: .value("Altitude", 0.7) // Position it on the curve
                    )
                    .symbolSize(150)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                }

                // The horizontal line representing the horizon
                RuleMark(y: .value("Horizon", 0.0))
                    .foregroundStyle(Color.white.opacity(0.5))
                    .lineStyle(StrokeStyle(lineWidth: 1))
            }
            .chartYAxis(.hidden) // Hide the Y-axis labels
            .chartXAxis {
                // Custom X-axis to show only Sunrise and Sunset times
                AxisMarks(values: ["Sunrise", "Sunset"]) { value in
                    AxisValueLabel() {
                        if let label = value.as(String.self) {
                            Text(label == "Sunrise" ? "Sunrise: 5:53AM" : "6:36PM")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .frame(height: 150)
            .padding()
        }
        .background(Color(red: 0.35, green: 0.35, blue: 0.55))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    SunriseSunsetChart()
}

#Preview {
    SunriseSunsetChart()
}
