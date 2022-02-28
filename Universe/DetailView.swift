//
//  DetailView.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 26/02/22.
//

import SwiftUI

struct DetailView: View {
    var title: String
    var information: String
    var image: Data
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: UIImage(data: image)!)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width-32, height: 250)
                    .clipShape(Rectangle())
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                Spacer()
                
                Text(title)
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                    .lineSpacing(8.0)
                    .padding()
                
                Spacer()
                
                Text(information)
                    .padding()
                    .lineSpacing(8.0)
            }
            .padding()
        }
        //.navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
 struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
*/
