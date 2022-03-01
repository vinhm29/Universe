//
//  NewItemView.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 28/02/22.
//

import SwiftUI

struct NewItemView: View {
    @Environment(\.managedObjectContext) var item
    @Environment(\.presentationMode) var mode
    
    @State private var title: String = ""
    @State private var information: String = ""
    @State private var image: Data = .init(count: 0)
    @State private var show: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                if image.count != 0 {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Image(uiImage: UIImage(data: image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Rectangle())
                    })
                } else {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .clipShape(Rectangle())
                    })
                }
                
                TextField("Title", text: $title)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                TextEditor(text: $information)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                
                Button(action: {
                    let send = Item(context: self.item)
                    send.title = self.title
                    send.information = self.information
                    send.imageD = self.image
                    
                    // Guardar la info permanente
                    try! self.item.save()
                    
                    self.mode.wrappedValue.dismiss()
                    
                    // Limpiar los campos después de realizar el clic
                    self.title = ""
                    self.information = ""
                    self.image.count = 0
                }, label: {
                    Text("Add")
                        .padding()
                }).font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 200.0, maxHeight: 50.0)
                    .disabled(self.title.count > 4 && self.information.count > 8 && self.image.count != 0 ? false : true)
                    .background(self.title.count > 4 && self.information.count > 8 && self.image.count != 0 ? Color.blue : Color.gray)
                    .cornerRadius(15.0)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("Cancel")
                        }
                    })
                }
            }
        }
        .sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image)
        })
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
    }
}
