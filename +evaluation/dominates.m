% Do indiv1 dominates indiv2 in a distance-sense?
% Requires that ranks and distances are defined
function boolean = dominates(indiv1, indiv2)
    assert(isa(indiv1, 'individual'))
    assert(isa(indiv2, 'individual'))
    
    if (dominatesRank(indiv1, indiv2)) || ...
            ((indiv1.rank == indiv2.rank) && (indiv1.distance > indiv2.distance))
        boolean = true;
    else
        boolean = false;
    end
end

