//
//  extenstion + Delegate.swift
//  skeleton
//
//  Created by hany karam on 10/22/21.
//

import UIKit

extension ViewController: PostTableViewCellDelegate{
    func postLabelAction(cell: TableViewCell,post: Post, tap: UITapGestureRecognizer) {
        let tapLocation = tap.location(in: cell.title)
        let tapIndex = cell.title.indexOfAttributedTextCharacterAtPoint(point: tapLocation, font: cell.title.font!)
        var _: [NSRange] = [NSRange]()
        var linkRangeArray: [NSRange] = [NSRange]()
        let postText = cell.title.text
        var seemoreText = ""
        seemoreText = post.isExpendable ? "Show Less" : "Show More"
        //
        if let seeRange = postText?.range(of: seemoreText)?.nsRange {
            if tapIndex > seeRange.location && tapIndex < seeRange.location + seeRange.length {
                if let indexPath = tableView.indexPath(for: cell) {
                    let isExpanded = self.postArray[indexPath.row].isExpendable
                    self.postArray[indexPath.row].isExpendable = !isExpanded
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                        self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    return
                }
            }
        }
        if let urls = postText?.extractURLs {
            for url in urls {
                guard let range = postText?.range(of: url.absoluteString)?.nsRange else { return }
                linkRangeArray.append(range)
            }
            
            for (_, neRange) in linkRangeArray.enumerated() {
                if tapIndex > neRange.location && tapIndex < neRange.location + neRange.length {
                    print("link print")
                    return
                }
            }
        }
        // mention logic will be there
        
        
    }
}
