//
//  PhotoSearchController.swift
//  Flickr iOS
//
//  Created by MacBook Pro on 11/12/22.
//

import Foundation


class PhotoSearchViewModel : ObservableObject{
    @Published var photoModel : PhotoModel? = nil
    @Published var photoList : [Photo] = []
    func searchPhoto(searchWord : String = "", page : Int = 1){
        //trim
        var word : String = searchWord.trimmingCharacters(in: .whitespacesAndNewlines)
        //space replece
        word = word.replacingOccurrences(of: " ", with: "%20")
        //check if searchWord is empty or not then create the url
        guard let url = URL (string: word.isEmpty ?  "https://www.flickr.com/services/rest/?api_key=59cd6086d178dd3fd0c775bce4371176&format=json&page=\(page)&method=flickr.photos.getrecent" : "https://www.flickr.com/services/rest/?api_key=59cd6086d178dd3fd0c775bce4371176&text=\(word)&format=json&page=\(page)&method=flickr.photos.search") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            // convert Data to Model
            do{
                var dataString : String = String(data: data, encoding: String.Encoding.utf8) ?? ""
                dataString = dataString.substring(from: 14)
                dataString = dataString.substring(too: dataString.count-1)
                let model : PhotoModel = try JSONDecoder().decode(PhotoModel.self, from: Data(dataString.utf8))
                //print(model)
                DispatchQueue.main.async {
                    if(page == 1){
                        self.photoModel =  model
                        self.photoList = model.photos.photo
                    }
                    else{
                        self.photoList +=  model.photos.photo
                        self.photoModel =  model
                    }
                   
                }
            }
            catch {
                print("failed")
            }
        }
        task.resume()
    }
}
