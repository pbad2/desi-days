//
//  ContentView.swift
//  desi-days
//
//  Created by Pallavi Badanahatti on 8/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @EnvironmentObject var hinduCalendarService: HinduCalendarService

    var body: some View {
        NavigationStack {
            VStack {
                CalendarView(selectedDate: $selectedDate)
                
                Divider()

                ScrollView {
                    FestivalDetailsView(festivals: hinduCalendarService.getFestivals(for: selectedDate))
                        .padding(.vertical, 4)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Desi Days")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HinduCalendarService())
    }
}
