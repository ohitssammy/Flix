//
//  MovieDetails2ViewController.swift
//  Flixster
//
//  Created by Sammy Truong on 1/26/20.
//  Copyright © 2020 Sammy Truong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetails2ViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var descripLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        descripLabel.text = movie["overview"] as? String
        descripLabel.sizeToFit()
        
        //image
        let baseUrl2 = "https://image.tmdb.org/t/p/w185"
        let posterPath2 = movie["poster_path"] as! String
        let posterUrl2 = URL(string: baseUrl2 + posterPath2)!
        posterImage.af_setImage(withURL: posterUrl2)
        
        let backdropPath2 = movie["backdrop_path"] as! String
        let backdropUrl2 = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath2)!
        backdropImage.af_setImage(withURL: backdropUrl2)
        
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
*/
    
}
