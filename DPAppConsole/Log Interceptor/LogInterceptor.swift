//
//  LogIntercepter.swift
//  LogIntercepter
//
//  Created by Drew Pitchford on 7/31/18.
//
// source: https://medium.com/@thesaadismail/eavesdropping-on-swifts-print-statements-57f0215efb42

import Foundation

protocol LogInterceptorDelegate: class {
    
    func logRead(_ message: String)
}

public class LogIntercepter {
    
    // MARK: - Singleton
    public static let shared = LogIntercepter()
    
    private var inputPipe: Pipe?
    private var outputPipe: Pipe?
    weak var delegate: LogInterceptorDelegate?
    
    public func start() {
        
        openConsolePipe()
    }
    
    func openConsolePipe() {
        
        //open a new Pipe to consume the messages on STDOUT and STDERR
        inputPipe = Pipe()
        
        //open another Pipe to output messages back to STDOUT
        outputPipe = Pipe()
        
        guard let inputPipe = inputPipe, let outputPipe = outputPipe else {
            return
        }
        
        let pipeReadHandle = inputPipe.fileHandleForReading
        dup2(STDOUT_FILENO, outputPipe.fileHandleForWriting.fileDescriptor)
        dup2(inputPipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
        dup2(inputPipe.fileHandleForWriting.fileDescriptor, STDERR_FILENO)
        
        //listen in to the readHandle notification
        NotificationCenter.default.addObserver(self, selector: #selector(handlePipeNotification), name: FileHandle.readCompletionNotification, object: pipeReadHandle)
        
        //state that you want to be notified of any data coming across the pipe
        pipeReadHandle.readInBackgroundAndNotify()
    }
    
    @objc func handlePipeNotification(notification: Notification) {
        
        inputPipe?.fileHandleForReading.readInBackgroundAndNotify()
        
        if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? Data,
            let str = String(data: data, encoding: String.Encoding.ascii) {
            
            //write the data back into the output pipe. the output pipe's write file descriptor points to STDOUT. this allows the logs to show up on the xcode console
            outputPipe?.fileHandleForWriting.write(data)
            delegate?.logRead(str)
        }
    }
}
