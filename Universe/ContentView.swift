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
    @State private var image: Data = .init(count: 0)
    @State private var show: Bool = false

    @FetchRequest(entity: Item.entity(), sortDescriptors: [
            NSSortDescriptor(key: "title", ascending: true),
            NSSortDescriptor(key: "information", ascending: false),
            NSSortDescriptor(key: "isFavorite", ascending: false),
            NSSortDescriptor(key: "imageD", ascending: false)], animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink {
                            DetailView(title: item.title!, information: item.information!, image: item.imageD!)
                        } label: {
                            HStack {
                                Image(uiImage: UIImage(data: item.imageD ?? self.image)!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                Text(item.title ?? "")
                                    .bold()
                                    .font(.headline)
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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Create new")
                        }
                    })
                }
            }
        }
        .sheet(isPresented: self.$show, content: {
            NewItemView().environment(\.managedObjectContext, self.viewContext)
        })
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = PersistenceController.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
