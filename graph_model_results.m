% graph_model_results.m
folders=[1 2 3 4 5]; % also included 10 earlier 
folders=[1 2 3 4 5 6]; % also included 10 earlier 
filenames = {'SynNum_Rate.dat'; ,
 'SynRate_CellRate.dat';,
 'ProxInhib_SynRate_CellRate.dat';,
 'ProxInhib_Syn_CellRate.dat';,
 'DistInhib_SynRate_CellRate.dat';,
 'DistInhib_Syn_CellRate.dat'};
for folder_index=1:length(folders)
    folder=[num2str(folders(folder_index)) 'nS/'];

for i=1:length(filenames)
    filename=strcat('neuro_results/',folder, filenames{i})
    disp(['loading ' filename]);
    load(filename)
end

%load SynNum_Rate.dat
%load SynRate_CellRate.dat
%load ProxInhib_SynRate_CellRate.dat
%load ProxInhib_Syn_CellRate.dat
%load DistInhib_SynRate_CellRate.dat
%load DistInhib_Syn_CellRate.dat
h(folder_index,1)=figure

plot(SynNum_Rate(:,1), SynNum_Rate(:,2))
hold on
plot(ProxInhib_Syn_CellRate(:,1),ProxInhib_Syn_CellRate(:,2),'r')
plot(DistInhib_Syn_CellRate(:,1),DistInhib_Syn_CellRate(:,2),'g')
xlabel('number of excitatory synapses in hot spot')
ylabel('cell firing rate (Hz)')
title(['Firing rate vs num. of excit. synapses(blue no inhib), with prox inhib(red) or dist inhib(green), inhib:' folder])

h(folder_index,2)=figure
hold on
plot(SynRate_CellRate(:,1), SynRate_CellRate(:,2),'b')
plot(ProxInhib_SynRate_CellRate(:,1), ProxInhib_SynRate_CellRate(:,2),'r')
plot(DistInhib_SynRate_CellRate(:,1), DistInhib_SynRate_CellRate(:,2),'g')
xlabel('poisson rate of 20 excitatory synapses in hot spot')
ylabel('cell firing rate (Hz)')
title(['Firing rate vs poisson rate of 20 excit. synapses(blue no inhib), with prox inhib(red) or dist inhib(green), inhib:' folder])

saveas(h(folder_index,1),['neuro_results/' folder 'i_' folder(1:end-1) '_e_num.png'],'png')
saveas(h(folder_index,1),['neuro_results/' folder 'i_' folder(1:end-1) '_e_num.fig'],'fig')
saveas(h(folder_index,2),['neuro_results/' folder 'i_' folder(1:end-1) '_e_pois.png'],'png')
saveas(h(folder_index,2),['neuro_results/' folder 'i_' folder(1:end-1) '_e_pois.fig'],'fig')

end
