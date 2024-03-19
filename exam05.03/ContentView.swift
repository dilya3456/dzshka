//
//  ContentView.swift
//  exam05.03
//
//  Created by ITSTEP on 05.03.2024.
//
import SwiftUI

struct ContentView: View {
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    @State private var timer: Timer?
    @State private var totalTimeInSeconds = 0
    @State private var remainingTime = 0
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $hours, label: Text("Hours")) {
                    ForEach(0..<25) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
                
                Picker(selection: $minutes, label: Text("Minutes")) {
                    ForEach(0..<60) { minute in
                        Text("\(minute)").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
                
                Picker(selection: $seconds, label: Text("Seconds")) {
                    ForEach(0..<60) { second in
                        Text("\(second)").tag(second)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
            }
            
            Button(action: startTimer) {
                Text("Start")
            }.buttonStyle(.bordered)
            Button(action: resetTimer) {
                Text("Reset")
            }.buttonStyle(.bordered)
            Button(action: stopTimer) {
                Text("Stop")
            }.buttonStyle(.bordered)
            Text("Отсчет времени: \(formatTime(remainingTime))")
        }
        
        
    }
    
    func startTimer() {
        totalTimeInSeconds = (hours * 3600) + (minutes * 60) + seconds
        remainingTime = totalTimeInSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        remainingTime = 0
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func formatTime(_ timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
