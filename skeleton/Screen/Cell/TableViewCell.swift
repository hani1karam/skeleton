//
//  TableViewCell.swift
//  skeleton
//
//  Created by hany karam on 10/22/21.
//

import UIKit
protocol PostTableViewCellDelegate {
    func postLabelAction(cell: TableViewCell, post: Post, tap: UITapGestureRecognizer)
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
     var currentPost : Post?
    var delegate: PostTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
         title.textColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(postLabelSelected))
        tapGesture.numberOfTapsRequired = 1
        title.isUserInteractionEnabled = true
        title.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func postLabelSelected(tap: UITapGestureRecognizer) {
        delegate?.postLabelAction(cell: self, post: currentPost!, tap: tap)
    }
    
    func applyAttributedStringToPost(attributedString: NSMutableAttributedString, item: Post) {
        let text = attributedString.string
        let urls = text.extractURLs
        for url in urls {
            let range1 = (text as NSString).range(of: url.absoluteString)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
            title.attributedText = attributedString
        }
        title.attributedText = attributedString
    }
    
    func setupItems(item : Post){
        currentPost = item
        let postText = item.postText
        title.numberOfLines = item.isExpendable ? 0 : 6
        title.text = postText
        let underlineAttriString = NSMutableAttributedString(string: postText)
        let urls = postText.extractURLs
        for url in urls {
            let range1 = (postText as NSString).range(of: url.absoluteString)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
            title.attributedText = underlineAttriString
        }
        //Apply See more see less
        title.sizeToFit()
        //        let screenSize = UIScreen.main.bounds/
        if let newfont = title.font {
            let textHeight = postText.textHeight(withConstrainedWidth: title.frame.size.height, font: newfont)
            if item.isExpendable {
                title.addTrailingForShowLess(with: "", moreText: "Show Less", moreTextFont: newfont, moreTextColor: UIColor.blue) { (attributedString) in
                    self.applyAttributedStringToPost(attributedString: attributedString, item: item)
                }
            } else if title.frame.size.height < textHeight, !item.isExpendable {
                title.addTrailing(with: "...", moreText: "Show More", moreTextFont: newfont, moreTextColor: UIColor.blue) { (attributedString) in
                    self.applyAttributedStringToPost(attributedString: attributedString, item: item)
                }
            }
        }
    }
    
}
 
