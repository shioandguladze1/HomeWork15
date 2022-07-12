//
//  MovieListController.swift
//  HM15 (shio andghuladze)
//
//  Created by IMAC on 12.07.22.
//

import UIKit
import SwiftUI

class MovieListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var data = (0...15).map { i in
        Movie(title: "movie\(i)", releaseDate: "200\(i)", imdb: Double(Int.random(in: 0...10)), mainActor: "actor \(i)", seen: Bool.random(), isFavourite: Bool.random())
    }
    
    private var seenMovies: Array<Movie>?
    private var notSeenMovies: Array<Movie>?

    override func viewDidLoad() {
        super.viewDidLoad()
        seenMovies = data.filter{ $0.seen }
        notSeenMovies = data.filter{ !$0.seen }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.register(UINib(nibName: "SeenMovieCell", bundle: nil), forCellReuseIdentifier: "SeenMovieCell")
    }
    

}

extension MovieListController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return notSeenMovies?.count ?? 0
        }else{
            return seenMovies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell
        if indexPath.section == 0{
            cell?.setUp(movie: notSeenMovies?[indexPath.row])
            cell?.onActionClick = {
                if var movie = self.notSeenMovies?.remove(at: indexPath.row){
                    movie.seen = true
                    self.seenMovies?.append(movie)
                }
                self.tableView.reloadData()
            }
        }else{
            cell?.setUp(movie: seenMovies?[indexPath.row])
            cell?.onActionClick = {
                if var movie = self.seenMovies?.remove(at: indexPath.row){
                    movie.seen = false
                    self.notSeenMovies?.append(movie)
                }
                self.tableView.reloadData()
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie: Movie?
        if indexPath.section == 0 {
            movie = notSeenMovies?[indexPath.row]
        }else{
            movie = seenMovies?[indexPath.row]
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsController") as? MovieDetailsController{
            controller.movie = movie
            controller.onMovieChange = {m in
                if indexPath.section == 0 {
                    self.notSeenMovies?[indexPath.row] = m
                }else {
                    self.seenMovies?[indexPath.row] = m
                }
            }
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.backgroundColor = .blue
        if section == 0{
            view.text = "Seen"
        }else{
            view.text = "Not Seen"
        }
        return view
    }
    
    
}
