require_relative 'auto_menu'

def hash_menu
  [
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
end

def config
  {
    clear_screen: true,
    display_title: true,
    display_title_history: true,
    display_app_name: true,
    app_name: 'Wellcome to My App'
  }
end

def main
  menu = AutoMenu.new(hash_menu, config)

  loop do
    selection = menu.ask

    puts "You selected: #{selection}"

    menu.pause

    break if menu.exit?
  end
end

main
