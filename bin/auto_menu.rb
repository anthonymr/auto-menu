class AutoMenu
  def initialize(hash_menu, config = {})
    @hash_menu = hash_menu
    @selected_otion = 0
    @back_menues = []

    @clear_screen = config.key?(:clear_screen) ? config[:clear_screen] : true
    @display_title = config.key?(:display_title) ? config[:display_title] : true
    @display_title_history = config.key?(:display_title_history) ? config[:display_title_history] : true
    @display_app_name = config.key?(:display_app_name) ? config[:display_app_name] : true
    @app_name = config.key?(:app_name) ? config[:app_name] : 'Wellcome!'
  end

  def ask(hash_menu = @hash_menu)
    return 'exit' if hash_menu.empty?

    clear_screen
    print_app_name
    print_title(hash_menu)
    print_menu(hash_menu)

    @selected_otion = gets.chomp.to_i - 1

    evaluate_option(hash_menu)
  end

  def pause(message = 'Press enter to continue...')
    puts message
    gets
  end

  def exit?
    @selected_otion == -1
  end

  private

  def evaluate_option(hash_menu)
    if !valid_option?(@selected_otion, hash_menu)
      pause('Invalid option, press enter to continue...')
      ask(hash_menu)
    elsif @selected_otion == hash_menu.length
      ask(@back_menues.pop)
    elsif hash_menu[@selected_otion][:value].instance_of?(Array)
      @back_menues << hash_menu
      ask(hash_menu[@selected_otion][:value])
    elsif @selected_otion == -1
      clear_screen
      'exit'
    else
      clear_screen
      hash_menu[@selected_otion][:value]
    end
  end

  def print_menu(hash_menu)
    hash_menu.each_with_index do |option, index|
      puts "#{index + 1}) #{option[:key]}"
    end

    puts "#{hash_menu.length + 1}) Back" unless @back_menues.empty?
    puts "0) Exit \n\n"
    print 'Choose an option: '
  end

  def print_title(hash_menu)
    return unless hash_menu[0][:title] && @display_title

    if @display_title_history
      titles = @back_menues.reduce('') do |title, menu|
        title + "#{menu[0][:title]} > "
      end

      print titles unless titles.empty?
    end

    puts "#{hash_menu[0][:title]}\n\n"
  end

  def print_app_name
    puts "#{@app_name}\n\n" if @display_app_name
  end

  def clear_screen
    system('cls') || system('clear') if @clear_screen
  end

  def valid_option?(option, hash_menu)
    option.between?(-1, hash_menu.length)
  end
end
