"""
    Returns the area under a robustness curve
"""
function _auc(x::Vector{T}, y::Vector{T}) where {T <: Number}
    @assert length(x) == length(y)
    area = 0.0
    for i in 2:length(x)
        area += 0.5 * (x[i] - x[i-1])*(y[i]+y[i-1])
    end
    return area
end

"""
    Retrieves the primary and secondary extinctions for a given series of network extinctions
"""
function robustness(Ns::Vector{T}; dims::Union{Nothing,Int64}=nothing) where {T <: SpeciesInteractionNetwork}
    primary = collect(LinRange(0.0, 1.0, length(Ns)))

    if isnothing(dims)
        secondary = richness.(Ns)./richness(first(Ns))
    else
        
        secondary = richness.(Ns; dims=dims)./richness(first(Ns); dims=dims)
    end
    return primary, secondary
end