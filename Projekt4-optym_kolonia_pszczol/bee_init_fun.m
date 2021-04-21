function bee = bee_init_fun(Nvar, scale_bounds)
        
    for n = 1 : Nvar
        bee.scale(n) = scale_bounds(n, 1) + rand * (scale_bounds(n, 2) - scale_bounds(n, 1));
    end
    bee.CF = model_ustroju_perf_fun(bee.scale);
    bee.C = 0;
end