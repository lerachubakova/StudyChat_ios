//
//  HomeVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class HomeVC: BaseVC {

    // MARK: - @IBOutlets
    @IBOutlet weak private var myBackgroundImageView: UIImageView!
    @IBOutlet weak private var navigationBarView: UIView!
    @IBOutlet weak private var navigationBar: UINavigationBar!
    @IBOutlet weak private var profileImageView: UIImageView!
    
    @IBOutlet weak private var messageView: UIView!
    @IBOutlet weak private var messageTextView: UITextView!
    @IBOutlet weak private var messageTextConstraint: NSLayoutConstraint!
    @IBOutlet weak private var chatTableView: UITableView!
    @IBOutlet weak private var sendButton: UIButton!
    @IBOutlet weak private var addFileButton: UIButton!
    
    private var oldElementsPositions: [CGFloat] = []
    private var inset = CGFloat()
    
    private let placeholderString = "Message..."
    private let placeholderColor = UIColor.darkGray
    private let textColor = UIColor.white
    private let textViewMaxHeight: CGFloat = 141.6

    // MARK: - LifeCycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureAppearance()
        oldElementsPositions = [navigationBar, navigationBarView, profileImageView, myBackgroundImageView].map({ $0?.frame.origin.y ?? 0.0 })
        moveElemets(on: inset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImageView.image = User().getPicture()
        updateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
        configureMessageTextView()
        configureChatTableView()
    }
    
    // MARK: - Logic
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func moveElemets(on inset: CGFloat) {
        navigationBar.frame.origin.y = oldElementsPositions[0] + inset
        navigationBarView.frame.origin.y = oldElementsPositions[1] + inset
        profileImageView.frame.origin.y = oldElementsPositions[2] + inset
        myBackgroundImageView.frame.origin.y = oldElementsPositions[3] + inset
    }
    
    private func configureAppearance() {
        navigationBar.transparent()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        sendButton.setPointSize(procentOfHeight: 0.9)
        addFileButton.setPointSize(procentOfHeight: 0.9)
    }
    
    private func configureMessageTextView() {
        messageTextView.delegate = self
        messageTextView.layer.borderColor = separatorColor.cgColor
        messageTextView.text = placeholderString
        messageTextView.textColor = placeholderColor
        messageTextView.textContainerInset.left += 5.0
        messageTextView.textContainerInset.right += 5.0
    }

    private func configureChatTableView() {
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTableView(_:))))
        chatTableView.backgroundColor = .clear
        chatTableView.separatorStyle = .none
        // chatTableView.separatorColor = .clear
        // chatTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        chatTableView.transform = CGAffineTransform(scaleX: -1, y: -1)
        chatTableView.register(MessageTVCell.nib(), forCellReuseIdentifier: MessageTVCell.identifier)
    }

    private func updateTable() {
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
        }
    }
    
    private func scrollTableToEnd() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    // MARK: - @IBActions
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let bottomOfTextField = messageView.convert(messageView.bounds, to: self.view).maxY
        let topOfKeyboard = self.view.frame.height - keyboardFrame.height
        inset = bottomOfTextField - topOfKeyboard
        moveElemets(on: inset)
        self.view.frame.origin.y = -inset
    }
    
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        inset = 0.0
        moveElemets(on: inset)
        self.view.frame.origin.y = inset
    }
    
    @IBAction private func tapTableView(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func sendMessage(_ sender: UIButton) {
        guard messageTextView.textColor == .white else {return}
        messages.append(Message(type: .sender, text: messageTextView.text))
        messageTextView.text = placeholderString
        messageTextView.textColor = placeholderColor
        messageTextView.selectedTextRange = messageTextView.textRange(from: messageTextView.beginningOfDocument, to: messageTextView.beginningOfDocument)
        updateTable()
        scrollTableToEnd()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            messages.append(Message(type: .receiver, text: "Рандомное сообщение"))
            self.updateTable()
        }
       
    }
    
    @IBAction private func addFile(_ sender: UIButton) {
    }
    
}

// MARK: - Extensions
// MARK: - TextView
extension HomeVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            textView.text = placeholderString
            textView.textColor = placeholderColor
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == placeholderColor && !text.isEmpty {
            textView.textColor = textColor
            textView.text = text
        } else { return true }
        
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == placeholderColor {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
                UIView.animate(withDuration: 0.2) {
                    self.sendButton.tintColor = .systemGray4
                    self.sendButton.setImage(UIImage.init(systemName: "message.circle.fill"), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.sendButton.tintColor = .white
                    self.sendButton.setImage(UIImage.init(systemName: "location.circle.fill"), for: .normal)
                }
                let width = textView.frame.size.width
                let newSize = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
                let height = newSize.height
                if height < textViewMaxHeight {
                    messageTextConstraint.constant = height
                    textView.isScrollEnabled = false
                } else {
                    textView.isScrollEnabled = true
                    textView.showsVerticalScrollIndicator = true
                    textView.indicatorStyle = .white
                }
            }
        }
    }
}

// MARK: - TableView
extension HomeVC: UITableViewDelegate {}
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let messageCell = chatTableView.dequeueReusableCell(withIdentifier: MessageTVCell.identifier) as? MessageTVCell {
            messageCell.selectionStyle = .none
            let message = messages[messages.count - 1 - indexPath.row]
            messageCell.configure(by: message)
            if message.type == .sender {
             messageCell.transform = CGAffineTransform(scaleX: 1, y: -1)
            } else {
                messageCell.transform = CGAffineTransform(scaleX: -1, y: -1)
            }
            return messageCell
        }
        return  UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
