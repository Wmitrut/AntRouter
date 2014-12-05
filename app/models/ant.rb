#INICIO DA CLASSE ANT, QUE DEFINE OS PARAMETROS DAS FORMIGAS
class Ant
  attr_accessor :tour
  def initialize(points, n, start_point)
    @points = points
    @n = n
    @start_point = start_point
    @tour = []
    # Maintain visited list for towns, much faster
    # than checking if in tour so far.
    @visited = []
  end

  def visitPoint(point, currentIndex)
    @tour[currentIndex + 1] = point
    @visited[point] = true
  end
#INÍCIO DOS ORDENADORES DE ROTA E PRIORIZAÇÃO--------------------------------------------------------------------

#Posiciona Escola por horário
  def arrangeSchoolByArrive
    @tour.size.times do |i|
      point = @points[@tour[i]]
      if point.is_a? Turn
        current_school = point
        old_position = -1
        @tour.each_with_index do |s, j|
          school = @points[s]
          break if (j >= i)
          if school.is_a? Turn and school != current_school
            if current_school.arrival < school.arrival
              old_position = j
              break
            end
          end
        end
        if old_position >= 0 and old_position < i
          @tour.insert(i, @tour.delete_at(old_position))
        end
      end
    end
  end

  #Posiciona Escola por horário
    def arrangeSchoolByDeparture
      @tour.size.times do |i|
        point = @points[@tour[i]]
        if point.is_a? Turn
          current_school = point
          old_position = -1
          @tour.each_with_index do |s, j|
            school = @points[s]
            break if (j >= i)
            if school.is_a? Turn and school != current_school
              if current_school.departure < school.departure
                old_position = j
                break
              end
            end
          end
          if old_position >= 0 and old_position < i
            @tour.insert(i, @tour.delete_at(old_position))
          end
        end
      end
    end
# Posiciona o aluno ANTES da escola
  def arrangeStudentsBeforeSchool
    @tour.size.times do |i|
      point = @points[@tour[i]]
      if point.is_a? Student
        student_school = point.school
        new_position = -1
        @tour.reverse.each_with_index do |s, j|
          school = @points[s]
          if school.is_a? Turn
            if school.school.id == student_school.id
              new_position = @tour.size - j - 1
              break;
            end
          end
        end
        if new_position >= 0 and new_position < i
          @tour.insert(new_position, @tour.delete_at(i))
        end
      end
    end
  end


  # Posiciona o aluno DEPOIS da escola
  def arrangeStudentsAfterSchool
    @tour.size.times do |i|
      point = @points[@tour[i]]
      if point.is_a? Student
        student_school = point.school
        new_position = -1
        @tour.each_with_index do |s, j|
          school = @points[s]
          if school.is_a? Turn
            if school.school.id == student_school.id
              new_position = j
              break;
            end
          end
        end
        if new_position >= 0 and new_position > i
          @tour.insert(new_position, @tour.delete_at(i))
        end
      end
    end
  end

#Exclui pontos desnecessários
#
#  def excludeUnnecessaryPoints
#    @tour.size.times do |i|
#      point = @points[@tour[i]]
#  end

#FINAL DOS ORDENADORES DE ROTA E PRIORIZAÇÃO--------------------------------------------------------------------

  def movePoint(from, to)
    @tour[currentIndex + 1] = point
  end

  def visited(i)
    return @visited[i]
  end

  def distance(a, b)
    if (a.nil? or b.nil?)
      puts "ERRO: Sem pontos para calcular dist"
      return 1000000
    end
    if (a == :start_point)
      ponto_a = @start_point.address
    else
      ponto_a = @points[a].address
    end
    ponto_b = @points[b].address
    #x = ponto_a.latitude - ponto_b.latitude
    #y = ponto_a.longitude - ponto_b.longitude
    #return Math.sqrt((x*x) + (y*y))
    lat1 = ponto_a.latitude
    radianLat1 = lat1 * (Math::PI / 180.0)
    lng1 = ponto_a.longitude
    radianLng1 = lng1 * (Math::PI / 180.0)
    lat2 = ponto_b.latitude
    radianLat2 = lat2 * (Math::PI / 180.0)
    lng2 = ponto_b.longitude
    radianLng2 = lng2 * (Math::PI / 180.0)
    earth_radius = 6371.0 #kilometers
    diffLat = (radianLat1 - radianLat2)
    diffLng = (radianLng1 - radianLng2)
    sinLat = Math.sin(diffLat / 2.0)
    sinLng = Math.sin(diffLng / 2.0)
    a = (sinLat ** 2.0) + Math.cos(radianLat1) * Math.cos(radianLat2) * (sinLng ** 2.0)
    distance = earth_radius * 2.0 * Math.asin([1, Math.sqrt(a)].min)
    return distance
  end

  def tourLength()
    if (@n <= 0)
      return 1000000
    end
    length = distance(:start_point, @tour[0]) + distance(:start_point, @tour[@n - 1])
    (0 ... @n - 1).each do |i|
      #puts "#{@tour[i]},#{@tour[i + 1]} = @graph[@tour[i]][@tour[i + 1]]"
      length += distance(@tour[i], @tour[i + 1])
    end
    #puts "tourLength #{length}"
    return length
  end

  def clear()
    @visited = []
  end
end
