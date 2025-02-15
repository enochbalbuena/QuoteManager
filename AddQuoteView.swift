//
//  ContentView 2.swift
//  QuoteManager
//
//  Created by Enoch Balbuena Covarrubias on 14/02/25.
//


import SwiftUI

struct AddQuoteView: View {
    @Binding var quotes: [Quote]
    @State private var text: String = ""
    @State private var author: String = ""
    @State private var year: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Enter quote", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Enter author", text: $author)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Enter year", text: $year)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                let newQuote = Quote(id: UUID(), text: text, author: author, year: year)
                quotes.append(newQuote)
                saveQuotes() // Save the updated list
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Quote")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Add Quote")
    }

    /// Encodes the current list of quotes into JSON format and stores it in UserDefaults.
    /// This ensures that the quotes persist even after the app is closed.
    /// - Note: If encoding fails, the function does nothing.
    func saveQuotes() {
        if let encodedData = try? JSONEncoder().encode(quotes) {
            UserDefaults.standard.set(encodedData, forKey: "savedQuotes")
        }
    }
}

#Preview {
    AddQuoteView(quotes: .constant([]))
}
