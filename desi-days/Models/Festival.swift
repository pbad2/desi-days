import Foundation

struct Festival: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    // Lunar calendar components
    let tithi: Int          // 1-30
    let month: Int          // 1-12
    let paksha: String      // "Shukla" or "Krishna"
    var gregorianDate: Date? // Calculated date for current year
    
    // Additional information
    let significance: String?
}

// Festival data provider
class FestivalDataProvider {
    static let shared = FestivalDataProvider()
    
    private var festivals: [Festival] = [
        Festival(
            name: "Diwali",
            description: "Festival of Lights",
            tithi: 15,
            month: 7,  // Kartik
            paksha: "Krishna",
            gregorianDate: nil,
            significance: "Victory of light over darkness"
        ),
        Festival(
            name: "Holi",
            description: "Festival of Colors",
            tithi: 15,
            month: 12, // Phalguna
            paksha: "Krishna",
            gregorianDate: nil,
            significance: "Arrival of spring and victory of good over evil"
        ),
        // Add more festivals here
    ]
    
    func getFestivals() -> [Festival] {
        return festivals
    }
    
    // This will need to be implemented with a proper lunar calendar calculation
    func updateGregorianDates(for year: Int) {
        // TODO: Implement conversion logic
        // This would require integration with a Hindu calendar calculation library
    }
}
