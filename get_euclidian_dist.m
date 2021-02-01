

function euclidian_dist = get_euclidian_dist(v1,v2)
euclidian_dist  =  sqrt(  sum( (v1 - v2) .^ 2 )  );
end
