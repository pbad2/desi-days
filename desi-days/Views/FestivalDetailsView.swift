import SwiftUI

struct FestivalDetailsView: View {
    let festivals: [Festival]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Festivals")
                .font(.headline)
                .padding(.bottom, 8)
            
            if festivals.isEmpty {
                Text("No festivals on this date")
                    .foregroundColor(.secondary)
                    .italic()
            } else {
                ForEach(festivals) { festival in
                    FestivalCard(festival: festival)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FestivalCard: View {
    let festival: Festival
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(festival.name)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(festival.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let significance = festival.significance {
                Text(significance)
                    .font(.caption)
                    .italic()
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    FestivalDetailsView(festivals: [
        Festival(
            name: "Diwali",
            description: "Festival of Lights",
            tithi: 15,
            month: 7,
            paksha: "Krishna",
            gregorianDate: Date(),
            significance: "Victory of light over darkness"
        )
    ])
}
