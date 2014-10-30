
# Ant class. Maintains tour and tabu information.
class Ant
        attr_accessor :tour
        def initialize(graph, n)
          @graph = graph
          @n = n
	  @tour = []
	  # Maintain visited list for towns, much faster
	  # than checking if in tour so far.
	  @visited = []
        end

	def visitPoint(town, currentIndex)
	    @tour[currentIndex + 1] = town
	    @visited[town] = true
	end

	def visited(i)
	    return @visited[i]
	end

	def tourLength()
	    length = @graph[@tour[@n - 1]][@tour[0]]
	    (0 .. @n - 2).each do |i| # FIXME -1 ?
                #puts "#{@tour[i]},#{@tour[i + 1]} = @graph[@tour[i]][@tour[i + 1]]"
		length += @graph[@tour[i]][@tour[i + 1]]
	    end
            #puts "tourLength #{length}"
	    return length
	end

	def clear()
	    (0 .. @n).each do |i|
		@visited[i] = false
            end
	end
end

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
	    @maxIterations = 2000

	    @n = 0 # # towns
	    @m = 0 # # ants
	    @graph = [] # bidimensional
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
    def readGraph(path)
        i = 0
        puts "lendo #{path}"
        File.readlines(path).each do |line|
            split = line.split(/[\s,;]+/)

            @graph ||= []
            j = 0

            split.each do |s|
                if (!s.empty?)
	            @graph[i] ||= []
                    @graph[i][j] = s.to_f + 1
                    j += 1
                end
            end

            i += 1
        end

        @n = i - 1 # FIXME:
        @m = (@n * @numAntFactor).to_i

        # all memory allocations done here
        @trails = []
        @probs = []
        @ants = []
        [0 .. @m].each do |j|
            @ants[j] = Ant.new(@graph, @n)
        end
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
        (0..@n).each do |l|
            if (!ant.visited(l))
                #puts "#{i}, #{l} = #{@graph[i][l]}"
                denom += pow(@trails[i][l], alpha) * pow(1.0 / @graph[i][l], beta)
            end
        end


        (0..n).each do |j|
            if (ant.visited(j))
                @probs[j] = 0.0
            else
                numerator = pow(@trails[i][j], alpha) * pow(1.0 / @graph[i][j], beta)
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
            (0..n).each do |i|
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
        (0..n).each do |i|
            #puts "#{i} - #{@probs[i]}"
            tot += @probs[i]
            if (tot >= r)
                return i
            end
        end
	puts "Not supposed to get here."
	return 0
    end

    # Update trails based on ants tours
    def updateTrails()
        # evaporation
        (0..@n).each do |i|
            (0..@n).each do |j|
                @trails[i][j] *= @evaporation
            end
        end

        # each ants contribution
        @ants.each do |a|
            contribution = @Q / a.tourLength()
            (0..@n - 2).each do |i| # FIXME: -1?
                @trails[a.tour[i]][a.tour[i + 1]] += contribution
            end
            @trails[a.tour[n - 1]][a.tour[0]] += contribution
        end
    end

    # Choose the next town for all ants
    def moveAnts()
        # each ant follows trails...
        while (@currentIndex < @n - 1)
            @ants.each do |a|
                a.visitPoint(selectNextPoint(a), @currentIndex)
            end
            @currentIndex += 1
        end
    end

    # m ants with random start city
    def setupAnts()
        @currentIndex = -1
        @ants.each do |a|
            a.clear() # faster than fresh allocations.
            a.visitPoint((@rand.rand * n).to_i, @currentIndex)
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
        tour.each do |i|
            t = t + " #{i}"
        end
        return t
    end

    def solve()
        # clear trails
        (0..n).each do |i|
            @trails[i] ||= []
            (0..@n).each do |j|
                @trails[i][j] = c
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
        puts ("Best tour length: #{(@bestTourLength - n)}")
        puts("Best tour: #{tourToString(@bestTour)}")
        return @bestTour.dup()
    end

end

# Load graph file given on args[0].
# (Full adjacency matrix. Columns separated by spaces, rows by newlines.)
# Solve the TSP repeatedly for maxIterations
# printing best tour so far each time. 
def main(args)
	# Load in TSP data file.
	if (args.size < 1)
	    raise ("Please specify a TSP data file.")
	    return
	end
	anttsp = AntTsp.new()
        path = args[0]
        if (File.exist?(path))
		begin
		    anttsp.readGraph(path)
		rescue
		    raise ("Error reading graph. #{args}\n#{$!}\n\n - #{$@.join("\n - ")}")
		    return
		end
	else
          raise "arquivo nao existe"
        end

	# Repeatedly solve - will keep the best tour found.
	while (true)
	    anttsp.solve()
	end
end

#main(ARGV)
