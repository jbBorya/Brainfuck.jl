
include("./engine.jl")

const DEBUG = false

function execute(e::Engine, source, args)
    ops = replace(source, r"[^\>\<\+\-\.\,\[\]\:\;\#\$]" => "")
    jump = 0
    aptr, cptr = 1, 1
    buf = []

    while cptr <= length(ops)
        if ops[cptr] == '>'
            DEBUG && print("inc_ptr\n")
            inc_ptr(e)
        elseif ops[cptr] == '<'
            DEBUG && print("dec_ptr\n")
            dec_ptr(e)
        elseif ops[cptr] == '+'
            DEBUG && print("inc_dat\n")
            inc_dat(e)
        elseif ops[cptr] == '-'
            DEBUG && print("dec_dat\n")
            dec_dat(e)
        elseif ops[cptr] == '.'
            DEBUG && print("output\n")
            push!(buf, output(e))
        elseif ops[cptr] == ','
            DEBUG && print("input\n")
            input(e, args[aptr])
            aptr += 1
        elseif ops[cptr] == ':'
            DEBUG && print("ioutput\n")
            push!(buf, ioutput(e))
        elseif ops[cptr] == ';'
            DEBUG && print("iinput\n")
            iinput(e, args[aptr])
            aptr += 1
        elseif ops[cptr] == '#'
            DEBUG && print("copy_to_top\n")
            copy_to_top(e)
        elseif ops[cptr] == '$'
            DEBUG && print("copy_to_cell\n")
            copy_to_cell(e)
        elseif ops[cptr] == '['
            DEBUG && print("loop\n")
            if !loop(e)
                cptr += findfirst(c -> c==']', ops[cptr:end])-1
            else
                jump = cptr-1
            end
        else
            DEBUG && print("loop end $(jump)\n")
            cptr = jump
        end
        cptr += 1
    end
    
    return buf
end




        

