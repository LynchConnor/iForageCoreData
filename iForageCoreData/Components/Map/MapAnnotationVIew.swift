//
//  MapAnnotationVIew.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import SwiftUI

struct MapAnnotationView: View {
    
    let forageEntity: ForageEntityViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: forageEntity.image)
                .resizable()
                .frame(width: 45, height: 45)
                .scaledToFill()
                .clipShape(Circle())
                .padding(0)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2.5)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
                )
            
            Text(forageEntity.title.suffix(40))
                .font(.system(size: 13, weight: .semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
        }
    }
}

struct MapAnnotationVIew_Previews: PreviewProvider {
    
    static var previews: some View {
        MapAnnotationView(forageEntity: ForageEntityViewModel(entity: ForageEntity(context: CoreDataManager.shared.viewContext)))
    }
}
