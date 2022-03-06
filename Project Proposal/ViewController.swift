//
//  ViewController.swift
//  Project Proposal
//
//  Created by Joshua Hurtado on 2/15/22.
//

import UIKit

//global variables
public var title_count:String = ""

class ViewController: UIViewController {
    

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var resultsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsText.text = title_count
    
    }
    
    
    @IBAction func searchMovie(_ sender: UIButton) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=5b2d34db93d41b20c85b7a4695dc5848&query=Jack+Reacher"
        getData(from: url)
        resultsText.text = title_count
    }
    
    
    private func getData(from url : String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                print("Error")
                return
            }
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(APIResults.self,from:data)
                print(result.movies)
                title_count = result.movies.description
                
            }
            catch {
                //print(String(describing: error))
        
            }
            
          
        })
        task.resume()
        
        
    
                                                
    }

}





struct Movie: Codable {
    let id: Int
    let posterPath: String
    var videoPath: String?
    let backdrop: String
    let title: String
    var releaseDate: String
    var rating: Double
    let overview: String
    
    private enum CodingKeys: String, CodingKey {
        case id,
             posterPath = "poster_path",
             videoPath,
             backdrop = "backdrop_path",
             title,
             releaseDate = "release_date",
             rating = "vote_average",
             overview
    }
    
    
    
}

struct APIResults: Codable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}


/*
 let url = "https://api.themoviedb.org/3/search/movie?api_key=5b2d34db93d41b20c85b7a4695dc5848&query=Jack+Reacher"
 getData(from: url)
 */
