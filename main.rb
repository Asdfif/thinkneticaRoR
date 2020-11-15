# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'
require './modules/instance-counter'
require './modules/company-name'


class Interface
  attr_reader :trains, :stations, :routes, :wagons

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
    @wagons = {}
  end

  def menu
    menu_list
    loop do
      case gets.chomp
      when '1'
        create_an_object
      when '2'
        control_menu
      when '3'
        stations_list
      when '4'
        info
      when '5'
        abort
      else
        puts 'неопознанна команда'
        return menu
      end
    end
  end

  private

  def menu_list
    puts ''
    puts 'ГЛАВНОЕ МЕНЮ'
    puts '1 - Создать объект (Станцию, Маршрут, Поезд или Вагон)' #+
    puts '2 - Управление объектом'
    puts '3 - Список станций'
    puts '4 - info'
    puts '5 - Выход из программы'
  end

  def stations_list
    if @stations.empty?
      puts 'Нет станций'
      menu
    else
      stations = @stations.values
      stations.each { |station| puts station.name }
      menu
    end
  end

  def info
    puts '@stations:', @stations
    puts '@routes:', @routes
    puts '@trains:', @trains
    puts '@wagons:', @wagons
    menu
  end

  def create_an_object_list
    puts ''
    puts 'МЕНЮ СОЗДАНИЯ ОБЪЕКТА'
    puts '1 - Создать Станцию'
    puts '2 - Создать Маршрут'
    puts '3 - Создать Поезд'
    puts '4 - создать Вагон'
    puts '5 - Вернуться в главное меню'
  end

  def create_an_object
    loop do
      create_an_object_list
      choice = gets.chomp
      case choice
      when '1'
        create_a_station
      when '2'
        can_create_a_route?
      when '3'
        type_of_train_or_wagon(choice)
      when '4'
        type_of_train_or_wagon(choice)
      when '5'
        menu
        break
      else
        puts 'неопознанная команда'
      end
    end
  end

  def can_create_a_route?
    if @stations.size >= 2
      create_a_route
    else
      puts ''
      puts 'Недостаточное количество станций для создания маршрута'
      create_an_object
    end
  end

  def create_a_station
    puts 'Введите название станции'
    name = gets.chomp
    while stations.keys.include?(name)
      puts 'Станция с таким именем уже существует'
      name = gets.chomp
    end
    stations.merge!({ name => Station.new(name) })
    create_an_object
  end

  def search_a_station
    name = gets.chomp
    if @stations.key?(name)
      @stations[name]
    else
      false
    end
  end

  def create_first_station_of_route
    puts 'Введите название первой станции'
    station_one = search_a_station
    loop do
      break unless station_one == false

      puts 'Станции не существует, попробуйте заново'
      station_one = search_a_station
    end
    station_one
  end

  def create_last_station_of_route
    station_one = create_first_station_of_route
    puts 'Введите название второй станции'
    station_two = search_a_station
    loop do
      break unless station_two == false || station_two == station_one

      puts 'Невозможно выбрать такую станцию, попробуйте заново'
      station_two = search_a_station
    end
    [station_one, station_two]
  end

  def create_a_route
    terminal_stations = create_last_station_of_route
    station_one = terminal_stations[0]
    station_two = terminal_stations[1]
    puts 'Введите название маршрута'
    new_route_name = gets.chomp
    if @routes.include?(new_route_name)
      puts 'Маршрут с таким названием существует'
      nil
    else
      @routes.merge!({ new_route_name => Route.new(station_one, station_two) })
    end
  end

  def types_list
    puts ''
    puts 'Выберете тип:'
    puts '1 - Грузовой'
    puts '2 - Пассажирский'
  end

  def type_of_train_or_wagon(choice)
    loop do
      types_list
      type = gets.chomp
      if [false, '1', '2'].include?(type)
        if choice == '3'
          create_train(type)
          break
        else
          create_wagon(type)
          break
        end
      else
        puts 'неопознанная команда'
      end
    end
  end

  def create_train(type)
    puts 'Введите название поезда'
    name = gets.chomp
    while trains.keys.include?(name)
      puts 'Поезд с таким названием уже существует'
      name = gets.chomp
    end
    if type == '1'
      trains.merge!({ name => CargoTrain.new(name) })
      company(name, 'train')
    else
      trains.merge!({ name => PassengerTrain.new(name) })
      company(name, 'train')
    end
  end

  def company(name, type)
    puts 'Введите название компании'
    case 
    when type == 'train'
      trains[name].set_company
    when type == 'wagon'
      wagons[name].set_company
    end
  end

  def create_wagon(type)
    puts 'Введите номер вагона'
    number = gets.chomp
    while wagons.keys.include?(number)
      puts 'Вагон с таким номером уже существует'
      number = gets.chomp
    end
    if type == '1'
      wagons.merge!({ number => CargoWagon.new(number) })
      company(number, 'wagon')
    else
      wagons.merge!({ number => PassengerWagon.new(number) })
      company(number, 'wagon')
    end
  end

  def routes_is_empty?
    if @routes.empty?
      puts 'Сначала создайте маршрут'
      control_menu
    else
      route_menu
    end
  end

  def trains_is_empty?
    if @trains.empty?
      puts 'Сначала создайте поезд'
      control_menu
    else
      train_menu
    end
  end

  def control_menu_list
    puts ''
    puts 'МЕНЮ УПРАВЛЕНИЯ ОБЪЕКТАМИ'
    puts '1 - Операции с маршрутом'
    puts '2 - Операции с поездом'
    puts '3 - Смотреть поезда на станции'
    puts '4 - Вернуться в главное меню'
  end

  def control_menu
    loop do
      control_menu_list
      case gets.chomp
      when '1'
        routes_is_empty?
      when '2'
        trains_is_empty?
      when '3'
        if @stations.empty?
          puts 'Сначала создайте станцию'
          return control_menu
        else
          trains_on_station
        end
      when '4'
        menu
        break
      else
        puts 'неопознанная команда'
      end
    end
  end

  def trains_on_station
    puts 'Введите название станции'
    station_name = gets.chomp
    station = @stations[station_name]
    station.trains.each { |train| puts train.name }
    control_menu
  end

  def route_menu_list
    puts ''
    puts "ОПЕРАЦИИ С МАРШРУТОМ #{@routes.key(route)}"
    puts '1 - Добавить станцию в маршрут'
    puts '2 - Удалить станцию с маршрута'
    puts '3 - Вернуться в меню управления'
  end

  def route_menu
    puts 'Введите название маршрута'
    route = select_a_route
    if route
      loop do
        route_menu_list
        case gets.chomp
        when '1'
          add_station_to_route(route)
        when '2'
          remove_station_from_route(route)
        when '3'
          control_menu
        else
          puts 'неопознанная команда'
        end
      end
    else
      puts 'Маршрута с такими именем не существует'
      control_menu
    end
  end

  def add_station_to_route(route)
    loop do
      puts 'Введите название станции'
      station = search_a_station
      if station
        route.add_station(station)
        break
      end
    end
    route_menu
  end

  def remove_station_from_route(route)
    loop do
      puts 'Введите название станции'
      station = search_a_station
      if station
        route.remove_station(station)
        break
      end
    end
    route_menu
  end

  def select_a_route
    name = gets.chomp
    if @routes.key?(name)
      @routes[name]
    else
      false
    end
  end

  def train_menu_list(train)
    puts ''
    puts "ОПЕРАЦИИ С ПОЕЗДОМ #{@trains.key(train)}"
    puts '1 - Назначить маршрут'
    puts '2 - Прицепить вагон'
    puts '3 - Отцепить вагон'
    puts '4 - Переместить поезд на следующую станцию'
    puts '5 - Переместить поезд на предыдущую станцию'
    puts '6 - Вернуться в меню управления объектами'
  end

  def route_selection(train)
    puts 'Введите название маршрута'
    route = select_a_route
    if route
      train.set_route(route)
    else
      puts 'Маршрут не существует'
      train_menu
    end
  end

  def wagon_hook_or_unhook(choice, train)
    if choice == '2'
      puts 'Введите номер вагона'
      wagon = @wagons[gets.chomp]
      train.hook_wagon(wagon)
    else
      train.unhook_wagon
    end
  end

  def train_menu
    train = select_a_train
    if train
      loop do
        train_menu_list(train)
        choice = gets.chomp
        case choice
        when '1'
          route_selection(train)
        when '2'
          wagon_hook_or_unhook(choice, train)
        when '3'
          wagon_hook_or_unhook(choice, train)
        when '4'
          train.forward
        when '5'
          train.back
        when '6'
          control_menu
        else
          puts 'неопознанная команда'
        end
      end
    else
      puts 'поезда с такими именем не существует'
      control_menu
    end
  end

  def select_a_train
    puts 'Введите имя поезда'
    name = gets.chomp
    Train.find(name)
  end
end
