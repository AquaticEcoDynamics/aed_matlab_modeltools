function hypo = calc_hypo(oxy,thedate)

[~,ind]  = min(abs(oxy.savedata.Time - thedate));

tt = find(oxy.savedata.Time >= (thedate - 14) & ...
    oxy.savedata.Time <= (thedate));

bot = oxy.savedata.WQ_OXY_OXY.Bot;

bot = bot * 32/1000;

hyp(1:size(bot,1),1:size(bot,2)) = 0;


for i = 1:length(tt)
    sss = find(bot(:,tt(i)) < 4);
    if ~isempty(sss)
    	hyp(sss,i) = (1/length(tt)) * 100;
    end
    
end

hypo = sum(hyp,2);
