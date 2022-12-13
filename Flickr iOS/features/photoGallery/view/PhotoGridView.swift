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
    
    let columns = [
          GridItem(.flexible(),spacing: 1),
          GridItem(.flexible(),spacing: 1),
          GridItem(.flexible(),spacing: 1),
      ]
      var body: some View {
          ScrollView {
              LazyVGrid(columns: columns, spacing: 1) {
                  ForEach(photoList , id: \.self) { item in
                      ImageWithURL("https://farm\(item.farm).staticflickr.com/\(item.server)/\(item.id)_\(item.secret)_m.jpg").onAppear{
                          if(photoList.last  == item){
                              if((photoModel?.photos.pages ?? 0)>(photoModel?.photos.page ?? 0)){
                                  print("end")
                                  refresh = false
                                  viewModel.searchPhoto(searchWord: searchWord ,page: (photoModel?.photos.page ?? 0)+1)
                              }
                          }
                      }
                  }
              }
              .padding(.horizontal)
          }
          //.frame(maxHeight: 300)
      }
}

//struct PhotoGridView_Previews: PreviewProvider {
//    static var previews: some View {
//    PhotoGridView(photoModel: PhotoModel(from: ))
//    }
//}
