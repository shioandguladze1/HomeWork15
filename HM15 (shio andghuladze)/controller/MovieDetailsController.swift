//
//  MovieDetailsController.swift
//  HM15 (shio andghuladze)
//
//  Created by IMAC on 12.07.22.
//

import UIKit

class MovieDetailsController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ImdbLabel: UILabel!
    @IBOutlet weak var mainActorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    var onMovieChange: ((Movie)-> Void)?
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        ImdbLabel.text = String(movie?.imdb ?? 0)
        mainActorLabel.text = movie?.mainActor
        descriptionTextView.text = movie?.description
        configureButtonText()

    }
    
    private func configureButtonText(){
        if movie?.isFavourite ?? false {
            actionButton.setTitle("Remove from favorites", for: .normal)
        }else{
            actionButton.setTitle("Save to favorites", for: .normal)
        }
    }
    
    // ძალიან ცუდად გამოვიდა ამის ლოგიკა იმის გამო რომ Movie სტრაქტია, მაგრამ კლასზე არ შევცვალე
    @IBAction func onActionButtonClick(_ sender: Any) {
        if var movie = movie {
            let isFavorite = movie.isFavourite
            movie.isFavourite = !isFavorite
            self.movie = movie
            configureButtonText()
            onMovieChange?(movie)
        }
    }
    
}
