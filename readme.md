# CommandBox Console Pretty

Simple module to draw bordered message boxes to the console (Supports emoji!!)

## Installation

```
CommandBox> install ConsolePretty
```

## Usage

```js
getInstance( "MessageBox@ConsolePretty" ).printMessageBox( message );
```


`ConsolePretty` is a threadsafe singleton and suitable for injection.  Inject the library like so:

```js
component {
  property name="ConsolePretty" inject="MessageBox@ConsolePretty;
  
  function run() {
    ConsolePretty.printMessageBox( ":unicorn_face:  Welcome to my pretty box  :unicorn_face:" )
  }
}
```
## Options
* `message`: String or array of strings to print inside the box.  Word wrapping is on by default.  If an array of strings, each item in the array will be a separate line (hint: even empty strings ).  Can use some emojis (depending on terminal shell support, but mostly these are good: https://gist.github.com/rxaviers/7360908)
* `border`: Character(s) to use to draw the box.  Defaults to ":fire:".  Can be pretty much any printable character supported by your terminal - results may vary.
* `color`: Color of text inside the box.  Defaults to "white" (For available color options run `box system-colors`)
* `borderColor`: Color of border characters.  Defaults to "red"
* `wordwrap`: If true, will wrap at 80 characters (or whatever `columns` is set to. Defaults to true.
* `columns`: Number of characters to print before wrapping. Defaults to 80.
* `textAlign`: Either "left" or "center" to align text. Defaults to "center"