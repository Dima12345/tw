require 'pry'

class Rover
	attr_accessor :size, :start, :route, :answer

	def change_route(orient, route, y, x)
		case route
		when 'l'
			case orient
			when 'w'
				orient = 's'
			when 'n'
				orient = 'w'
			when 'e'
				orient = 'n'
			when 's'
				orient = 'e'
			end
		when 'r'
		  	case orient
			when 'w'
				orient = 'n'
			when 'n'
				orient = 'e'
			when 'e'
				orient = 's'
			when 's'
				orient = 'w'
			end
		when 'm'
			case orient
			when 'w'
				x = x - 1
			when 'n'
				y = y + 1
			when 'e'
				x = x + 1
			when 's'
				y = y - 1
				# binding.pry
			end
		else
		  return "it was something else"
		end
		return [orient, y, x]
	end

	def on_plateau?(oy, ox, coord_y, coord_x)
		if oy < 0 || coord_y > oy || coord_y < 0
			return false
		elsif ox < 0 || coord_x > ox || coord_x < 0
			return false
		else
			return true
		end
	end

	def go
		if size == size[/[0-9]{1,}[ \f\n\r\t\v]{1}[0-9]{1,}/]
			if start == start[/[0-9]{1,}[ \f\n\r\t\v]{1}[0-9]{1,}[ \f\n\r\t\v]{1}[w|e|s|n]{1}/]
				if route == route[/[l|r|m]{1,}/]
					oy = size.split[0].to_i
					ox = size.split[1].to_i
					coord_y =  start.split[0].to_i
					coord_x =  start.split[1].to_i
					orientation = start.split[2]

					unless on_plateau?(oy, ox, coord_y, coord_x)
						puts "Rover out of plateau"
					else
						route.split(//).each do |letter|	
							new_data = change_route(orientation, letter, coord_y, coord_x)
							coord_y = new_data[1]
							coord_x = new_data[2]
							orientation = new_data[0]
							unless on_plateau?(oy, ox, coord_y, coord_x)
								@answer = "Rover out of plateau"
								return @answer
							end
						end
						@answer = "#{coord_y} #{coord_x} #{orientation}"
					end
				else
					puts 'unknow format of start coordinates'
				end
			else
				puts 'unknow format of start coordinates'
			end
		else
			puts 'unknow format of size'
		end
	end
end

rover = Rover.new
puts 'input size in format \'y x\''
rover.size = gets.chomp
puts 'input start coordinates and orientation in format \'"w", "s", "n", or "e"\''
rover.start = gets.chomp
puts 'input routes in format \'"l", "r", and "m"\''
rover.route = gets.chomp
rover.go
puts rover.answer