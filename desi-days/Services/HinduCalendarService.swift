import Foundation
import SwiftUI

class HinduCalendarService: ObservableObject {
    @Published var festivals: [Date: [Festival]] = [:]
    private let festivalProvider = FestivalDataProvider.shared
    private let astrologyClient: AstrologyAPIClient
    private var userLatitude: Double = 12.9716  // Default to Bangalore, India
    private var userLongitude: Double = 77.5946
    
    init(apiKey: String = Config.astrologyAPIKey) {
        self.astrologyClient = AstrologyAPIClient(apiKey: apiKey)
        Task {
            await loadFestivals()
        }
    }
    
    convenience init() {
        self.init(apiKey: Config.astrologyAPIKey)
    }
    
    func updateLocation(latitude: Double, longitude: Double) {
        userLatitude = latitude
        userLongitude = longitude
        Task {
            await loadFestivals()
        }
    }
    
    @MainActor
    private func loadFestivals() async {
        do {
            let panchangFestivals = try await astrologyClient.fetchFestivals(
                latitude: userLatitude,
                longitude: userLongitude
            )
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            var newFestivals: [Date: [Festival]] = [:]
            
            for panchangFestival in panchangFestivals {
                if let date = dateFormatter.date(from: panchangFestival.date) {
                    let festival = Festival(
                        name: panchangFestival.name,
                        description: panchangFestival.description ?? "",
                        tithi: 0,  // These values will come from API in future
                        month: 0,
                        paksha: "",
                        gregorianDate: date,
                        significance: nil
                    )
                    
                    let startOfDay = date.startOfDay
                    var festivalsForDate = newFestivals[startOfDay] ?? []
                    festivalsForDate.append(festival)
                    newFestivals[startOfDay] = festivalsForDate
                }
            }
            
            self.festivals = newFestivals
        } catch {
            print("Error loading festivals: \(error)")
        }
    }
    
    func getFestivals(for date: Date) -> [Festival] {
        return festivals[date.startOfDay, default: []]
    }
}

// Extension to help with date comparisons
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
