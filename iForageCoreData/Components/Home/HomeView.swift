//
//  HomeView.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject var viewModel: ViewModel
    @StateObject var locationManager = LocationManager()
    
    init(viewModel: ViewModel){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.forageEntities) { forageEntity in
                MapAnnotation(coordinate: forageEntity.coordinate) {
                    NavigationLink {
                        LazyView(                        PostDetailView(viewModel: PostDetailView.ViewModel(forageEntity: forageEntity, viewContext: viewContext)))
                    } label: {
                        MapAnnotationView(forageEntity: forageEntity)
                    }
                    .buttonStyle(FlatLinkStyle())
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.white)
        }
        .onAppear(perform: viewModel.fetchEntities)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(
            
            Button(action: {
                viewModel.showAddEntityView.toggle()
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(20)
                    .background(Color.blue)
                    .font(.system(size: 18, weight: .semibold))
                    .clipShape(Circle())
            })
                .padding()
            
            ,alignment: .bottomTrailing
        )
        .overlay(
            ZStack {
                if viewModel.showAddEntityView {
                    AddEntityView(viewModel: AddEntityView.ViewModel(viewContext: viewContext), binding: $viewModel.showAddEntityView)
                        .environmentObject(viewModel)
                        .animation(.easeInOut, value: viewModel.showAddEntityView)
                        .transition(.move(edge: .bottom))
                }
            }
                .animation(.easeInOut, value: viewModel.showAddEntityView)
                .transition(.move(edge: .bottom))
        )
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeView.ViewModel(context: CoreDataManager.shared.viewContext))
    }
}
