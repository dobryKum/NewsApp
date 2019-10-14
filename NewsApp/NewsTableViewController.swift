//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Tsimafei Zykau on 10/2/19.
//  Copyright © 2019 Timofey Zykov. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var articleItems = [NewsSource.Article]()
    var articlesCount = 0
    
    var defaultQuery: [String: String] = [
        "apiKey": "\(apiKey)",
        "language": "en",
        "pageSize": "5",
        "page": "1",
        "sortBy": "publishedAt"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsController.shared.fetchArticles(matching: defaultQuery, completion: { (newsSource) in
            if let newsSource = newsSource {
                self.articlesCount = Int(newsSource.totalResults!)
                print(self.articlesCount)
                self.updateUI(with: newsSource)
            }
        })
        
    }
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        self.defaultQuery["page"] = "1"
        NewsController.shared.fetchArticles(matching: defaultQuery, completion: { (newsSource) in
            if let newsSource = newsSource {
                DispatchQueue.main.async {
                    self.articleItems = newsSource.articles
                    print(self.articleItems)
                    self.tableView.reloadData()
                }
            }
        })
        
        sender.endRefreshing()
    }
    
    func updateUI(with newsSource: NewsSource) {
        DispatchQueue.main.async {
            self.articleItems += newsSource.articles
            print(self.articleItems)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func configure(_ cell: ArticleTableViewCell, forItemAt indexPath: IndexPath) {
        let article = articleItems[indexPath.row]
        cell.dateLabelOutlet.text = article.publishedAt ?? "Date"
        cell.titleLabelOutlet.text = article.title ?? "Title"
        cell.descriptionLabelOutlet.text = article.description ?? "Description"
        guard let imageUrlStr = article.urlToImage,
            let imageUrl = URL(string: imageUrlStr) else { return }
        NewsController.shared.fetchImage(url: imageUrl) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath {
                    return
                }
                cell.imageOutlet.contentMode = .scaleAspectFill
                cell.imageOutlet.image = image
                cell.setNeedsLayout()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = articleItems.count - 1
        if indexPath.row == lastElement,
            articlesCount >= articleItems.count * Int(self.defaultQuery["page"]!)! {
                self.defaultQuery["page"] = String(Int(self.defaultQuery["page"]!)! + 1)
                NewsController.shared.fetchArticles(matching: defaultQuery, completion: { (newsSource) in
                    if let newsSource = newsSource {
                        self.articlesCount = Int(newsSource.totalResults!)
                        print(self.articlesCount)
                        self.updateUI(with: newsSource)
                    }
                })
        }
    }
        
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height {
//
//
//            NewsController.shared.fetchArticles(matching: defaultQuery, completion: { (newsSource) in
//                if let newsSource = newsSource {
//                    self.defaultQuery["page"] = String(Int(self.defaultQuery["page"]!)! + 1)
//                    self.articlesCount = Int(newsSource.totalResults!)
//                    print(self.articlesCount)
//                    self.updateUI(with: newsSource)
//                }
//            })
//        }
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
