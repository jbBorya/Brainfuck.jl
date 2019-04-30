include("engine.jl")
include("parser.jl")

params = Dict()

params["file"] = ""
params["cells"] = 128
params["size"] = Int64
params["args"] = []
params["extended"] = false
params["build"] = false

i = 1

while i < length(ARGS)
    global i
    if ARGS[i] in ("--file", "-f")
        params["file"] = ARGS[i+=1]
    elseif ARGS[i] in ("--cells", "-c")
        try
            params["cells"] = Int128(ARGS[i+=1])
        catch cx
            exit()
        end
    elseif ARGS[i] in ("--size", "-s")
        try
            s = Int64(ARGS[i+=1])
            if s == 8
                params["size"] = Int8
            elseif s == 16
                params["size"] = Int16
            elseif s == 32
                params["size"] = Int32
            elseif s == 64
                params["size"] = Int64
            elseif s == 128
                params["size"] = Int128
            end
        catch cx
            exit()
        end
    elseif ARGS[i] in ("--args", "-a")
        while i < length(ARGS) && !(length(ARGS[i+1]) in ())
            err = false
            try
                a = parse(Int64, ARGS[i+1])
                if !err
                    push!(params["args"], a)
                end
            catch cx
                err = true
                push!(params["args"], Char(ARGS[i+1]))
            end
            i += 1
        end
    elseif ARGS[i] in ("--extended", "-e")
        params["extended"] = true
    elseif ARGS[i] in ("--build", "-b")
        params["build"] = true
    end
    i += 1
end

# TODO: Error Handling

source = open(params["file"]) do file
    read(file, String)
end

const ENGINE = create_engine(params["cells"], params["size"])

result = execute(ENGINE, source, params["args"])

for o = result
    print(typeof(o) == Char ? "$(o)" : "$(o) ")
end

