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
                  PhotoGridView(viewModel: viewModel,photoModel: viewModel.photoModel,photoList: $photoList,searchWord: searchKey,refresh: $loadNext)
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
            
        }.onAppear{
            viewModel.searchPhoto()
        }.onChange(of: searchKey) { newValue in
            viewModel.searchPhoto(searchWord: searchKey )
            print(searchKey)
            refresh = false
            loadNext = false
        }.onChange(of: viewModel.photoModel) { newValue in
           // print(newValue)
            refresh = true
            loadNext = true
            photoList = viewModel.photoList
            print(viewModel.photoList.count)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
