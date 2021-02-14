//
//  ViewController.swift
//  Space Photo
//
//  Created by Jonathan Burnett on 13/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    let todayQuery: [String: String] = [
        "api_key": "DEMO_KEY",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        photoInfoController.fetchPhotoInfo(matching: todayQuery) { (photoInfo) in

            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }

    func updateUI(with photoInfo: PhotoInfo) {
        
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                
                self.title = photoInfo.title
                
                self.imageView.image = image
                
                self.descriptionLabel.text = photoInfo.description

                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
            
        }
        
        task.resume()
    }

}
