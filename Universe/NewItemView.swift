//
//  NewItemView.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 28/02/22.
//

import SwiftUI

struct NewItemView: View {
    @Environment(\.managedObjectContext) var item
    @Environment(\.presentationMode) var dismiss
    
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
                    //.textFieldStyle(.roundedBorder)
                    .cornerRadius(15)
                    //.focused($isFocused)
                TextEditor(text: $information)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    //.background(Color.gray.opacity(0.125))
                    .cornerRadius(15)
                
                Button(action: {
                    let send = Item(context: self.item)
                    send.title = self.title
                    send.information = self.information
                    send.imageD = self.image
                    
                    // Guardar la info permanente
                    try! self.item.save()
                    
                    // Limpiar los campos después de realizar el clic
                    self.title = ""
                    self.information = ""
                    self.image.count = 0
                    
                    //self.dismiss.wrappedValue.dismiss()
                }, label: {
                    Text("Add")
                        .padding()
                        .font(.headline)
                        .frame(maxWidth: 200.0, maxHeight: 50.0)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                })
                /*Button(action: {
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
                })*/
            }
            .padding()
            .navigationBarItems(leading: Button(action: {
                self.dismiss.wrappedValue.dismiss()
            }, label:{
                Text("Cancel")
                    .bold()
                    .foregroundColor(.blue)
            }))
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
