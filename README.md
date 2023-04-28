# AutoMenu - CLI recursive menu generator
![Built with ruby](https://img.shields.io/badge/built%20with-ruby-red)
![Ruby version 3.1.1](https://img.shields.io/badge/ruby%20version-3.1.3-brightgreen)

AutoMenu is a CLI recursive menu generator built with Ruby.

## Main features
  1. Print the menu and wait for the user to select an option:
  2. Add recursive multi-level sub-menus and navigate between menus:
  3. Get user selected option:

## Usage
  1. Include `auto_menu.rb` file

```ruby
  require_relative 'auto_menu'
```

  2. Define the menu using an `array` of `hash`:
      - You can add as many levels as you want.
      - Each hash can have three keys:
        - key: [required] option displayed in the menu
        - value: [required] value returned when selected
        - title: [optional] the menu/sub-menu name, only valid in the first element

```ruby
  hash_menu = [
    { key: 'Option 1', title: 'Main menu', value: [
      { key: 'Option 1.1', title: 'Sub-menu 1', value: 'option_1_1' },
      { key: 'Option 1.2', value: [
        { key: 'Option 1.2.1', title: 'Sub-menu 1.2', value: 'option_1_2_1' },
        { key: 'Option 1.2.2', value: 'option_1_2_2' },
        { key: 'Option 1.2.3', value: 'option_1_2_3' }
      ] }
    ] },
    { key: 'Option 2', value: 'option_2' },
    { key: 'Option 3', value: 'option_3' },
    { key: 'Option 4', value: 'option_4' },
    { key: 'Option 5', value: 'option_5' },
    { key: 'Option 6', value: 'option_6' },
    { key: 'Option 7', value: 'option_7' },
    { key: 'Option 8', value: 'option_8' }
  ]
```
  3. Define configurations `hash` [optional]:

```ruby
  configurations = {
    clear_screen: true, # Default: true
    display_title: true, # Default: true
    display_title_history: true, # Default: true
    display_app_name: true, # Default: true
    app_name: 'Wellcome to My App' # Default: 'Wellcome!'
  }
```

  4. Put it all together using an AutoMenu object:

```ruby
  menu = AutoMenu.new(hash_menu, configurations)

  loop do
    selection = menu.ask #AutoMenu.ask: print menu  and return user selected option

    puts "You selected: #{selection}"

    menu.pause #AutoMenu.pause([message]): pause program excecution unitl user press enter

    break if menu.exit? #AutoMenu.exit?: evaluate if the user selected 'exit' option
  end
```
