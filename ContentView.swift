//
//  ContentView.swift
//  QuoteManager
//
//  Created by Enoch Balbuena Covarrubias on 14/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var quotes: [Quote] = []

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(quotes) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.text)
                                .font(.headline)
                            Text("- \(quote.author), \(quote.year)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()

                NavigationLink(destination: AddQuoteView(quotes: $quotes)) {
                    Text("Add New Quote")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationTitle("My Quotes")
            .onAppear(perform: loadQuotes) // Load saved quotes when the app opens
        }
    }

    /// Saves the current list of quotes to UserDefaults as JSON data.
    /// This ensures quotes persist even after the app is closed.
    func saveQuotes() {
        if let encodedData = try? JSONEncoder().encode(quotes) {
            UserDefaults.standard.set(encodedData, forKey: "savedQuotes")
        }
    }

    /// Loads the saved list of quotes from UserDefaults.
    /// If no saved data exists, the quotes list remains empty.
    func loadQuotes() {
        if let savedData = UserDefaults.standard.data(forKey: "savedQuotes"),
           let decodedQuotes = try? JSONDecoder().decode([Quote].self, from: savedData) {
            quotes = decodedQuotes
        }
    }
}

struct Quote: Identifiable, Codable {
    let id: UUID
    var text: String
    var author: String
    var year: String
}

#Preview {
    ContentView()
}
