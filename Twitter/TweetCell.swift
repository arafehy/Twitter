//
//  TweetCell.swift
//  Twitter
//
//  Created by Yazan Arafeh on 3/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweetID: Int = -1
    var favorited: Bool = false
    var retweeted: Bool = false
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succed: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed : \(error)")
            })
        }
    }
    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    @IBAction func retweet(_ sender: UIButton) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Error retweeting: \(error)")
        })
    }
    
    func setRetweet(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
