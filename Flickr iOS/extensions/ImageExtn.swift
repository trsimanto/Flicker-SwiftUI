//
//  SwiftUIView.swift
//  Flickr iOS
//
//  Created by REEA on 12/12/22.
//

import SwiftUI
import UIKit
import SwiftUI

struct ImageWithURL: View {
    
    @ObservedObject var imageLoader: ImageLoaderAndCache
    @State var isFullScreen : Bool
    
    init(_ url: String , isFullScreen:Bool = false ) {
        self.imageLoader = ImageLoaderAndCache(imageURL: url)
        self.isFullScreen = isFullScreen
    }
    
    var body: some View {
        if(self.isFullScreen){
            Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width:  UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        }else{
            Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
                .resizable()
                .frame(width: (UIScreen.main.bounds.width / 3) - 11 , height: (UIScreen.main.bounds.width / 3) - 11  )
            
        }
        
    }
    
}

class ImageLoaderAndCache: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data {
            //      print("got image from cache")
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        //    print("downloaded from internet")
                        self.imageData = data
                    }
                }
            }).resume()
        }
    }
}
