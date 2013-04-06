#!/usr/bin/ruby

# http://www.reddit.com/r/dailyprogrammer/comments/1berjh/040113_challenge_122_easy_sum_them_digits/

# Returns the digital route of the given number
def getDigitalRoute( n )
  n - 9 * ( (n - 1) / 9 ).floor
end

ARGV.each do|a|
  p getDigitalRoute(a.to_i)
end
