//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/18/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeHolderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        //check to yank from cache
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        //network call
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            //handling the error
            guard let self = self else {return}
            
            if error != nil {return} //not handling the error, this is why we have the placeholder
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            //if we have goo data, we get the image
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
        
    }
}
