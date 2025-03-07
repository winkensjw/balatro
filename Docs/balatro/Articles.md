* Creating a short cut for the editor
* DataObjects and SaveManagement
* DevConsole and management
* Game UI Database


https://www.reddit.com/r/godot/comments/16vq15a/comment/k2uzy9x/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
1. make a folder called `external` in the root of your project.
	
2. create `external/.gdignore` so that godot doesn't import anything from this directory into your project.
	
3. clone all desired addons as submodules in this directory
	
4. for each addon, create a relative path symlink from `addons/whatever` to `../external/whatever/addons/whatever`.
	
5. commit the symlinks along with the submodules.