function boolean = paretoDominates(indiv1, indiv2)
    indiv1ObjValues = indiv1.objectiveValues;
    indiv2ObjValues = indiv2.objectiveValues;

    b1 = (sum(indiv1ObjValues <= indiv2ObjValues) >= length(indiv1ObjValues));
    if b1 % If indiv1 dominates indiv2 on all obj values
        b2 = (sum(indiv1ObjValues < indiv2ObjValues) >= 1);
        boolean = b1&&b2;
    else
        boolean = b1;
    end
end