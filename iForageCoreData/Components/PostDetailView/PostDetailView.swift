//
//  PostDetailView.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import SwiftUI
import CoreData

extension PostDetailView {
    class ViewModel: ObservableObject {
        
        private var viewContext: NSManagedObjectContext
        
        var forageEntity: ForageEntityViewModel
        
        init(forageEntity: ForageEntityViewModel, viewContext: NSManagedObjectContext){
            self.forageEntity = forageEntity
            self.viewContext = viewContext
        }
    }
}

struct PostDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .bottomLeading) {
                    
                    StretchingHeader(height: 250) {
                        
                        Image(uiImage: viewModel.forageEntity.image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .clipped()
                    }
                    
                    .overlay(
                        
                        LinearGradient(colors: [.clear, .clear, .black.opacity(0.15), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                            .clipped()
                        
                        ,alignment: .bottom
                        
                    )// - Overlay
                    
                    
                    Text(viewModel.forageEntity.title)
                        .kerning(1)
                        .font(.system(size: 32, weight: .bold))
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .foregroundColor(.white)
                }
                
                VStack {
                    
                    Text(viewModel.forageEntity.caption)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(.system(size: 18, weight: .light))
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                    
                }
                .padding(15)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(
            HStack {
                Button {
                    dismiss()
                } label: {
                        Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                        .aspectRatio(1, contentMode: .fit)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    .padding(13)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
                }
                
                Spacer()
                
                Menu {
                    //
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .aspectRatio(1, contentMode: .fit)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                .padding(12)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
            ,alignment: .topLeading
        )
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(viewModel: PostDetailView.ViewModel(forageEntity: ForageEntityViewModel(entity: ForageEntity(context: CoreDataManager.shared.viewContext)), viewContext: CoreDataManager.shared.viewContext))
    }
}
