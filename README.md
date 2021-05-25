# Automatic sprite rotation

This node is designed for use with 2D sprites in a top-down style (think of the 2D Legend of Zelda games) that exist in a 3D environment. When the camera moves through 3D space, it can be tedious to make sure that the sprite displays the image corresponding to the correct angle at all times. Enter this node: It uses the position and rotation of the camera to automatically display the correct image for the sprite's angle relative to the camera, totally seamlessly.

## Huh?

It'll be a lot more clear with a demo:

https://user-images.githubusercontent.com/29902980/119442710-f34b4700-bced-11eb-95c6-60b30273a21b.mp4

## How can I use it?

The sprite rotation node's script is located at `Automatic sprite rotation/rotating_sprite.gd`. 

Also, this whole repository is an example project for said node, so you can see how it's used by opening `Automatic sprite rotation/project.godot` in the Godot editor.

## Authors and Acknowledgements

- Built by Alex Kitt
- Sprites used in the example are owned by Nintendo
