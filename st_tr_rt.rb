class Station

	attr_accessor :trains , :name, :type
	def initialize(name)
		@name = name
		@trains = []
	end

	def show_all_trains
		@trains.each { |train| puts train.name}
		puts ''
	end

	def show_type_trains(type)
		@trains.each { |train| 
			if train.type == type
			puts train.name
			end }
		puts ''
	end	

	def send_train(train)
		puts "Куда отправить поезд? f/b?"
		q = gets.chomp
		if q == 'f'
			train.forward
			@trains.delete(train)
		elsif q == 'b'
			train.back
			@trains.delete(train)
		end
	end	
end

class Route

	attr_accessor  :stations
	def initialize(first, terminal)
		if first.class == Station && terminal.class == Station
			@stations = [first, terminal]
		end
	end

	def add_station(station)
		unless @stations.include?(*station)
		@stations.insert(-2, *station)
		puts ''
		end
	end

	def remove_station(station)
		station.trains.each { |trains| 
			if trains.route != self 
				if station != @stations[0] && station != @stations[-1]
				@stations.delete(station)
				else
					puts 'Нельзя удалить терминальные станции маршрута' 
				end
				puts ''
			else 
				puts 'Нельзя удалить станцию, поскльку поезд с этого маршрута пребывает на ней'
			end }
			puts ''
	end

	def show_all_stations
		@stations.each { |station| puts station.name}
		puts ''
	end
end

class Train

	attr_accessor :name , :type, :stations, :route
	def initialize(name, type, vagons = 0)
		@name = name
		@type = type
		@vagons = vagons
		@current_speed = 0
		@route = nil
		@current_station = nil
	end

	def faster (speed)
		@current_speed += speed
		puts "Текущая скорость - #{@current_speed}"
	end
	
	def slower (speed)
		@current_speed -= speed
		if @current_speed <= 0
			@current_speed =0
		end
		puts "Текущая скорость - #{@current_speed}"
	end
	
	def vagons; puts " Количество вагонов - #{@vagons}"; end

	def add_vagon
		if @current_speed == 0
			@vagons += 1
		else 
			puts "Снизьте скорость до нуля! А затем добавляйте вагоны!"
		end
	end

	def del_vagon
		if @current_speed == 0 && @vagons >= 1
			@vagons -= 1
		else 
			puts "Вагонов не оставлось!"
		end
	end

	def speed; puts "Текущая скорость - #{@current_speed}"; end

	def set_route(route)
		@route = route
		@current_station = route.stations[0]
		@route.stations[0].trains << self
		@route.stations.each { |station| puts station.name}
		puts ''
	end

	def forward 
		i = @route.stations.index(@current_station)
		if  i < (@route.stations.size - 1)
			@current_station = @route.stations[i += 1]
			@route.stations[i].trains << self
			@route.stations[i-1].trains.delete(self)
			
			puts @current_station.name
		else
			puts "Конечная станция"
		end
	end

	def back 
		i = @route.stations.index(@current_station)
		if  i > 0
			@current_station = @route.stations[i -= 1]
			@route.stations[i].trains << self
			@route.stations[i+1].trains.delete(self)
			puts @current_station.name
		else
			puts "Конечная станция"
		end
	end

	def current_station
		puts @current_station.name
	end
end