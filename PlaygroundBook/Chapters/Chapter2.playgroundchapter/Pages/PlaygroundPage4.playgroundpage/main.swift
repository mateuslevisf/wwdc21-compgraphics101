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
# More uses of Shaders
 
 Now, we've seen what shaders can do with images. Both filters we apply to everyday pictures and professional-looking photography ones can be created through this kind of software.
 
 But are shaders *really* only useful for static effects?
 
 ## Dynamic Shaders
 
 The answer is... no! Shaders are useful for many other things.
 
 To show off what shaders can do besides the static kinds of effects we saw in the last page, we'll try another kind now.
 
 First, try setting the `underwater` variable below to `true` to see what happens!
*/
//#-hidden-code
var underwater: Bool = false
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
underwater = /*#-editable-code*/false/*#-end-editable-code*/
/*:
 Did you see what happened?
 
 By using a different kind of shader, we can simulate a "water" effect on the images we're visualizing - in this case, the little robot Memoji. But that's not all shaders can do. Let's do something else as well!
*/
//#-hidden-code
var lightsOn: Bool = false

func turnLightsOn() {
    lightsOn = true
}
//#-end-hidden-code
// Try calling the "turnLightsOn()" function!
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, turnLightsOn())
//#-end-hidden-code
/*#-editable-code*//*#-end-editable-code*/
//#-hidden-code
remoteView.send(.array([.boolean(underwater), .boolean(lightsOn)]))
//#-end-hidden-code
/*:
 - Note:
 Can you see the light? Try clicking around and moving the light around the view!
 
 As you can see, shaders can also be used to simulate lightning in virtual environments. You might ask: "is this even a shader?!"
 
 Yes. Yes, it is. After all, if we go deep into it these kinds of effects aren't anything unexpected: they're calculations done based on the position of a simulated light source, the distance from each pixel to it, and if there are any pixels on the middle - besides other factors such as light intensity, radius of the light source, etc.
 
 Something that is interesting to note is that if we turn on both the "water" and the "light" shaders, the lightning on the robot doesn't show up as well as it did before. That's because the "water" shader overrides the "light" shader - in order to get both effects at the same time, we'd have to use a more complex shader in order to account for both effects on each pixel simultaneously.
 
 Have you played around with the dynamic shaders? Then let's finish everything up at the **[last page](@next)**!
 */
