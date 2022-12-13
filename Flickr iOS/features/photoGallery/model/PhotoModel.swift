//
//  PhotoModel.swift
//  Flickr iOS
//
//  Created by Towhid on 11/12/22.
//

import Foundation


// MARK: - Welcome
struct PhotoModel : Codable ,Hashable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos : Codable ,Hashable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo : Codable ,Hashable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
