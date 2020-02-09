//
//  SelectViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/02.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import PKHUD
import VerticalCardSwiper


class SelectViewController: UIViewController,VerticalCardSwiperDelegate,VerticalCardSwiperDatasource {
   
    
    @IBOutlet weak var cardSwiperView: VerticalCardSwiper!
    
    
    var titleArrey = [String]()
    var videoIdArrey = [String]()
    var imageURLArrey = [String]()
    var youtubeURLArrey = [String]()
    var channelTitleArrey = [String]()
    var userName :String = ""
    var userID :String = ""
    
    var goodtitleArrey = [String]()
    var goodvideoIdArrey = [String]()
    var goodimageURLArrey = [String]()
    var goodyoutubeURLArrey = [String]()
    var goodchannelTitleArrey = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        cardSwiperView.datasource = self
        cardSwiperView.delegate = self
        
        cardSwiperView.reloadData()
        cardSwiperView.register(nib: UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        
        // Do any additional setup after loading the view.
    }
    

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
           
        return titleArrey.count
        
       }
       
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
           
        if let cardViewCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: index)as? CustomCell {
            
            cardViewCell.channelNameLabel.text = self.channelTitleArrey[index]
            cardViewCell.titleLabel.text = self.titleArrey[index]
        cardViewCell.channelImageView!.sd_setImage(with:URL(string:self.imageURLArrey[index] ) , completed: nil)
            
            
            return cardViewCell
            
        }
        
        return CustomCell()
        
       }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
//        if swipeDirection  == .Right{
//
//            goodtitleArrey.append(titleArrey[index])
//            goodvideoIdArrey.append(videoIdArrey[index])
//            goodimageURLArrey.append(imageURLArrey[index])
//            goodyoutubeURLArrey.append(youtubeURLArrey[index])
//            goodchannelTitleArrey.append(channelTitleArrey[index])
//
//            if goodtitleArrey.count != 0 && goodvideoIdArrey.count != 0 && goodimageURLArrey.count != 0 && goodyoutubeURLArrey.count != 0 && goodchannelTitleArrey.count != 0 {
//
//               let youtubeDataModel = YoutubeData(channelTitle: channelTitleArrey[index], title: titleArrey[index], videoId: videoIdArrey[index], imageURLString: imageURLArrey[index], youtubeURL: youtubeURLArrey[index], userName: userName, userID: userID)
//
//                youtubeDataModel.save()
//
//            }
//
//
//        }
        
    }

    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
     
        if swipeDirection  == .Right{
                  
                  goodtitleArrey.append(titleArrey[index])
                  goodvideoIdArrey.append(videoIdArrey[index])
                  goodimageURLArrey.append(imageURLArrey[index])
                  goodyoutubeURLArrey.append(youtubeURLArrey[index])
                  goodchannelTitleArrey.append(channelTitleArrey[index])
                  
                  if goodtitleArrey.count != 0 && goodvideoIdArrey.count != 0 && goodimageURLArrey.count != 0 && goodyoutubeURLArrey.count != 0 && goodchannelTitleArrey.count != 0 {
                      
                     let youtubeDataModel = YoutubeData(channelTitle: channelTitleArrey[index], title: titleArrey[index], videoId: videoIdArrey[index], imageURLString: imageURLArrey[index], youtubeURL: youtubeURLArrey[index], userName: userName, userID: userID)
                      
                      youtubeDataModel.save()
                      
                  }
                  
                  
              }
        titleArrey.remove(at: index)
        videoIdArrey.remove(at: index)
        imageURLArrey.remove(at: index)
        youtubeURLArrey.remove(at: index)
        channelTitleArrey.remove(at: index)
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        
        
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
