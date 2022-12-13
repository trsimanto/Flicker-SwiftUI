//
//  PhotoGridView.swift
//  Flickr iOS
//
//  Created by REEA on 12/12/22.
//

import SwiftUI

struct PhotoGridView: View {
    @State var viewModel = PhotoSearchViewModel()
    @State var photoModel : PhotoModel?
    @Binding var photoList : [Photo]
    @State var searchWord = ""
    @Binding var refresh: Bool
    @Binding var selectedPhoto : Photo?
    
    let columns = [
        GridItem(.flexible(),spacing: 1),
        GridItem(.flexible(),spacing: 1),
        GridItem(.flexible(),spacing: 1),
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(photoList , id: \.self) { item in
                    Button(action : {
                        //pass the photo to open in fullscreen
                        selectedPhoto = item
                    }){
                        ImageWithURL("https://farm\(item.farm).staticflickr.com/\(item.server)/\(item.id)_\(item.secret)_m.jpg").onAppear{
                            //check last item
                            if(photoList.last  == item){
                                if((photoModel?.photos.pages ?? 0)>(photoModel?.photos.page ?? 0)){
                                    // loading start
                                    refresh = false
                                    // next page call
                                    viewModel.searchPhoto(searchWord: searchWord ,page: (photoModel?.photos.page ?? 0)+1)
                                }
                            }
                        }
                    }
                    
                }
            }
            .padding(.horizontal)
        }
    }
}
