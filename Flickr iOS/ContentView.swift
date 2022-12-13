//
//  ContentView.swift
//  Flickr iOS
//
//  Created by Towhid on 8/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PhotoSearchViewModel()
    @State  var searchKey = ""
    @State var refresh = true
    @State var loadNext = true
    @State var photoList : [Photo] = []
    @State var selectedPhoto : Photo?
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
               
                HStack(){
                    Image("search")
                        .resizable()
                        .frame(width: 40, height: 40)
                    TextField("",text: $searchKey)
                        .accentColor(Color("base")).placeholder(when: searchKey.isEmpty) {
                            Text("Search ").foregroundColor(.gray)
                        }
                        .padding(.vertical,5)
                }.padding(.all,5).background(Color("white_black")).cornerRadius(10)
                    .padding(.all , 0.7)
                    .background( Color("background")).cornerRadius(10).padding(.horizontal).zIndex(1).shadow(color: Color("background"), radius: 10 ).padding(.top,10)
              if viewModel.photoModel != nil && refresh  {
                  PhotoGridView(viewModel: viewModel,photoModel: viewModel.photoModel,photoList: $photoList,searchWord: searchKey,refresh: $loadNext, selectedPhoto: $selectedPhoto)
                }
                Spacer()
            }
            if !refresh || !loadNext {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    Spacer()
                }
               
            }
            if(selectedPhoto != nil){
                DetailsView(SelectedPhoto: selectedPhoto!)
            }
            
        }.onAppear{
            //initial api call
            viewModel.searchPhoto()
        }.onChange(of: searchKey) { newValue in
            //search value wise api call
            viewModel.searchPhoto(searchWord: searchKey )
            refresh = false
            loadNext = false
        }.onChange(of: viewModel.photoModel) { newValue in
            refresh = true
            loadNext = true
            photoList = viewModel.photoList
            
        }
        
    }
    
    //fullscreen Image View
    @ViewBuilder
    func DetailsView(SelectedPhoto : Photo)->some View {
        ZStack(alignment: .bottomLeading ){
            ImageWithURL("https://farm\(SelectedPhoto.farm).staticflickr.com/\(SelectedPhoto.server)/\(SelectedPhoto.id)_\(SelectedPhoto.secret)_z.jpg",isFullScreen: true)
            VStack(spacing: 0){
                Text(SelectedPhoto.title).font(.title3).foregroundColor(.white).padding(.bottom , 30).padding(.leading , 30).padding(.trailing , 30)
                HStack{
                    Spacer()
                    Button(action: {
                        selectedPhoto = nil
                    }){
                        Text("Close").foregroundColor(.red)
                    }
                }.padding(.trailing , 30)
            }.padding(.bottom , 40).padding(.top , 20).background(.black.opacity(0.3))
        }.background(.black)
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
