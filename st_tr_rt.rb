class Station

	attr_accessor :trains , :name, :type
	def initialize(name)
		@name = name
		@trains = []
	end

	def show_all_trains
		@trains.each { |train| }
		end

	def show_type_trains(type)
		@trains.each do |train| 
			if train.type == type
			train.name
			end 
		end
	end	

	def send_train(train)
		@trains.delete(train)
	end	
end

class Route

	attr_accessor  :stations
	def initialize(first, terminal)
		@stations = [first, terminal]
	end

	def add_station(station)
		unless @stations.include?(station)
		@stations.insert(-2, station)
		end
	end

	def remove_station(station)
		if @stations.include?(station) && station != @stations[0] && station != @stations[-1]
			@stations.delete(station)
		end
	end

	def show_all_stations
		@stations.each { |station| station.name}
	end
end

class Train

	attr_accessor :name , :type, :stations, :route
	def initialize(name, type, vagons = 0)
		@name = name
		@type = type
		@vagons = vagons
		@current_speed = 0
	end

	def faster (speed)
		@current_speed += speed
		@current_speed
	end
	
	def slower (speed)
		@current_speed -= speed
		if @current_speed <= 0
			@current_speed =0
		end
		@current_speed
	end
	
	def vagons
		@vagons
	end

	def add_vagon
		if @current_speed == 0
			@vagons += 1
		end
	end

	def del_vagon
		if @current_speed == 0 && @vagons >= 1
			@vagons -= 1
		end
	end

	def speed
		@current_speed
	end

	def set_route(route)
		@route = route
		@current_station = route.stations[0]
		@route.stations[0].trains << self
		end

	def forward 
		i = @route.stations.index(@current_station)
		if  i < (@route.stations.size - 1)
			@current_station = @route.stations[i += 1]
			@route.stations[i].trains << self
			@route.stations[i-1].trains.delete(self)
			@current_station.name
		end
	end

	def back 
		i = @route.stations.index(@current_station)
		if  i > 0
			@current_station = @route.stations[i -= 1]
			@route.stations[i].trains << self
			@route.stations[i+1].trains.delete(self)
			@current_station.name
		end
	end

	def current_station
		@current_station.name
	end
end