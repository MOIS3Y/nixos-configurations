# Afterword

If you’ve made it this far, thank you for exploring my configuration! 

This documentation doesn't cover every single line of code or explain every module in detail. Instead, I’ve focused on the most important parts—the parts that go beyond standard NixOS modules and define the unique "flavor" of this setup.

## A Note for Beginners

If you are new to Nix and some of this feels overwhelming, **don't worry**. It’s perfectly normal. You don't need to start with a complex modular architecture or a custom-themed Wayland compositor. 

> [!TIP]
> Start simple. Enable a default desktop environment like GNOME or KDE with just a couple of lines. As you get comfortable, start expanding your configuration. When a file starts feeling too large or cluttered, move parts of it into separate files. Understanding Nix expressions and the module system comes naturally with practice.

## My Philosophy: Simplicity over Over-engineering

Over my three years of using NixOS, I’ve learned an important lesson: **don't chase the DRY (Don't Repeat Yourself) principle at any cost.**

In Nix, building complex logic to calculate whether an attribute should be enabled or disabled can often lead to a "dependency hell" in your head. Sometimes, a bit of duplication is actually a good thing.

### Why I Choose Duplication

For my servers, I usually copy only the styling from the shared configuration and keep the rest separate. 
- **Independence:** My hosts don't rely heavily on each other's logic.
- **Maintainability:** When I need to change something globally, I don't have to spend hours untangling a web of inter-host dependencies. Future me always says "thank you" when a change is isolated and easy to reason about.

## Organization by Attribute

You might notice that my system modules are mostly split by their **root attribute** (e.g., `services.nix`, `programs.nix`). 
- I find this much more intuitive than thematic naming. 
- If I need to change a service setting, I know exactly where it is: in `services.nix`. No need to remember which "theme" or "sub-category" I tucked it into.

> [!NOTE]
> The exception to this rule is **Home Manager**. Since HM modules often involve long and complex configurations for specific tools, I split them by the **program or service name** (e.g., `alacritty.nix`, `zsh.nix`). This makes them far easier to read and maintain individually.

## Final Words

I strive to keep this configuration as simple as possible. It’s a living project that evolves with my needs. I hope you found something useful here to "yank" into your own setup.

Happy Nixing! ❤️
