//
//  userViewController.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class userViewController: UIViewController {

    @IBOutlet weak var userTableview: UITableView!
    
    var imagedata = ["1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5","1","2","3","4","5","6","5"]
    
    var ref : DatabaseReference!
    
    var Usermodel = [user]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    func getData() {

        self.createspinner()
        let db = Firestore.firestore()

        db.collection("users").getDocuments { snapshot, error in

            if error == nil {
                // No errors

                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for document in snapshot.documents {
                            let data = document.data()
                            let uid = data["uid"] as? String ?? "missing"
                            let firstName = data["firstname"] as? String ?? "missing"
                            let secondName = data["lastname"] as? String ?? "missing"


                            self.Usermodel.append(user.init(uid: uid, firstname: firstName, lastname: secondName))


                        }
                        self.removespinner()
                        self.userTableview.reloadData()
                    }


                }
            }
            else {
                // Handle the error
                print("no data found")
            }
        }
    }
    

}
extension userViewController:UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc  = self.storyboard?.instantiateViewController(identifier: "chatViewController") as? chatViewController{
            vc.userobj = Usermodel[indexPath.row]
           // vc.username = Usermodel[indexPath.row].firstname
             self.navigationController?.pushViewController(vc, animated: true)
         }

    }
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Usermodel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! userTableviewCell
        cell.firstNameLable.text = Usermodel[indexPath.row].firstname
        cell.lastNameLable.text =  Usermodel[indexPath.row].lastname
        cell.chatimageView.image = UIImage(named: imagedata[indexPath.row])
        return cell
    }


}
