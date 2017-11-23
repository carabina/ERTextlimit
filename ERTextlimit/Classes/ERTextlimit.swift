//
//  ERTextlimit.swift
//  Pods
//
//  Created by earlmarv on 11/22/17.
//
//

import Foundation
import UIKit
import CoreGraphics

private let lblCharactersLeft = UILabel()
private let lblTail = UILabel()
private var timeVisibleSeconds:Double = 2.0
private var idleTime = 3.0
private var timerBubble = Timer()
private var messageTypeSetting:Int = 0

public enum messageType {
    case Remaining
    case ValByMax
    func returnItem()->Int{
        var messageTypeHolder:Int = 0
        switch self {
        case .Remaining:
            messageTypeHolder = 0
            break
        case .ValByMax:
            messageTypeHolder = 1
            break
        }
        return messageTypeHolder
    }
}
class UITextViewLimit:UITextView{
    
}

extension UITextView{
    private func colorBubble(color:UIColor){
        lblCharactersLeft.backgroundColor = color
        lblTail.textColor = color
    }
    private func blackBubble(){
        colorBubble(color: UIColor.black)
    }
    private func redBubble(){
        colorBubble(color: UIColor.red)
    }
    
    func textViewDidChange(notification:Notification)  {
    let maxCharacters = self.limitMessageCount ?? 0
        let textView = notification.object as! UITextView
        lblCharactersLeft.frame = CGRect.init(x: self.center.x - 40 , y: self.frame.origin.y - (24 + 10) , width: 80, height: 24)
        lblTail.center = CGPoint.init(x: lblCharactersLeft.center.x , y: lblCharactersLeft.center.y + 12 )
        timerBubble.invalidate()
        idleTime = 3.0
        timerBubble = Timer.runThisEvery(seconds: 1.0, handler: {
            _ in
            idleTime -= 1.0
            if idleTime < 1.0 {
                lblCharactersLeft.isHidden = true
                lblTail.isHidden = true
                timerBubble.invalidate()
            }
        })
        
        let charsCount = (textView.text?.characters.count)! > maxCharacters ? maxCharacters : (textView.text?.characters.count)!
        let charsLeft = maxCharacters - charsCount
        
        
        //set color
        if charsLeft < 1{
            redBubble()
            //trim
            textView.text = textView.text?.subString(startIndex: 0, length: maxCharacters)
        }else{
            blackBubble()
        }
        
        //check settings for messagetype
        let messageTypeSetting = self.limitMessagetype ?? 0
        switch messageTypeSetting {
            
        case 1:
            lblCharactersLeft.text = String(format:"%i/%i",charsCount,maxCharacters)
            break
        default:
            lblCharactersLeft.text = String(format:"%i left",charsLeft)
        }
        
        
        
        lblCharactersLeft.isHidden = false
        lblTail.isHidden = false
        
        
        
    }
    
    
    public func showCharactersLeft(maxChars:Int,timeVisible:Double, xOffset:CGFloat, yOffset:CGFloat,messageType:messageType){
        
        timeVisibleSeconds = timeVisible
        
        blackBubble()
        
        lblCharactersLeft.frame = CGRect.init(x: self.center.x - 40 + xOffset, y: self.bounds.origin.y - (24) + yOffset , width: 80, height: 24)
        lblCharactersLeft.textColor = UIColor.white
        lblCharactersLeft.layer.cornerRadius = 5.0
        lblCharactersLeft.layer.masksToBounds  = true
        lblCharactersLeft.textAlignment = .center
        lblCharactersLeft.text = String(format:"%i left",maxChars)
        lblCharactersLeft.isHidden = true
        lblCharactersLeft.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        //tail
        lblTail.text = "▼"
        lblTail.font = UIFont.boldSystemFont(ofSize: 30.0)
        lblTail.backgroundColor = UIColor.clear
        lblTail.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        lblTail.center = CGPoint.init(x: lblCharactersLeft.center.x + xOffset, y: lblCharactersLeft.center.y + 12 + yOffset)
        lblTail.isHidden = true
        
        self.limitMessagetype = messageType.returnItem()
        self.limitMessageCount = maxChars
        
        self.superview?.addSubview(lblTail)
        self.superview?.addSubview(lblCharactersLeft)

        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textViewDidChange(notification:)),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: self)
        
        
    }
    public func showCharactersLeft(maxChars:Int,timeVisible:Double){
        showCharactersLeft(maxChars: maxChars,timeVisible:timeVisible,xOffset:0.0,yOffset:0.0,messageType:.Remaining)
    }
    
    public func showCharactersLeft(maxChars:Int){
        showCharactersLeft(maxChars: maxChars,timeVisible:2.0,xOffset:0.0,yOffset:0.0,messageType:.Remaining)
    }
    
    
    private static let association = ObjectAssociation<NSObject>()
    
    var limitMessagetype: Int? {
        get { return UITextView.association[self] as? Int }
        set { UITextView.association[self] = newValue! as NSObject }
    }
    var limitMessageCount:Int? {
        get { return UITextView.association[self] as? Int }
        set { UITextView.association[self] = newValue! as NSObject }
    }
    
}

extension UITextField{
    
    
    
    private func colorBubble(color:UIColor){
        lblCharactersLeft.backgroundColor = color
        lblTail.textColor = color
    }
    
    private func blackBubble(){
        colorBubble(color: UIColor.black)
    }
    private func redBubble(){
        colorBubble(color: UIColor.red)
    }
    
    
    func textFieldDidChange(_ textField: UITextField)  {

        let maxCharacters = self.limitMessageCount ?? 0
        lblCharactersLeft.frame = CGRect.init(x: self.center.x - 40 , y: self.frame.origin.y - (24 + 10) , width: 80, height: 24)
        lblTail.center = CGPoint.init(x: lblCharactersLeft.center.x , y: lblCharactersLeft.center.y + 12 )
        timerBubble.invalidate()
        
        idleTime = 3.0
        timerBubble = Timer.runThisEvery(seconds: 1.0, handler: {
            _ in
            idleTime -= 1.0
            if idleTime < 1.0 {
                lblCharactersLeft.isHidden = true
                lblTail.isHidden = true
                timerBubble.invalidate()
            }
        })
        
        let charsCount = (textField.text?.characters.count)! > maxCharacters ? maxCharacters : (textField.text?.characters.count)!
        var charsLeft = maxCharacters - charsCount
        
        //set color
        if charsLeft < 1{
            charsLeft = 0
            redBubble()
            
            //trim
            textField.text = textField.text?.subString(startIndex: 0, length: maxCharacters)
        }else{
            blackBubble()
        }
        
        //check settings for messagetype
        let messageTypeSetting = self.limitMessagetype ?? 0
        switch messageTypeSetting {
            
        case 1:
            lblCharactersLeft.text = String(format:"%i/%i",charsCount,maxCharacters)
            break
        default:
            lblCharactersLeft.text = String(format:"%i left",charsLeft)
        }

        lblCharactersLeft.isHidden = false
        lblTail.isHidden = false
        
        
    }
    
    
    public func showCharactersLeft(maxChars:Int,timeVisible:Double, xOffset:CGFloat, yOffset:CGFloat,messageType:messageType){
    
        
       
        timeVisibleSeconds = timeVisible
        
        blackBubble()
        
        lblCharactersLeft.frame = CGRect.init(x: self.center.x - 40 + xOffset, y: self.bounds.origin.y - (24) + yOffset , width: 80, height: 24)
        
        lblCharactersLeft.textColor = UIColor.white
        lblCharactersLeft.layer.cornerRadius = 5.0
        lblCharactersLeft.layer.masksToBounds  = true
        lblCharactersLeft.textAlignment = .center
        lblCharactersLeft.text = String(format:"%i left",maxChars)
        lblCharactersLeft.isHidden = true
        lblCharactersLeft.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        //tail
        lblTail.text = "▼"
        lblTail.font = UIFont.boldSystemFont(ofSize: 30.0)
        lblTail.backgroundColor = UIColor.clear
        lblTail.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        lblTail.center = CGPoint.init(x: lblCharactersLeft.center.x , y: lblCharactersLeft.center.y + 12 )
        lblTail.isHidden = true
        
        self.limitMessagetype = messageType.returnItem()
        self.limitMessageCount = maxChars
        
        self.superview?.addSubview(lblTail)
        self.superview?.addSubview(lblCharactersLeft)
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    public func showCharactersLeft(maxChars:Int,timeVisible:Double){
        showCharactersLeft(maxChars: maxChars,timeVisible:timeVisible,xOffset:0.0,yOffset:0.0,messageType:.Remaining)
    }
    
    public func showCharactersLeft(maxChars:Int){
        showCharactersLeft(maxChars: maxChars,timeVisible:2.0,xOffset:0.0,yOffset:0.0,messageType:.Remaining)
    }
    
    
    
    private static let association = ObjectAssociation<NSObject>()
    
    var limitMessagetype: Int? {
        get { return UITextField.association[self] as? Int }
        set { UITextField.association[self] = newValue! as NSObject }
    }
    var limitMessageCount:Int? {
        get { return UITextField.association[self] as? Int }
        set { UITextField.association[self] = newValue! as NSObject }
    }
    
}
extension String{
    public func subString(startIndex: Int, length: Int) -> String {
        let fromindex = self.index(self.startIndex, offsetBy: startIndex)
        var toindex:Index
        if length > self.characters.count{
            toindex = self.index(self.startIndex, offsetBy: self.characters.count - 1)
        }else{
            toindex = self.index(self.startIndex, offsetBy: length)
        }
        return self.substring(from: fromindex).substring(to:toindex)
        
    }
}
extension Timer {
    /// EZSE: Runs every x seconds, to cancel use: timer.invalidate()
    public static func runThisEvery(seconds: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    /// EZSE: Run function after x seconds
    public static func runThisAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    

    /// EZSwiftExtensions - dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
    public static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
public final class ObjectAssociation<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        self.policy = policy
    }
    
    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}



