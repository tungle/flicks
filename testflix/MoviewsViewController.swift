//
//  MoviewsViewController.swift
//  testflix
//
//  Created by Tung Le on 16/10/2016.
//  Copyright © 2016 Tung Le. All rights reserved.
//

import UIKit
import AFNetworking

class MoviewsViewController: UIViewController, UISearchBarDelegate,  UITableViewDelegate, UITableViewDataSource {
  
   

    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesData: [NSDictionary] = []
    let posterPrefix = "https://image.tmdb.org/t/p/w342"
    let top_rated_url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let now_playing_url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle search bar
        let searchbar  = UISearchBar()
        searchbar.placeholder = "Enter movies name"
        searchbar.showsCancelButton = true
//        searchbar.showsSearchResultsButton = true
        searchbar.delegate  = self
        self.navigationItem.titleView = searchbar
        
        //handle data for table
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 320
        
        // Do any additional setup after loading the view.
        requestMovies(now_playing_url!)
    }
    
    func requestMovies (_ url: URL) {
        
        let request = URLRequest(
            url: url,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main)
        let task = session.dataTask(
            with: request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print("response: \(responseDictionary)")
                        
                        if let photoData = responseDictionary["results"] as? [NSDictionary] {
                            self.moviesData = photoData
                            
                            self.tableView.reloadData()
                        }
                    }
                }
        })
        task.resume()

        
    
    }
    
        
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testflixPrototypeCell", for: indexPath as IndexPath) as! MoviesTableViewCell
        
        
        let posterUrl =  moviesData[indexPath.row].value(forKeyPath: "poster_path") as? String
        if posterUrl != nil {
            let url = posterPrefix + posterUrl!
            
            //print ("url => \(url)")
            
            cell.posterView.setImageWith(URL(string:url)!)

        
        }
        
        
        cell.titleLabel.text = moviesData[indexPath.row].value(forKeyPath: "title") as? String
        cell.contentLabel.text = moviesData[indexPath.row].value(forKeyPath: "overview") as? String
        
        //cell.photoView.setImageWith(<#T##url: URL##URL#>)
        return cell

    }
        
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        //http://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=shawshank
        
        if searchText != nil && !searchText.isEmpty {
            let search_url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=\(searchText)")
            
            requestMovies(search_url!)
        }else {
            requestMovies(now_playing_url!)
        }
        
        
        
        

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DetailsViewController
        
        var indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        
        
        let posterUrl =  moviesData[(indexPath?.row)!].value(forKeyPath: "poster_path") as? String
        if posterUrl != nil {
            let url = posterPrefix + posterUrl!
            
            //print ("url => \(url)")
            
            vc.photoUrl = url
            
        }
        
        
        vc.titleText = (moviesData[(indexPath?.row)!].value(forKeyPath: "title") as? String)!
        vc.contentText = (moviesData[(indexPath?.row)!].value(forKeyPath: "overview") as? String)!

        
    }

        
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
