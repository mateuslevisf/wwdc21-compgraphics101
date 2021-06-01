//#-hidden-code
import PlaygroundSupport

class MessageHandler: PlaygroundRemoteLiveViewProxyDelegate {

    func remoteLiveViewProxy(
        _ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
        received message: PlaygroundValue
    ) {
        print("Received a message from the always-on live view", message)
    }

    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {}
}

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

let handler = MessageHandler()
remoteView.delegate = handler
//#-end-hidden-code
/*:
# 🧠 Processing Graphics
 
 Now that we know what a pixel is and how it shows us colors, the next question is one that goes a bit deeper:
 
 ## How do computers show us pixels?
 
 Your initial answer might be: well... they just show us. And while that might be right, we want to look at it in a more profound way!
 
 As we've seen, each pixel has an RGB value associated with it. By uniting thousands (if not millions) of pixels together, we see images on our computer screens. But what about videos? How do they work?
 
 "Well, that's simple," you might say, "the computer just needs to change the pixel values as the image it needs to show changes."
 
 And that's right! But for that to happen, it needs to do something a little bit more specific. As human beings, when we draw things, we do them in a serial manner: we draw a line, then another, and one by one we make a full drawing.
 
 Try drawing a smiley face [:)] in the screen beside this text - you can click on the pixels individually or just do swipe motions over them! When you're finished, click the "Run My Code" button to watch the computer fill in the pixels you marked.
 
 - Note:
Be careful - you can draw anything, but if the drawing is too big, drawing it can take a bit long. Remember you can click on a marked pixel to unmark it. When you've marked the pixels you want, press "**Run My Code**"!
 
*/
//#-hidden-code
enum Type {
    case Serial, Parallel
    
    func toString() -> String {
        switch self {
        case .Serial:
            return "Serial"
        case .Parallel:
            return "Parallel"
        }
    }
}

var typeOfDrawing: Type
//#-end-hidden-code
typeOfDrawing = ./*#-editable-code*/Serial/*#-end-editable-code*/
/*:
 As you could see, the computer filled in your drawing pixel by pixel, in the same order you marked them.
 
 Although in reality the computer would do so much faster, can you imagine how slow it would be if a computer had to "fill in" pixels, one by one and in order, with their proper colors every time something on the screen changed?
 
 That's why computers don't paint pixels in a "serial" or sequential manner, but in a **parallel** one. Try pressing the "RESET" button to clear your canvas, then draw something and change the value of the `typeOfDrawing` variable to ".Parallel" to see what happens!
 
 ## Parallel processing
 
 It might have been too quick to see - but that's the purpose of it! This time, the computer filled the pixels in a "parallel" manner, that is, it painted each pixel at the same time as it painted the others. That's how computers shows us images, and what allows for complex visual effects and videos to exist today. We call this manner of "painting" the pixels **parallel processing**. 
 
 */
//#-hidden-code
remoteView.send(.string(typeOfDrawing.toString()))
//#-end-hidden-code
/*:
Next, we'll talk about what's possible with parallel processing. Let's go to the **[next page](@next)**!
 */
