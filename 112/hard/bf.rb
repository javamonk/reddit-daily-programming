#!/usr/bin/ruby

# http://www.reddit.com/r/dailyprogrammer/comments/137f7h/11142012_challenge_112_difficultwhat_a_brainf/

# Initialize the machine state
@registers = Array.new(80) { |register| register=0 }
@data_ptr_index = 0

@tape = STDIN.read.chomp
@tape_head_index = 0

def output_register_state
    # Displays the position data_ptr_index
    for i in (1..@data_ptr_index)
        print "  "
    end
    puts 'V'
    
    @registers.each { |register|
        print register.to_s + " "
    }
    puts ""
end

def output_tape_state
    # Displays the position of the tape head
    for i in (1..@tape_head_index)
        print " "
    end
    puts 'V'
    
    # Display the instructions
    @tape.each{ |instruction|
        print instruction.to_s + " "
    }
    puts ""
end

def debug_output ( message )
    output_tape_state
    output_register_state
    puts message
    puts
end

# increment the data pointer (to point to the next cell to the right).
def increment_data_ptr  
    debug_output "Increment data pointer called"
    @data_ptr_index += 1
end

# decrement the data pointer (to point to the next cell to the left).
def decrement_data_ptr
    debug_output "Decrement data pointer called"
    @data_ptr_index -= 1
end

# increment (increase by one) the byte at the data pointer.
def increment_byte      
    debug_output "Increment byte"
    @registers[@data_ptr_index] += 1
end

# decrement (decrease by one) the byte at the data pointer.
def decrement_byte
    debug_output "Decrement byte"
    @registers[@data_ptr_index] -= 1
end

# output the byte at the data pointer as an ASCII encoded character.
def display_output 
    debug_output "Displaying output"
    print @registers[@data_ptr_index].chr
end

# accept one byte of input, storing its value in the byte at the data pointer.
def read_input
    debug_output "Reading input"
    @registers[@data_ptr_index] = STDIN.getc
end

# if the byte at the data pointer is zero, jump the data pointer forward to the command after the matching ] command*.
def start_loop
    # Check the value at the data pointer
    if ( @registers[@data_ptr_index] == 0 )
        debug_output "Jumping over loop, to matching ]"

        # Get the index of the matching ]
        @tape_head_index = find_matching_bracket_index( '[' )
    else 
        debug_output "Moving into loop"
    end
end

# if the byte at the data pointer is nonzero, jump the data pointer back to the command after the matching [ command*.
def end_loop
    # Check the value at the data pointer
    if ( @registers[@data_ptr_index] == 0 )
        debug_output "Finished looping - Continuing"
    else 
        debug_output "Jumping to begining of loop, to matching ["
        
        # Get the index of the matching ]
        @tape_head_index = find_matching_bracket_index( ']' )
    end
end

# Find the bracket which pairs with the given bracket to match
def find_matching_bracket_index ( bracket_to_match )
    # Determine which direction to match brackets
    
    direction = 1   # Move left to right (positive) by default
    opposite_bracket_to_match = ']'

    if ( bracket_to_match == ']' )
        direction = -1;
        opposite_bracket_to_match = '['
    end

    # count of branckets to match before returning
    bracket_count = 1;

    tmp_tape_head_index = @tape_head_index

    while ( bracket_count != 0 ) do
        tmp_tape_head_index += direction

        if ( @tape[ tmp_tape_head_index ].chr == bracket_to_match )
            bracket_count += 1;
        end
        
        if ( @tape[ tmp_tape_head_index ].chr == opposite_bracket_to_match )
            bracket_count -= 1;
        end
    end

    return tmp_tape_head_index
end

# Create an instruction to function map
instruction_function_map = {}
instruction_function_map['>'] = :increment_data_ptr  # increment the data pointer (to point to the next cell to the right).
instruction_function_map['<'] = :decrement_data_ptr  # decrement the data pointer (to point to the next cell to the left).
instruction_function_map['+'] = :increment_byte      # increment (increase by one) the byte at the data pointer.
instruction_function_map['-'] = :decrement_byte      # decrement (decrease by one) the byte at the data pointer.
instruction_function_map['.'] = :display_output      # output the byte at the data pointer as an ASCII encoded character.
instruction_function_map[','] = :read_input          # accept one byte of input, storing its value in the byte at the data pointer.
instruction_function_map['['] = :start_loop          # if the byte at the data pointer is zero, jump the data pointer forward to the command after the matching ] command*.
instruction_function_map[']'] = :end_loop            # if the byte at the data pointer is nonzero, jump the data pointer back to the command after the matching [ command*.

# While the read head still has tape to read
while ( @tape_head_index < @tape.length)
    #puts @tape_head_index

    instruction = @tape[@tape_head_index].chr
   
    # if the instruction is valid
    if instruction_function_map.has_key?( instruction )
        send instruction_function_map[instruction]
    end

    @tape_head_index += 1
end
