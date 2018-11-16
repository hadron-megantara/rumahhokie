//
//  NewsController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import Alamofire

class NewsController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var sideIsOpened: Bool = false
    var dataTotal: Int = 0
    var newsArray: Array = [Any]()
    var filterId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        btnProperty.titleLabel?.adjustsFontSizeToFitWidth = true
//        btnNew.titleLabel?.adjustsFontSizeToFitWidth = true
//        btnPopular.titleLabel?.adjustsFontSizeToFitWidth = true
//        btnGalery.titleLabel?.adjustsFontSizeToFitWidth = true
//        btnVideo.titleLabel?.adjustsFontSizeToFitWidth = true
        
//        let menuView = Bundle.main.loadNibNamed("NewsMenu", owner: nil, options: nil)![0] as! UIView
//        viewMenu.addSubview(menuView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            self.navigationItem.title = "Berita"
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            let btnFilter = UIButton(type: .custom)
            btnFilter.titleLabel?.font = UIFont(name: "FontAwesome", size: 20)
            btnFilter.setTitle("", for: .normal)
            
            btnFilter.addTarget(self, action: #selector(openFilter), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnFilter)
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
            bottomMenuView.frame.size.width = bottomMenu.frame.width
            bottomMenu.addSubview(bottomMenuView)
        } else{
            self.navigationController?.navigationBar.isHidden = true
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
            bottomMenu.addSubview(bottomMenuView)
        }
    }
    
    @objc func openFilter(){
        if(!sideIsOpened){
            sideIsOpened = true
            let sideMenu = Bundle.main.loadNibNamed("SideBar", owner: nil, options: nil)![0] as! UIView
            sideMenu.frame.size.width = self.view.frame.width * 4/5
            sideMenu.frame.size.height = self.view.frame.height
            sideMenu.tag = 100
            
            self.view.superview?.isUserInteractionEnabled = true
            self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            
            UIView.transition(with: self.view, duration: 0.5, options:[],animations: {self.view.addSubview(sideMenu)}, completion: nil)
        } else{
            sideIsOpened = false
            let sideView = view.viewWithTag(100)
            sideView?.removeFromSuperview()
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        sideIsOpened = false
        let sideView = view.viewWithTag(100)
        sideView?.removeFromSuperview()
    }
    
    func loadNews(){
        let group = DispatchGroup()
        group.enter()
        
        var urlVar = "http://rumahhokie.com/beritaproperti/wp-json/wp/v2/posts?&offset=0&per_page=40&_embed=1"
        
        if self.filterId != 0{
            urlVar = urlVar+"&categories=\(self.filterId)"
        }
        
        DispatchQueue.main.async {
            Alamofire.request(urlVar, method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let resArray = json as? Array<AnyObject>{
                        for r in resArray{
                            self.dataTotal = self.dataTotal + 1
                            
                            var dataTitle: String = ""
                            var dataImage: String = ""
                            var dataDate: String = ""
                            var dataUrl: String = ""
                            
                            if let objTitle = r["title"] as? [String:AnyObject] {
                                dataTitle = objTitle["rendered"]! as! String
                            }
                            
                            if let objUrl = r["guid"] as? [String:AnyObject] {
                                dataUrl = objUrl["rendered"]! as! String
                            }
                            
                            if let objDate = r["date"] as? String {
                                dataDate = objDate.replacingOccurrences(of: "T", with: " ")
                            }
                            
                            if let objImage = r["_embedded"] as? [String:AnyObject] {
                                if let imgJson = objImage["wp:featuredmedia"] as? Array<AnyObject>{
                                    for imgArray in imgJson{
                                        if let objMediaDetail = imgArray["media_details"] as? [String:AnyObject] {
                                            if let objFull = objMediaDetail["sizes"]!.value(forKey: "full"){
                                                dataImage = (objFull as AnyObject).value(forKey: "source_url")! as! String
                                            }
                                        }
                                    }
                                }
                            }
                            
                            let returnArray = [dataTitle, dataImage, dataDate, dataUrl]
                            self.newsArray.append(returnArray)
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuFilterAction(_ sender: UIButton) {
        if sender.tag == 21{
            filterId = 0
        } else if sender.tag == 22{
            filterId = 13
        } else if sender.tag == 23{
            filterId = 2
        } else if sender.tag == 24{
            filterId = 11
        } else if sender.tag == 25{
            filterId = 8
        } else if sender.tag == 26{
            filterId = 10
        } else if sender.tag == 37{
            filterId = 268
        } else if sender.tag == 27{
            filterId = 9
        } else if sender.tag == 28{
            filterId = 12
        } else if sender.tag == 29{
            filterId = 2635
        } else if sender.tag == 30{
            filterId = 14
        } else if sender.tag == 31{
            filterId = 258
        } else if sender.tag == 32{
            filterId = 723
        } else if sender.tag == 33{
            filterId = 237
        } else if sender.tag == 34{
            filterId = 4325
        } else if sender.tag == 35{
            filterId = 398
        } else if sender.tag == 36{
            filterId = 1
        }
        
        self.newsArray.removeAll()
        loadNews()
    }
    
}

extension NewsController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListNews", for: indexPath) as UITableViewCell
        
        if self.newsArray.indices.contains(indexPath.row){
            if let objData = self.newsArray[indexPath.row] as? Array<AnyObject>{
                if let label1 = cell.viewWithTag(1) as? UIImageView{
                    if ((objData[1] as? String) != ""){
                        let pictUrl = URL(string: objData[1] as! String)!
                        
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: pictUrl){
                                if let dataImage = UIImage(data: data){
                                    DispatchQueue.main.async {
                                        label1.image = dataImage
                                    }
                                }
                            }
                        }
                    }
                }
                
                if let label2 = cell.viewWithTag(2) as? UILabel{
                    label2.text = objData[0] as? String
                }
                
                if let label3 = cell.viewWithTag(3) as? UILabel{
                    label3.text = objData[2] as? String
                }
            }
        }
        
        return cell
    }
}

extension NewsController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objData = self.newsArray[indexPath.row] as? Array<AnyObject>{
            if objData.indices.contains(3){
                print(URL(string: ((objData[3] as? String)!)) as Any)
                if (URL(string: ((objData[3] as? String)!)) != nil){
                    UIApplication.shared.open(URL(string: (objData[3] as? String)!)!, options: [:])
                }
            }
        }
    }
}
