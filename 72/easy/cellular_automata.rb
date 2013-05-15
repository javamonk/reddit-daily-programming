#!/usr/bin/ruby

require 'pp'

# [7/4/2012] Challenge #72 [easy] (self.dailyprogrammer)
# The one-dimensional simple cellular automata Rule 110 is the only such 
# cellular automata currently known to be turing-complete, and many people 
# say it is the simplest known turing-complete system.
# Implement a program capable of outputting an ascii-art representation of 
# applying Rule 110 to some initial state. How many iterations and what your 
# initial state is is up to you!
# You may chose to implement rule 124 instead if you like (which is the same 
# thing, albeit backwards).
# Bonus points if your program can take an arbitrary rule integer from 0-255 
# as input and run that rule instead!

@initial_state = '000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000'
@num_generations = 40
@rule_wolfram_code = 30
@off_symbol = ' '
@on_symbol = 'x'

# Generates the rull set based on the provided wolfram code
def get_rules( wolfram_code )
    # Convert the wolfram code to binary array
    rule_values = wolfram_code.to_s(2).rjust(8,'0').split(//)

    puts rule_values

    # populate the rules hash
    rules = {}
    for i in 0..7 do
        rules[ i.to_s(2).rjust(3,'0') ] = rule_values[7-i]
    end

    return rules
end

# Returns the next generation, given the current generation and the rules to be applied
def get_next_generation( current_generation, rules )
    # Pad the current generation with a single off state on either side
    current_generation = '0' + current_generation + '0'
    
    next_generation = ''

    # Iterate over each state and its 2 immidiate neighbours
    for i in 1..( current_generation.length-2 )
        next_generation += rules[current_generation[ ( i-1 )..( i+1 ) ]]
    end

    return next_generation
end

# Displays the cellular automata results for the given initial state, rules and number of generations
def display_cellular_automata( initial_state, rules, num_generations )
    current_state = initial_state

    for i in 0..num_generations
        puts current_state.gsub( '0', @off_symbol ).gsub( '1', @on_symbol )
        current_state = get_next_generation( current_state, rules)
    end
end

puts "One dimensional Cellular automata"

# Get the rules
rules = get_rules( @rule_wolfram_code );
pp rules

display_cellular_automata( @initial_state, rules, @num_generations )
