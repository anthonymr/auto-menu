# @author Anthony Martin
# @version 0.1.0
# @since 2023-04-28
# @see https://github.com/anthonymr/auto-menu


class AutoMenu
  # Class constructor
  #
  # @param array_menu [array] an array of hashes with the menu options
  # @param config [hash] a hash with the configuration options
  # @option config [boolean] :clear_screen (true) clear the screen before print the menu
  # @option config [boolean] :display_title (true) display the title of the menu
  # @option config [boolean] :display_title_history (true) display the title of the menu history
  # @option config [boolean] :display_app_name (true) display the app name
  # @option config [string] :app_name ('Wellcome!') the app name
  # @return [AutoMenu] a new instance of AutoMenu
  def initialize(array_menu, config = {})
    @array_menu = array_menu
    @selected_option = 0
    @back_menues = []

    @clear_screen = config.key?(:clear_screen) ? config[:clear_screen] : true
    @display_title = config.key?(:display_title) ? config[:display_title] : true
    @display_title_history = config.key?(:display_title_history) ? config[:display_title_history] : true
    @display_app_name = config.key?(:display_app_name) ? config[:display_app_name] : true
    @app_name = config.key?(:app_name) ? config[:app_name] : 'Wellcome!'
  end

  # Ask the user for an option
  #
  # @param array_menu [array] an array of hashes with the menu options
  # @return [string] the option selected by the user
  def ask(array_menu = @array_menu)
    clear_screen
    print_app_name
    print_title(array_menu)
    print_menu(array_menu)

    @selected_option = gets.chomp.to_i - 1

    evaluate_option(array_menu)
  end

  # Pause the execution of the program until the user press enter
  #
  # @param message [string] the message to display before pause
  # @return [void]
  def pause(message = 'Press enter to continue...')
    puts message
    gets
    clear_screen
  end

  # Evaluate if the user selected the exit option
  #
  # @return [boolean] true if the user selected the exit option, false otherwise
  def exit?
    @selected_option == -1
  end

  private

  # Recursively evaluate if the option selected by the user is valid and move through menus
  #
  # @param array_menu [array] an array of hashes with the menu options
  # @return [string] the option selected by the user
  def evaluate_option(array_menu)
    if array_menu.empty? || exit?
      clear_screen
      'exit'
    elsif !valid_option?(@selected_option, array_menu)
      pause('Invalid option, press enter to continue...')
      ask(array_menu)
    elsif @selected_option == array_menu.length
      ask(@back_menues.pop)
    elsif array_menu[@selected_option][:value].instance_of?(Array)
      @back_menues << array_menu
      ask(array_menu[@selected_option][:value])
    elsif @selected_option > -1
      clear_screen
      array_menu[@selected_option][:value]
    end
  end

  # Print the menu options
  #
  # @param array_menu [array] an array of hashes with the menu options
  # @return [void]
  def print_menu(array_menu)
    array_menu.each_with_index do |option, index|
      next unless option.key?(:key) && option.key?(:value)

      puts "#{index + 1}) #{option[:key]}"
    end

    puts "#{array_menu.length + 1}) Back" unless @back_menues.empty?
    puts "0) Exit \n\n"
    print 'Choose an option: '
  end

  # Print the title of the menu from the :title key of the first element of the array_menu
  #
  # @param array_menu [array] an array of hashes with the menu options
  # @return [void]
  def print_title(array_menu)
    return unless array_menu[0][:title] && @display_title

    if @display_title_history
      titles = @back_menues.reduce('') do |title, menu|
        title + "#{menu[0][:title]} > "
      end

      print titles unless titles.empty?
    end

    puts "#{array_menu[0][:title]}\n\n"
  end

  # Print the app name if the :display_app_name option is true
  #
  # @return [void]
  def print_app_name
    puts "#{@app_name}\n\n" if @display_app_name
  end

  # Clear the screen if the :clear_screen option is true
  #
  # @return [void]
  def clear_screen
    system('cls') || system('clear') if @clear_screen
  end

  # Evaluate if the option selected by the user is valid
  #
  # @param option [integer] the option selected by the user
  # @param array_menu [array] an array of hashes with the menu options
  # @return [boolean] true if the option selected by the user is valid, false otherwise
  def valid_option?(option, array_menu)
    return true if option == -1 || option == array_menu.length
    return false unless array_menu[option]&.key?(:value) && array_menu[option]&.key?(:key)

    option.between?(0, array_menu.length - 1)
  end
end
