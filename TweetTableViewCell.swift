//
//  TweetTableViewCell.swift
//  TweeterTags
//
//  Created by тигренок  on 11/24/15.
//  Copyright (c) 2015 Midori.s. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    @IBOutlet weak var tweetNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
    func updateUI() {
        // rest any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetNameLabel?.text = nil
        tweetImageView?.image = nil
        //tweetCreatedLabel?.text = nil
        
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet{
            
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            
            
            tweetNameLabel?.text = "\(tweet.user)" 
            
            if let profileImageURL = tweet.user.profileImageURL {
                let qos = Int(QOS_CLASS_USER_INITIATED.value)
                let queue = dispatch_get_global_queue(qos, 0)
                
                dispatch_async(queue) {
                    
                    if let imageData = NSData(contentsOfURL: profileImageURL) {
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tweetImageView?.image = UIImage(data: imageData)

                        }
                    }
                }
            }
        }
    }
}




