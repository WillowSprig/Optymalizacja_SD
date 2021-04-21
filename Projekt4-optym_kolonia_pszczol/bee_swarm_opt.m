clear
close all

bee = struct('scale', [], 'C', [], 'CF', []);

swarm_size = 50;
max_iter = 200;
max_C = 50;
scale_bounds = [.33 10; .25 3; 1/38 5.3; .2 2];
Nvar = 4;
a_max = .5;

%% initialization

if size(scale_bounds,1) == 1
    scale_bounds = repmat(scale_bounds, Nvar, 1);
end

for b = 1 : swarm_size    
    bee(b) = bee_init_fun(Nvar, scale_bounds);
end

CF_plot = zeros(max_iter, swarm_size);

%% optimization

for it = 1 : max_iter

% fprintf("Iteration %d\n", it)
%% employer phase
    for b = 1 : swarm_size
        rand_bee = randi(swarm_size);
        while rand_bee == b
            rand_bee = randi(swarm_size);
        end
        acc = 2 * (rand - .5) * a_max;
        temp.scale = bee(b).scale + acc * (bee(b).scale - bee(rand_bee).scale);
        for n = 1 : Nvar
            temp.scale(temp.scale<scale_bounds(n, 1)) = scale_bounds(n, 1);
            temp.scale(temp.scale>scale_bounds(n, 2)) = scale_bounds(n, 2);
        end
        temp.CF = model_ustroju_perf_fun(temp.scale);
%         temp.C = bee(b).C;
        temp.C = 0;
        
        if temp.CF < bee(b).CF
            bee(b) = temp;
        else
            bee(b).C = bee(b).C + 1;
        end
    end

%% onlooker phase
    meanCF = mean([bee(:).CF]);
    fm = exp(-[bee(:).CF] ./ meanCF);
  
    for b = 1 : swarm_size
        rand_bee = RouletteWheelSelection(fm./sum(fm));
        while rand_bee == b
            rand_bee = RouletteWheelSelection(fm/sum(fm));
        end
        acc = 2 * (rand - .5) * a_max;
        temp.scale = bee(b).scale + acc * (bee(b).scale - bee(rand_bee).scale);
        for n = 1 : Nvar
            temp.scale(temp.scale<scale_bounds(n, 1)) = scale_bounds(n, 1);
            temp.scale(temp.scale>scale_bounds(n, 2)) = scale_bounds(n, 2);
        end
        temp.CF = model_ustroju_perf_fun(temp.scale);
%         temp.C = bee(b).C;
        temp.C = 0;
        
        if temp.CF < bee(b).CF
            bee(b) = temp;
            meanCF = mean([bee(:).CF]);
            fm(b)=exp(-[bee(b).CF] ./ meanCF);
        else
            bee(b).C = bee(b).C + 1;
        end
    end
    
%% scout phase

    for b = 1 : swarm_size
        if bee(b).C > max_C
            bee(b) = bee_init_fun(Nvar, scale_bounds);
            meanCF = mean([bee(:).CF]);
            fm(b)=exp(-[bee(b).CF] ./ meanCF);
        end
    end

    CF_plot(it, :) = [bee(:).CF];
    [~, idx] = min([bee(:).CF]);
    bestBee(it) = bee(idx);
    
end

BestCost = bestBee(it).CF

figure
set(gcf, 'color', 'white', 'PaperOrientation', 'landscape')
plot(CF_plot, 'linewidth', 1.5)
grid on
set(gca, 'fontsize', 20)
xlabel('Nr iteracji', 'fontsize', 20)
ylabel('Wartoœæ funkcji kosztu', 'fontsize', 20)


