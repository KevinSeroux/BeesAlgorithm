% Requires that ranks are defined
function boolean = dominatesRank(indiv1, indiv2)
    assert(isa(indiv1, 'individual'))
    assert(isa(indiv2, 'individual'))
    
    boolean = indiv1.rank < indiv2.rank;
end

