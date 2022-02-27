//
//  ContentView.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 24/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var information: String = ""
    @FocusState private var isFocused: Bool

    @FetchRequest(
        entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: "title", ascending: false)], animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    //.textFieldStyle(.roundedBorder)
                    .cornerRadius(15)
                    .focused($isFocused)
                TextEditor(text: $information)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    //.background(Color.gray.opacity(0.125))
                    .cornerRadius(15)
                
                Button(action: {
                    addItem()
                    clean()
                    isFocused = true
                }, label:  {
                    Text("Add")
                        .padding()
                        .font(.headline)
                        .frame(maxWidth: 200.0, maxHeight: 50.0)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                })
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            DetailView(title: item.title!, information: item.information!)
                        } label: {
                            HStack {
                                Text(item.title ?? "")
                                Spacer()
                                Image(systemName: item.isFavorite ? "heart.fill": "heart")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        updateItem(item)
                                    }
                            }
                        }
                    }.onDelete(perform: deleteItems)
                }
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15.0)
            
                Spacer()
            }
            .padding()
            .navigationTitle("All Topics")
        }
    }

// MARK: - Función de agregar
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = title
            newItem.information = information

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
// MARK: - Función de favorito
    
    private func updateItem(_ item: Item) {
        item.isFavorite = !item.isFavorite
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

// MARK: - Función de borrar
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
// MARK: - Función limpiar campos
    
    private func clean() {
        title = ""
        information = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = PersistenceController.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
