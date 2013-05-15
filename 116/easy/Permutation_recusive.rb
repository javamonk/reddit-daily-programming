#!/usr/bin/ruby

# Returns a list of all the permutations of the given string
def permute( inString )
    if ( inString.length == 1 )

        return inString
    else
        permutations = []

        for i in (1..inString.length-1) do
            for permutation1 in permute( inString[0,i] ) do
                for permutation2 in permute( inString[i,inString.length-1] ) do
                    permutations << permutation1 + permutation2
                    permutations << permutation2 + permutation1
                end
            end

        end
        
        return permutations
    end
end
