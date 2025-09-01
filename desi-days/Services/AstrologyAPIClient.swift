import Foundation

struct AstrologyAPIResponse: Codable {
    let festivals: [PanchangFestival]
    
    enum CodingKeys: String, CodingKey {
        case festivals = "festivals"
    }
}

struct PanchangFestival: Codable {
    let name: String
    let description: String?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case date = "date"
    }
}

class AstrologyAPIClient {
    private let apiKey: String
    private let baseURL = "https://api.astrologyapi.com/v1"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchFestivals(latitude: Double, longitude: Double, date: Date = Date()) async throws -> [PanchangFestival] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        
        let endpoint = "/festival_dates"
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(apiKey.data(using: .utf8)?.base64EncodedString() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "date": dateString,
            "lat": latitude,
            "lon": longitude
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(AstrologyAPIResponse.self, from: data)
        return apiResponse.festivals
    }
}
