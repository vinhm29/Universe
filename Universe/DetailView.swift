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
    
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                    .lineSpacing(8.0)
                
                Spacer()
                
                Text(information)
                    .lineSpacing(8.0)
            }
            .padding()
        }
        .navigationTitle(title)
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
