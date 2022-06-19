//  Main View Controller
//  chatViewController.swift
//  createchat
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class chatViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var ChatTableView: UITableView!
    
    @IBOutlet weak var chatTextfield: UITextField!
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var sndBtn: UIButton!
    
    
    let db = Firestore.firestore()
    var userobj: user?
    var currentUser: User = Auth.auth().currentUser!
    private var docReference: DocumentReference?
    var messages: [Message] = []
    var firstname: String?
    var uid: String?
    var usermodel = [user]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLable.text = username
        // ChatTableView = userobj?.uid
        nameLable.text = userobj?.lastname
        chatTextfield.delegate = self
        sndBtn.isEnabled = false
        sndBtn.alpha = 0.5
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        getData()
        loadData()
       // loadChat()
        
    }
    
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = (chatTextfield.text! as NSString).replacingCharacters(in: range, with: string)
    if text.isEmpty {
     sndBtn.isEnabled = false
     sndBtn.alpha = 0.5
    } else  {
        
     sndBtn.isEnabled = true
     sndBtn.alpha = 1.0
    }
     return true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func getData() {

        db.collection("user").getDocuments { snapshot, error in
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for document in snapshot.documents {
                            let data = document.data()
                            self.uid = data["uid"] as? String ?? "missing"
                            print("uid")
                            self.firstname = data["firstname"] as? String ?? "missing"
                            //  let secondName = data["lastname"] as? String ?? "missing"
                            
                            
                            self.usermodel.append(user.init(uid: self.uid ?? "", firstname: self.firstname ?? "", lastname: ""))
                            
                        }
                        
                        self.ChatTableView.reloadData()
                    }
                }
            }
            else {
                print("no data found")
            }
        }
    }
    
    
    func loadData(){
        self.messages.removeAll()
      
        
        db.collection("Chat").document(UUID().uuidString).setData([
            "Timestamp":"",
            "message": "message",
            "senderID": "senderID",
            "senderName": "senderName"
        ])  {  err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
        
        
        
        
        
        
        
        
        db.collection("Chat").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {

                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    let dict = document.data()
                    
                    self.messages.append(Message(Timestamp: Timestamp(),  message: "\(dict["message"] as? String ?? "")", senderID: "\(dict["senderID"] as? String ?? "")", senderName: "\(dict["senderName"] as? String ?? "")"))
//                id: "\(dict["id"] as? String ?? "")",

                   // dict = 33
                //Timestamp: "\(dict["Timestamp"] as? String ?? "")",
                }
                self.ChatTableView.reloadData()
                self.scrollToBottom()
            }
        }
//        let db = Firestore.firestore()
//        db.collection("Chat").whereField("senderID", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
//                .getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                                            print("\(document.documentID) => \(document.data())")
//                                            let dict = document.data()
//                                            self.messages.append(Message( id: "\(dict["id"] as? String ?? "")", message: "\(dict["message"] as? String ?? "")", senderID: "\(dict["senderID"] as? String ?? "")", senderName: "\(dict["senderName"] as? String ?? "")"))
//
////                        for document in querySnapshot!.documents {
////                            print("\(document.documentID) => \(document.data())")
////                        }
//                        }
//
//                    }
//            }
    }

//    private func insertNewMessage(_ message: Message) {
//
//        messages.append(message)
//        messages.sort(message)
//        ChatTableView.reloadData()
//
//        self.scrollToBottom()
//    }
    private func save(_ message: Message) {
        //Preparing the data as per our firestore collection
        let data: [String: Any] = [
            "Timestamp": message.Timestamp,
            "message": message.message,
           // "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
       // self.scrollToBottom()
        //Writing it to the Messages  using the saved document reference we saved in load chat function
        /*
        docReference?.collection("Messages").addDocument(data: data, completion: { (error) in
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            self.scrollToBottom()
        })
        */
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("Chat").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.loadData()
            }
        }
        //self.ChatTableView.reloadData()
    }
    
//    func readLastMessage() {
//        let ref = Firestore.firestore().collection("Chats").order(by: "timestamp", descending: true).limit(to: 1)
//        ref.getDocuments(completion: { querySnapshot, error in
//            guard let snapshot = querySnapshot else {
//                print("Error fetching snapshots: \(error!)")
//                return
//            }
//
//            if let doc = snapshot.documents.first {
//                let docID = doc.documentID
//                let msg = doc.get("msg")
//                print(docID, msg!)
//            }
//        })
//    }
//
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    func scrollToBottom(){
    
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
            self.ChatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 2 {
            self.view.frame.origin.y = 0
        }
    }
//id: UUID().uuidString
    func sendmessage (){
        let message = Message( Timestamp: Timestamp(), message: chatTextfield.text!, senderID: currentUser.uid, senderName:firstname ?? "")
        
        
        save(message)
       // readLastMessage()
        chatTextfield.text = message.message
        chatTextfield.text?.removeAll()
        scrollToBottom()
        print("press")
    }

    @IBAction func cameraBtn(_ sender: Any) {
       
    }
    @IBAction func backkBtn(_ sender: UIButton) {
        print("pressed")
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];

       for aViewController:UIViewController in viewControllers {
                   if aViewController.isKind(of: chatViewController.self) {
                       _ = self.navigationController?.popToViewController(aViewController, animated: true)
                   }
               }
       
    }
    @IBAction func sendButton(_ sender: Any) {
        sendmessage()
        
    }

}

//MARK: Chat tableView extension
extension chatViewController: UITableViewDelegate,UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let message = messages[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderTbaleViewCell", for: indexPath) as! senderTbaleViewCell
        cell.messageLable.text = messages[indexPath.row].message
            
        if message.senderID == Auth.auth().currentUser?.uid {
                
                cell.messageLable.textAlignment = .right
            cell.messageView.backgroundColor = UIColor.white
                cell.messageLable.textColor = UIColor(named: K.BrandColors.purple)
            
            } else {
              
                cell.messageLable.textAlignment = .left
                cell.messageView.backgroundColor = UIColor.white
                cell.messageLable.textColor = UIColor(named: K.BrandColors.lighBlue)
            }
            return cell
        }

    }
//        let message = messages[indexPath.row]
//       // if message.side == .left {
//            let cell = ChatTableView.dequeueReusableCell(withIdentifier: "senderTbaleViewCell") as! senderTbaleViewCell
//            cell.configureCell(message: message)
//            //return cell
////        }
////        else {
////            let cell = ChatTableView.dequeueReusableCell(withIdentifier: "receiverTableViewCell") as! receiverTableViewCell
//          //  cell.configureCell(message: message)
//            return cell
//      //  }
    
    
    




















































//func loadData(){
//    self.messages.removeAll()
////
////        let docRef = db.collection("Chat").document(currentUser.uid
////        )
////
////        docRef.getDocument { (document, error) in
////            if let document = document, document.exists {
////                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
////                print("Document data: \(dataDescription)")
////            } else {
////                print("Document does not exist")
////            }
////            self.ChatTableView.reloadData()
////        }
//
//
////
////        db.collection("Chat").getDocuments() { (querySnapshot, err) in
////            if let err = err {
////                print("Error getting documents: \(err)")
////            } else {
////
////                for document in querySnapshot!.documents {
////                    print("\(document.documentID) => \(document.data())")
////                    let dict = document.data()
////                    self.messages.append(Message( id: "\(dict["id"] as? String ?? "")", message: "\(dict["message"] as? String ?? "")", senderID: "\(dict["senderID"] as? String ?? "")", senderName: "\(dict["senderName"] as? String ?? "")"))
////
////
////                   // dict = 33
////                //Timestamp: "\(dict["Timestamp"] as? String ?? "")",
////                }
////                self.ChatTableView.reloadData()
////                self.scrollToBottom()
////            }
////        }
//
//        db.collection("Chat").whereField("senderID", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                                        print("\(document.documentID) => \(document.data())")
//                                        let dict = document.data()
//                                        self.messages.append(Message( id: "\(dict["id"] as? String ?? "")", message: "\(dict["message"] as? String ?? "")", senderID: "\(dict["senderID"] as? String ?? "")", senderName: "\(dict["senderName"] as? String ?? "")"))
////                        for document in querySnapshot!.documents {
////                            print("\(document.documentID) => \(document.data())")
////                        }
//                    }
//
//                }
//        }
//}
