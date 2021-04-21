function nz = Nzerocross(x)

nz = 0;
for n = 1 : length(x)-1
    if (x(n) * x(n+1)) < 0
        nz=nz+1;
    end
end