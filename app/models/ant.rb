#INICIO DA CLASSE ANT, QUE DEFINE OS PARAMETROS DAS FORMIGAS
class Ant
  attr_accessor :tour
  def initialize(points, n)
    @points = points
    @n = n
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
  def arrangeSchoolByTime

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
          if school.is_a? School
            if school.id == student_school.id
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

  # Posiciona o aluno DEPOIS da escola
  def arrangeStudentsAfterSchool
    @tour.size.times do |i|
      point = @points[@tour[i]]
      if point.is_a? Student
        student_school = point.school
        new_position = -1
        @tour.each_with_index do |s, j|
          school = @points[s]
          if school.is_a? School
            if school.id == student_school.id
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
    ponto_a = @points[a].address
    ponto_b = @points[b].address
    x = ponto_a.latitude - ponto_b.latitude
    y = ponto_a.longitude - ponto_b.longitude
    return Math.sqrt((x*x) + (y*y))
  end

  def tourLength()
    if (@n <= 0)
      return 1000000
    end
    length = distance(@tour[@n - 1], @tour[0])
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

#FINAL DA CLASSE ANT, QUE DEFINE OS PARAMETROS DAS FORMIGAS
