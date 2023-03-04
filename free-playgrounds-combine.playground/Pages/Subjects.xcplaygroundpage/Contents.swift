/*: ![Swift](matt-harding-logo.png)
 
 */
//: # Swift Simplified
//: ## A Free Playground
//: ## Demonstrating: Combine
//: ![instructor](instructor.png) [*with Matthew Harding*](https://www.udemy.com/user/iosbfree/)
//:
//: Swift v5.7 | 🚀 *Simplified for fast learning*
//:
//: -------------------
//: # Subjects
//: ## PassthroughSubject and CurrentValueSubject
//: What if we don't want to use @Published property wrappers?
//: After all, they force us to be notified *before* the event actually takes place.
//:
//: We can declare our own subject publisher to broadcast our messages for us 😀
import Combine
import Darwin

public class VideoPlaybackManager: ObservableObject {
    enum PlayStatus {
        case idle
        case buffering
        case readyToPlay
        case playing
        case finished
    }
    
    private(set) var status = PlayStatus.idle { didSet {
        statusPublisher.send(status)
        }
    }
    let statusPublisher = PassthroughSubject<PlayStatus, Never>() // 👈
    
    func play() {
        status = .buffering
        sleep(1)
        print("\nSetting a new status")
        status = .readyToPlay
        sleep(1)
        print("\nSetting a new status")
        status = .playing
        sleep(1)
        print("\nSetting a new status")
        status = .finished
    }
}

// Now, let's subscribe
let videoPlaybackManager = VideoPlaybackManager()
let subscriber = videoPlaybackManager.statusPublisher
    .sink { statusAboutToBeSet in
        print("Recieved new notification from Combine")
        let currentState = videoPlaybackManager.status
        print("current status: \(currentState)")
        print("combine notified us of: \(statusAboutToBeSet)")
        
    }
// ...and see what's printed to the console!
videoPlaybackManager.play()
// << 🔵 Run Point
//: We're recieving events **after** the value has been set! 🥳
//:
//: Our Pass Through Subject publisher is simply passing our value through the data stream to each subscriber. It doesn't get much simpler than that!
//:
//: - Experiment:
//:  The `PassthroughSubject` publishes values as they change. However, the `CurrentValueSubject` publisher informs each new subscriber of the current value first, followed by new events. Change the publisher to a `CurrentValueSubject` and re-run the code. Do you see the current value printed in the console first?
//: [Previous](@previous) | [Next](@next)
//:
//: -------------------
//: [Previous](@previous) | [Next](@next)
//:
//: -------------------
//: ## Created by [SwiftSimplified.com](https://www.swiftsimplified.com)
//: [SwiftSimplified.com](https://www.swiftsimplified.com)
//:
//: This playground is intended as extra resource for students taking our Swift Simplified online course - or for anyone else learning Swift.
//:
//: ![instructor](instructor.png) Created by [Matthew Harding](https://github.com/MatthewpHarding) | [GitHub](https://github.com/MatthewpHarding)| [Website](https://www.swiftsimplified.com) | [Our Courses](https://www.udemy.com/user/iosbfree/)
//:
//: 🤩 *..let's live a better life, by learning Swift* 🛠
//:
//: ### 🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
