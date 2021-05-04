//
//  ViewController.swift
//  MovieDBCollectionView
//
//  Created by İstemihan Çelik on 3.05.2021.
//

import UIKit

class ViewController: UICollectionViewController {

    var movies = [Movie]()
    var currentPage = 1
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top Rated Movies"
        
        getData()
     
    }
   
    func parse(json: Data){
        let decoder = JSONDecoder()
        if let jsonMovies = try? decoder.decode(Movies.self, from: json){
            
            
            movies.append(contentsOf: jsonMovies.results)
            
            collectionView.reloadData()
            
        }
    }
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=58ea4fe48390e0d2e32f6d608a6e7b47&language=en-US&page=\(currentPage)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                currentPage += 1
            }
        }
        
    }

    // This is the function that increments page number and calls the API function
    func loadNewItemsFrom(currentPage: Int){
        self.currentPage += 1
        getData()
        
        collectionView.reloadData()
      
    }
   
   
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height {
//            /* increment page index to load new data set from */
//
//            /* call API to load data from next page or just add dummy data to your datasource */
//            /* Needs to be implemented */
//            loadNewItemsFrom(currentPage: currentPage)
//
//            /* reload tableview with new data */
//            collectionView.reloadData()
//        }
//    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            /* increment page index to load new data set from */
            
            /* call API to load data from next page or just add dummy data to your datasource */
            /* Needs to be implemented */
            loadNewItemsFrom(currentPage: currentPage)

            /* reload tableview with new data */
            collectionView.reloadData()
        }
    }
    
    
    

        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count

    }
   

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCell {
           // cell.posterImage.image = movie.poster_path
            cell.movieTitle.text = movie.title
            let defaultLink = "https://image.tmdb.org/t/p/w500/"
            let completeLink = defaultLink + movie.poster_path
            cell.posterImage.image = UIImage(named: completeLink)
            cell.layer.cornerRadius = 10
                  
            
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster_path) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    
                    DispatchQueue.main.async {
                        
                        cell.posterImage.image = UIImage(data: data)
                    }
                    
                }
                
                task.resume()
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
     

    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let movie = movies[indexPath.item]
            vc.detailTitle = movie.title
            vc.overviewInfo = movie.overview
            vc.selectedImage = movie.backdrop_path
          
            vc.vote = String(movie.vote_average)
            vc.releasedate = movie.release_date
            
            print(movie.backdrop_path)
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCell {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster_path) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    
                    DispatchQueue.main.async {
                        
                        cell.posterImage.image = UIImage(data: data)
                    }
                    
                }
                
                task.resume()
            }

            
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.backdrop_path) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in

                    guard let data = data, error == nil else { return }
                    
                    print(movie.backdrop_path)

                    DispatchQueue.main.async {
                        print(movie.backdrop_path)
                         let image = UIImage(data: data)
                        if image != nil {
                            vc.backdropImage?.image = UIImage(data: data)
                        } else {
                            vc.backdropImage?.image = UIImage(systemName: "person")
                        }
                
                        print(movie.backdrop_path)
                    }

                }
                task.resume()

            }
            }
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
