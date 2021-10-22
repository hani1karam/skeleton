//
//  ViewController.swift
//  skeleton
//
//  Created by hany karam on 10/22/21.
//

import UIKit
import SkeletonView
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,SkeletonTableViewDataSource {
    @IBOutlet var tableView:UITableView!{
        didSet{
            settingUpTableView()
        }
    }
    var postArray : [Post] = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // fillUpPostData()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline:.now() + 5 , execute:{
            self.postArray.append(Post(postText: "Next, we established questions. We used❓liberally to indicate questions, and 🤔 to indicate \"I’m not understanding.\" I’d say questions composed about 30–40% of our communication, so this was a critical emoji discovery.\nThen, we added more interesting complex relationships. 🔜 implied that, after time, one thing would lead to another. 🤓🔜🗣️ means that \"I’ll be able to talk soon.\" We created a scale for asking “How do you feel?\": 😄😀🙂😕☹️😴❓\nAs our communication advanced, we adopted each others’ language. My friend used 🔺 to indicate \"and.", isExpendable: false))
            self.postArray.append(Post(postText: "Next, we established questions. We used❓liberally to indicate questions, and 🤔 to indicate \"I’m not understanding.\" I’d say questions composed about 30–40% of our communication, so this was a critical emoji discovery.\nThen, we added more interesting complex relationships. 🔜 implied that, after time, one thing would lead to another. 🤓🔜🗣️ means that \"I’ll be able to talk soon.\" We created a scale for asking “How do you feel?\": 😄😀🙂😕☹️😴❓\nAs our communication advanced, we adopted each others’ language. My friend used 🔺 to indicate \"and.", isExpendable: false))
            self.postArray.append(Post(postText: "Next, we established questions. We used❓liberally to indicate questions, and 🤔 to indicate \"I’m not understanding.\" I’d say questions composed about 30–40% of our communication, so this was a critical emoji discovery.\nThen, we added more interesting complex relationships. 🔜 implied that, after time, one thing would lead to another. 🤓🔜🗣️ means that \"I’ll be able to talk soon.\" We created a scale for asking “How do you feel?\": 😄😀🙂😕☹️😴❓\nAs our communication advanced, we adopted each others’ language. My friend used 🔺 to indicate \"and.", isExpendable: false))
            
            self.tableView.reloadData()
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        })
    }
    
    func settingUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .singleLine
        //     tableView.separatorInset = .zero
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.25))
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "TableViewCell"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if !postArray.isEmpty{
            cell.setupItems(item: postArray[indexPath.row])
            cell.delegate = self
            //     cell.img.image = UIImage(named: "swift-og")
        }
        return cell
    }
    
}



