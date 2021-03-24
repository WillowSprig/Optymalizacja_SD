clc; clear; close all;

load membrana

fs = 48e3;
basef = 220;
t = 0:1/fs:2;

freqN = length(freqRatio);
disharmonicityM = zeros(freqN-1,4);
for i=1:4               % choosing base frequency
    rFreq = freqRatio(2:end)*i;
    disharmonicityM(:,i) = ((rFreq-round(rFreq)).^2);
end
[Vharm,Nharm] = min(sum(disharmonicityM.*repmat((1./freqRatio(2:end)),1,4)));
disharmonicity = disharmonicityM(:,Nharm)*400; 

%%

u = NaN(2*gridSize+1,2*gridSize+1,freqN);
for i=1:freqN
    v = val(:,i);
    for k = 1:length(I)
      u(I(k),J(k),i) = v(k);
    end
end

[T,F] = meshgrid(t,freqRatio);
T = T';
F = F';

freqParts = sin(T*2*pi*basef.*F);

%%
whereToHit = NaN(2*gridSize+1);
for i = 1:length(I)
    x = I(i);
    y = J(i);
    weightsWTH = abs(squeeze(u(x,y,2:end))./F(1,2:end)'.^2);
    weightsWTH = weightsWTH/sum(weightsWTH);
    whereToHit(I(i),J(i)) = 100 - sum(weightsWTH.*disharmonicity);
end
bestHarm = floor(max(max(whereToHit)));
worseHarm = floor(min(min(whereToHit)));
contoursWTH = linspace(worseHarm,bestHarm,10);
%%
dispOpt = 1; % 0 - mod, 1 - harm

figure(1)
    hdrum = subplot(3,4,[1:2,5:6,9:10]);
        switch dispOpt
            case 0
                pcolor(u(:,:,1))
            case 1
                contourf(whereToHit,contoursWTH)
                colormap(hdrum,bone)
        end
        shading interp;
        axis equal

    while 1
        [y,x] = ginput(1);
        weights = squeeze(u(round(x),round(y),:))./F(1,:)';
        envs = exp(-1/50*T*basef.*F).*repmat(weights',length(t),1);
        soundOut = sum(freqParts.*envs,2);
        soundOut = soundOut/max(abs(soundOut));
        uw = NaN(2*gridSize+1);
        sound(soundOut,fs)
        for i=1:freqN
            uw(:,:,i) = u(:,:,i)*weights(i);
        end
        uwsum = nansum(uw,3);
        uwsum(uwsum==0) = NaN;
        
        hdrum = subplot(3,4,[1:2,5:6,9:10]);
            switch dispOpt
                case 0
                    pcolor(uwsum);
                case 1
                    contourf(whereToHit,contoursWTH)
                    colormap(hdrum,bone)
            end
            shading interp;
            axis equal


            
        subplot(3,4,3:4)
            clmp = colormap(jet);
            bar(1,1,'FaceColor',clmp(1,:));    
            hold on
                for i=2:freqN
                    if disharmonicity(i-1) < 20
                        col = clmp(ceil(disharmonicity(i-1)/100*320),:);
                    else
                        col = clmp(end,:);
                    end
                    bar(i,abs(weights(i)/weights(1)),'FaceColor',col);
                    axis([0.5, freqN+0.5 0 1.1*max(abs(weights/weights(1)))])
                end
            hold off
            hcb = colorbar('YTick',1:.25:2,'YTickLabel',{'0','5','10','15','20+'});
            hL = ylabel(hcb,'disharmonicity (%)');
            set(hL,'Rotation',90);
            
        subplot(3,4,7:8)
            plot(t,soundOut)
            
        freqEnvRatio = envs(:,2:end)./repmat(sum(abs(envs(:,2:end)),2),1,freqN-1);
        disharmInTime = repmat(disharmonicity',length(t),1).*freqEnvRatio;
        harmInTime = 100 - sum(abs(disharmInTime),2);
        subplot(3,4,11:12)
            plot(t,harmInTime,'LineWidth',2)
            axis([0,max(t),10*floor(0.1*min(harmInTime)),100])
            grid on
    end
