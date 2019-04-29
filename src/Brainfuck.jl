f = open("Brainfuck.jl/src/input.txt")
lines = readlines(f)

source = lines[1]
#args = [parse(Int32, x) for x = split(lines[2], " ")]

include("engine.jl")
include("parser.jl")

const BF = create_engine(512)

results = execute(BF, source, [])

for r = results
    print(r, " ")
end