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
 ![Title image showing the Playground logo, consisting of the words "Computer Graphics" written in a robotic-like font and a computer "emoji".](title_image.png)
 
 In this playground, we'll learn about computer graphics: what they are, how they work, and some tools related to them.
 
 ## What are computer graphics?
 
 Once upon a time, computers didn't really show any images - if they showed anything. As time passed, modern displays - like the screens in our PCs and phones - were created. Through them, we can not only see images and videos with increasingly high definition, but also create and appreciate visual effects and experiences that would only exist in our imaginations otherwise.
 
 That's great, of course. But if we want to look more into it, we have to start with something smaller. We'll start with something pretty simple - and *very* small.
 
 # A Pixel
 
 When we look at anything on our computer screen, what we're seeing is actually the combination of *thousands* - maybe even millions, depending on the display - of colored squares called pixels - short for "**pic**ture **el**ement**s**".
 
 Since our topic is about something visual - how about we stop the telling and skip straight to the showing? To the right side of this text, you should see a white background with a grid over it. To illustrate our subject, that's our representation of a *really* zoomed-in computer display.
 
 ## Interaction
 So let's make one pixel stand out! Try editing the value of the "alpha" variable below to anything between 0.0 and 1.0.
 
*/
//#-hidden-code
var alpha: Double
//#-code-completion(everything, hide)
//#-end-hidden-code
alpha = /*#-editable-code*/0.0/*#-end-editable-code*/
/*:
 Do you see that black square on the middle of the grid, now? Try cranking up that value to 1.0, just so we can see it better. For now, that's our pixel! What you just did was edit its alpha value; that's what determines its transparency, which is useful for overlaying different colors when needed, or having "invisible" backgrounds on images.
 
 Now that we can see the pixel, let's try editing its color, shall we? The color of a pixel is determined by a set of 3 values - the famous **RGB**. Each value is associated with a primary color: specifically red, green and blue. By changing and mixing up these values, we can make all different kinds of colors - which together, make up the images we see on screen.

 ## Changing colors
 
 Try doing it yourself! Assign **any value between 0 and 1** to each of the variables below and run the code to see what happens. Remember you can also change the `alpha` variable value above. If you can't see anything, double-check if alpha isn't equal to 0 and the RGB values aren't equal to (1.0,1.0,1.0) - those are, respectively, a transparent and a white pixel.
 
 - Note:
When you've assigned the values to the variables below, press "**Run My Code**"!
 */
//#-hidden-code
var red: Double
var green: Double
var blue: Double
//#-code-completion(everything, hide)
//#-end-hidden-code
red = /*#-editable-code*/0.0/*#-end-editable-code*/
green = /*#-editable-code*/0.0/*#-end-editable-code*/
blue = /*#-editable-code*/0.0/*#-end-editable-code*/
//#-hidden-code

remoteView.send(.array([.floatingPoint(red), .floatingPoint(green), .floatingPoint(blue), .floatingPoint(alpha)]))
//#-end-hidden-code
/*:
Can you make the pixel be colored cyan, magenta or yellow? When you're ready, go to the **[next page](@next)**!
 */
