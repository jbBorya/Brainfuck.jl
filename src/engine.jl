mutable struct Engine{T}
    mem::Array{T,1}
    ptr::Int64
end

function create_engine(memsize::Integer, celsize::DataType)
    return Engine{celsize}(zeros(memsize), 1)
end

function inc_ptr(e::Engine)
    e.ptr += 1
end

function dec_ptr(e::Engine)
    e.ptr -= 1
end

function inc_dat(e::Engine)
    e.mem[e.ptr] += 1
end

function dec_dat(e::Engine)
    e.mem[e.ptr] -= 1
end

function output(e::Engine)
    return Char(e.mem[e.ptr])
end

function input(e::Engine, c::Char)
    e.mem[e.ptr] = Int32(c)
end

function ioutput(e::Engine)
    return e.mem[e.ptr]
end

function iinput(e::Engine, c::Integer)
    e.mem[e.ptr] = c
end

function copy_to_top(e::Engine)
    e.mem[length(e.mem)] = e.mem[e.ptr]
end

function copy_to_cell(e::Engine)
    e.mem[e.ptr] = e.mem[length(e.mem)]
end

function loop(e::Engine)
    return e.mem[e.ptr] != 0
end
