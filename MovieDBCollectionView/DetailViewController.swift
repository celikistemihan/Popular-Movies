//
//  DetailViewController.swift
//  MovieDBCollectionView
//
//  Created by İstemihan Çelik on 3.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var overview: UITextView!
    @IBOutlet var release_date: UILabel!
    @IBOutlet var average_vote: UILabel!
    @IBOutlet var backdropImage: UIImageView!
    
    var detailTitle: String?
    var selectedImage: String!
    var overviewInfo: String?
    var detailImage: String?
    var vote: String?
    var releasedate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = detailTitle
        navigationItem.largeTitleDisplayMode = .never
        overview.text = overviewInfo
        release_date.text = releasedate
        average_vote.text = vote
      
        if let imageToLoad = selectedImage {
            backdropImage.image = UIImage(named: imageToLoad)
        }
    }
    

   

}
