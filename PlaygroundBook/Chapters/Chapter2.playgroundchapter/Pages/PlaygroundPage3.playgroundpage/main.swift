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
# Shaders
 
 In the last page, we learned about parallel processing.
 
 To sum it up, it's through it that computers can show and update graphics on their displays in a quick and efficient manner: by handling each pixel as a separate task, with all of the individual tasks to be done at once, instead of sequentially and in "chunks" of pixels (such as lines or circles).
 
 With parallel processing, the incredible tool known as a **shader** is born!
 
 ## What are shaders?
 
 Shaders are a type of computer software that allows pixels in a display to be updated in all kinds of custom ways. Basically, shaders "weaponize" parallel processing, using the fact that each pixel is updated individually to create effects over images, videos, or even blank canvas.
 
 The way shaders work can be summarized by the following image:
 
 ![Image showing a "sequence" of actions: single pixel exists, computer runs shader code in individual pixel, then pixel is updated according to shader.](how_shaders.png)
 
 As you can see, shader code isn't executed over the entirety of an image or video as one entire graphic *per se*, but over the individual pixels that form it.
 
 ## Shaders in action
 
 Just like before, the updated pixels form an image when joined together. But now, since shaders are commonly used over images and videos that already exist, effects like filters and distortions can be made!
 
 How about we see some shaders in action? Below, you can edit the value for the `shader` variable with the following options:
 
 - None
 - Emboss
 - Colorize
 - Pixelate
 
 Each one will update the image on the right according to the shader you chose, and you'll be able to check out an explanation on what each one is doing to the pixels by clicking on the button above the image!
 
 - Note:
When you've chosen a shader to apply on your image, press "**Run My Code**"!
*/
//#-hidden-code

enum Shader {
    case None, Pixelate, Colorize, Emboss
         //,Water
    
    func toString() -> String {
        switch self {
        case .None:
            return "None"
        case .Pixelate:
            return "Pixelate"
        case .Colorize:
            return "Colorize"
        case .Emboss:
            return "Emboss"
        }
    }
}

var shader: Shader!

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, None, Pixelate, Colorize, Emboss)
//#-end-hidden-code
shader = ./*#-editable-code*/None/*#-end-editable-code*/
//#-hidden-code
remoteView.send(.string(shader.toString()))
//#-end-hidden-code
/*:
Have you tried them all out? Then let's go to the **[next page](@next)**!
 */
