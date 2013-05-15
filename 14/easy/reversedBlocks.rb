#!/usr/bin/ruby

def PrintReversedBlocks(list, blockSize)
    currentIndex = blockSize = blockSize - 1

    while not list.empty?
        puts list.slice!(currentIndex)
        currentIndex = currentIndex < 0 ? [blockSize,list.length-1].min : currentIndex - 1
    end
end

elements = [1, 2, 3, 4, 5, 6]
blockSize = 3
PrintReversedBlocks(elements, blockSize)
