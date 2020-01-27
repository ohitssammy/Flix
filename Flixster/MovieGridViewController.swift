//
//  MovieGridViewController.swift
//  Flixster
//
//  Created by Sammy Truong on 1/26/20.
//  Copyright © 2020 Sammy Truong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //so it fits for any phone size
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        //if we wanted
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        //wanted the height to be taller than width
        layout.itemSize = CGSize(width: width, height: width*3/2)
        

        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            //dataDictionary contains all jsn of movies
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of dictionary of movies (cast it as array of dict)
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
              // TODO: Store the movies in a property to use elsewhere
            
           // print(self.movies) (dictionary of all movies and their info)
              // TODO: Reload your table view data
            self.collectionView.reloadData()
          
           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        
        //for images
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        print(baseUrl + posterPath)
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        
        //passing info to another view controller
        let details2ViewController = segue.destination as! MovieDetails2ViewController
        
        details2ViewController.movie = movie
    }
    

}
