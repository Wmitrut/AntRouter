#INICIO DA CLASSE ANT TSP QUE APLICA O ACO AO PROBLEMA DO TSP

class AntTsp

  def initialize
    # new trail deposit coefficient
    @Q = 500
    # Algorithm parameters:
    # original amount of trail
    @c = 1.0
    # trail preference
    @alpha = 1
    # greedy preference
    @beta = 5
    # trail evaporation coefficient
    @evaporation = 0.5
    # number of ants used = numAntFactor*numTowns
    @numAntFactor = 0.8
    # probability of pure random selection of the next town
    @pr = 0.01

    # Reasonable number of iterations
    # - results typically settle down by 500
    @maxIterations = 10000

    @n = 0 # # towns
    @m = 0 # # ants
    @points = [] # bidimensional
    @trails = [] # bidimensional
    @ants = []
    @rand = Random.new()
    @probs = []

    @currentIndex = 0

    @bestTour = nil
    @bestTourLength = 10000000
  end

  # Read in graph from a file.
  # Allocates all memory.
  # Adds 1 to edge lengths to ensure no zero length edges.
  def readGraph(turn, going)
    @going = going
    @points = []
    @start_point = Startpoint.first
    if (turn.to_sym == :morning)
      turns = Turn.morning
      students = Student.morning
    elsif (turn.to_sym == :evening)
      turns = Turn.evening
      students = Student.evening
    else
      turns = Turn.night
      students = Student.night
    end
    2.times do |i|
      turns.each do |turn|
        @points << turn
      end
    end
    students.each do |student|
      @points << student
    end

    @n = @points.size
    puts "n=#{@n}"
    @m = (@n * @numAntFactor).to_i

    # all memory allocations done here
    @trails = []
    @probs = []
    @ants = []
    [0 ... @m].each do |j|
      @ants[j] = Ant.new(@points, @n, @start_point)
    end
    @points
  end

  def pow (a, b)
    a ** b
  end

  # Store in probs array the probability of moving to each town
  # [1] describes how these are calculated.
  # In short: ants like to follow stronger and shorter trails more.
  def probTo(ant)
    i = ant.tour[@currentIndex]

    denom = 0.0
    (0 ... @n).each do |l|
      if (!ant.visited(l))
        #puts "#{i}, #{l} = #{@graph[i][l]}"
        d = ant.distance(i, l)
        denom += pow(@trails[i][l], @alpha) * pow(1.0 / d, @beta)
      end
    end

    (0 ... @n).each do |j|
      if (ant.visited(j))
        @probs[j] = 0.0
      else
        d = ant.distance(i, j)
        numerator = pow(@trails[i][j], @alpha) * pow(1.0 / d, @beta)
        @probs[j] = numerator / denom
      end
    end
  end

  # Given an ant select the next town based on the probabilities
  # we assign to each town. With pr probability chooses
  # totally randomly (taking into account tabu list).
  def selectNextPoint(ant)
    # sometimes just randomly select
    if (@rand.rand < @pr)
      t = @rand.rand(@n - @currentIndex).to_i # random town
      j = -1
      (0 ... @n).each do |i|
        if (!ant.visited(i))
          j += 1
        end
        if (j == t)
          return i
        end
      end
    end
    # calculate probabilities for each town (stored in probs)
    probTo(ant)
    # randomly select according to probs
    r = @rand.rand
    tot = 0
    (0 ... @n).each do |j|
      (0 ... @n).each do |i|
        tot += @probs[i]
        if (tot >= r)
          return i
        end
      end
    end
    #puts "Not supposed to get here."
    while (true)
      i = @rand.rand(@n)
      if (!ant.visited(i))
        return i
      end
    end
  end

  # Update trails based on ants tours
  def updateTrails()
    # evaporation
    return if (@n <= 0)

    (0 ... @n).each do |i|
      (0 ... @n).each do |j|
        @trails[i][j] *= @evaporation
      end
    end

    # each ants contribution
    @ants.each do |a|
      contribution = @Q / a.tourLength()
      (0 ... @n - 1).each do |i|
        @trails[a.tour[i]][a.tour[i + 1]] += contribution
      end
      @trails[a.tour[@n - 1]][a.tour[0]] += contribution
    end
  end

  # Choose the next town for all ants
  def moveAnts()
    # each ant follows trails ... .
    while (@currentIndex < @n - 1)
      @ants.each do |a|
        a.visitPoint(selectNextPoint(a), @currentIndex)
      end
      @currentIndex += 1
    end
    @ants.each do |a|
      if @going
        a.arrangeSchoolByArrive
        a.arrangeStudentsBeforeSchool
      else
        a.arrangeSchoolByDeparture
        a.arrangeStudentsAfterSchool
      end
    end

  end

  # m ants with random start city
  def setupAnts()
    @currentIndex = -1
    @ants.each do |a|
      a.clear() # faster than fresh allocations.
      a.visitPoint((@rand.rand * @n).to_i, @currentIndex)
    end
    @currentIndex += 1
  end

  def updateBest()
    @ants.each do |a|
      if (@bestTourLength.nil? or a.tourLength() < @bestTourLength)
        @bestTourLength = a.tourLength()
        @bestTour = a.tour.dup()
      end
    end
  end

  def tourToString(tour)
    t = ""
    if tour
      tour.each do |i|
        t = t + " #{i}"
      end
    end
    return t
  end

  def solve()
    # clear trails
    (0 ... @n).each do |i|
      @trails[i] ||= []
      (0 ... @n).each do |j|
        @trails[i][j] = @c
      end
    end

    iteration = 0
    # run for maxIterations
    # preserve best tour
    while (iteration < @maxIterations)
      setupAnts()
      moveAnts()
      updateTrails()
      updateBest()
      iteration += 1
    end
    # Subtract n because we added one to edges on load
    puts ("Best tour length: #{(@bestTourLength)}")
    puts("Best tour: #{tourToString(@bestTour)}")
    #return @bestTour.dup()
    route = "'#{@start_point.address.latitude},#{@start_point.address.longitude}'/"
    @bestTour.each do |i|
      route += "'#{@points[i].address.latitude},#{@points[i].address.longitude}'/"
    end
    route += "'#{@start_point.address.latitude},#{@start_point.address.longitude}'"
    routeString = @bestTour.collect do |i|
      "#{@points[i].name} = #{@points[i].address.latitude},#{@points[i].address.longitude} #{"T:" + @points[i].arrival rescue nil}"
    end.join("<br/>")
    return "#{@bestTour}<br/>#{routeString}<br/> = #{@bestTourLength} - <a href=\"https://www.google.com/maps/dir/#{route}\">abrir rota<a>".html_safe
  end

end
