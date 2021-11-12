//
//  AddEntityView.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//
import CoreData
import SwiftUI
import CoreLocation

struct AddEntityView: View {
    
    @Binding var binding: Bool
    
    @State var centerCoordinate: CLLocation = LocationManager.shared.currentLocation ?? CLLocation(latitude: 0, longitude: 0)
    
    @EnvironmentObject var homeViewModel: HomeView.ViewModel
    
    @StateObject var viewModel: ViewModel
    
    @FocusState private var focusField: Field?
    
    @State var containerHeight: CGFloat = 100
    
    enum Field {
        case title
        case caption
    }
    
    init(viewModel: ViewModel, binding: Binding<Bool>){
        _viewModel = StateObject(wrappedValue: viewModel)
        _binding = binding
    }
    
    var body: some View {
        ScrollView(.vertical){
            
            VStack(alignment: .leading) {
                
                HStack {
                    Button {
                        binding = false
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding(.vertical, 15)
                    Spacer()
                    
                    Button {
                        viewModel.addEntity()
                        homeViewModel.fetchEntities()
                        binding = false
                    } label: {
                        Text("Create Post")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(Color.blue)
                    }
                    .cornerRadius(5)
                    .disabled(viewModel.selectedImage == nil || viewModel.titleTextField == "" || viewModel.captionTextField == "")
                    .opacity(viewModel.selectedImage == nil || viewModel.titleTextField == "" || viewModel.captionTextField == "" ? 0.6 : 1)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                
                Button {
                    viewModel.showConfirmationSheet = true
                } label: {
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .cornerRadius(0)
                    }else{
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.onboarding.textfield)
                            
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(Color.init(red: 44/255, green: 108/255, blue: 100/255))
                                Image(systemName: "photo")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .clipped()
                                
                            }// - ZStack
                            .frame(height: 200)
                            .clipShape(Circle())
                            
                        }// - ZStack
                    }
                    
                }// - Button
                .frame(height: 250)
                .confirmationDialog("Which would you like to use?", isPresented: $viewModel.showConfirmationSheet, titleVisibility: .visible) {
                    Button {
                        viewModel.sourceType = .camera
                        viewModel.showShareSheet = true
                    } label: {
                        Text("Camera")
                    }
                    
                    Button {
                        viewModel.sourceType = .photoLibrary
                        viewModel.showShareSheet = true
                    } label: {
                        Text("Photo Library")
                    }
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(5)
                .clipped()
                
                
                VStack(spacing: 5) {
                    
                    TextField("Name your plant here...", text: $viewModel.titleTextField)
                        .focused($focusField, equals: .title)
                        .submitLabel(.continue)
                        .tint(Color.theme.accent)
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.vertical, 15)
                        .foregroundColor(Color.theme.accent)
                        .accentColor(Color.theme.accent)
                    
                    AutoSizeTextField(text: $viewModel.captionTextField, hint: "What do you want to say about your find? Tap to write...", containerHeight: $containerHeight) {
                    }
                    .accentColor(Color.theme.accent)
                    .frame(height: containerHeight <= 200 ? containerHeight : 200)
                    .focused($focusField, equals: .caption)
                    .submitLabel(.continue)
                    .tint(Color.theme.accent)
                    .lineSpacing(8)
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 20)
                    
                }// - VStack
                .onSubmit {
                    switch focusField {
                    case .title:
                        focusField = .caption
                    default:
                        return
                    }
                }
                .padding(.horizontal, 15)
                
                VStack(spacing: 15) {
                    
                    HStack(spacing: 0) {
                        Text("Use current location?")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.showMap ? "No" : "Yes")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                        
                        Toggle(isOn: $viewModel.showMap) {
                            Text("")
                        }
                        .frame(width: 60)
                    }
                    .padding(.trailing, 10)
                    
                    
                    if viewModel.showMap {
                        
                        ZStack {
                            
                            MapView(centerCoordinate: $centerCoordinate)
                                .frame(height: 250)
                                .cornerRadius(10)
                            
                            
                            Circle()
                                .foregroundColor(.blue)
                                .frame(width: 35, height: 35, alignment: .center)
                                .opacity(0.5)
                        }
                    }
                    
                }//MARK: VStack
                .padding(.horizontal, 20)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
        .sheet(isPresented: $viewModel.showShareSheet) {
            ImagePicker(sourceType: viewModel.sourceType, selectedImage: $viewModel.selectedImage, active: $viewModel.showShareSheet)
        }
        
    }
}

struct AddEntityView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntityView(viewModel: AddEntityView.ViewModel(viewContext: CoreDataManager.shared.viewContext), binding: .constant(true))
            .environmentObject(HomeView.ViewModel(context: CoreDataManager.shared.viewContext))
    }
}
