% print_model_results.m
%
%create statistics where for each inhhibition
%for each control firing rate normalize it to one and express the 
%prox and dist inhibitions as fractions of that.  find the average fraction
%and standard deviation for these values
%
% SynNum_ave will have 5 columns
% nS inhib , numSyn, ctrl firing rate, ctrl/inhib fraction for prox inhib, ctrl/inhib frac for dist inhib
% SynNum_sd will have columns
% nS inhib, ctrl/inhib stand dev for prox inhib, ctrl/inhib stand dev for dist inhib
% SynRate_ave will have columns
% nS, ctrl firing rate, ctrl/inhib fraction for prox inhib, ctrl/inhib frac for dist inhib
% SynNum_sd will have columns
% nS inhib, ctrl/inhib stand dev for prox inhib, ctrl/inhib stand dev for dist inhib
%
% the source data for these computations
% go together in two groups based on whether the simulations had
% a fixed poisson rate (20 Hz) and a varying number of synapses in the
% excitatory hot spot:
% SynNum_Rate ProxInhib_Syn_CellRate DistInhib_Syn_CellRate
% in the above variables SynNum or Syn refer to that there were a varying
% number of excitatory synapses and Rate or CellRate refer to the fact that
% the output rate of the cell was measured.
%
% or if the hot spot had always 20 excitatory synapses and the firing
% rate of each of these varied:
% SynRate_CellRate ProxInhib_SynRate_CellRate DistInhib_SynRate_CellRate


folders=[1 2 3 4 5]; % also included 10 earlier 
folders=[1 2 3 4 5 6 7]; % also included 10 earlier 
folders=[1 2 3 4 5 10]; % also included 10 earlier 
filenames = {'SynNum_Rate.dat'; ,
 'SynRate_CellRate.dat';,
 'ProxInhib_SynRate_CellRate.dat';,
 'ProxInhib_Syn_CellRate.dat';,
 'DistInhib_SynRate_CellRate.dat';,
 'DistInhib_Syn_CellRate.dat'};
SynNum_ave_row_index=1;
SynRate_ave_row_index=1;
init=0;
% the inhib data is demarcated in SynNum_ave, SynRate_ave
%inhib_num_start_stop_indicies(folder_index,1)=start_index
%inhib_num_start_stop_indicies(folder_index,2)=stop_index
% and 
%inhib_rate_start_stop_indicies(folder_index,1)=start_index
%inhib_rate_start_stop_indicies(folder_index,2)=stop_index

for folder_index=1:length(folders)

    inhib_num_start_stop_indicies(folder_index,1)=SynNum_ave_row_index;
    inhib_rate_start_stop_indicies(folder_index,1)=SynRate_ave_row_index;


    folder=[num2str(folders(folder_index)) 'nS/'];
    if init
        disp([' and the same for ' folder]);
    end
    for i=1:length(filenames)
            filename=strcat('neuro_results/',folder, filenames{i});
            filename=strcat(folder, filenames{i});
        if init
        else
            disp(['loading ' filename]);
        end
        load(filename)
    end
    init=-1;
%load SynNum_Rate.dat
%load SynRate_CellRate.dat
%load ProxInhib_SynRate_CellRate.dat
%load ProxInhib_Syn_CellRate.dat
%load DistInhib_SynRate_CellRate.dat
%load DistInhib_Syn_CellRate.dat

%%h(folder_index,1)=figure

%%plot(SynNum_Rate(:,1), SynNum_Rate(:,2))
%%hold on
%%plot(ProxInhib_Syn_CellRate(:,1),ProxInhib_Syn_CellRate(:,2),'r')
%%plot(DistInhib_Syn_CellRate(:,1),DistInhib_Syn_CellRate(:,2),'g')
%%xlabel('number of excitatory synapses in hot spot')
%%ylabel('cell firing rate (Hz)')
%%title(['Firing rate vs num. of excit. synapses(blue no inhib), with prox inhib(red) or dist inhib(green), inhib:' folder])
for SynNum_index=1:length(SynNum_Rate)
    SynNumAve(SynNum_ave_row_index, 1) = folders(folder_index);  % firing rate
    SynNumAve(SynNum_ave_row_index, 2) = SynNum_Rate(SynNum_index,1); % num of e syns
    SynNumAve(SynNum_ave_row_index, 3) = SynNum_Rate(SynNum_index,2); % ctrl firing rate
    if SynNum_Rate(SynNum_index,2)>0
        SynNumAve(SynNum_ave_row_index, 4) = ProxInhib_Syn_CellRate(SynNum_index,2)/SynNum_Rate(SynNum_index,2);
        SynNumAve(SynNum_ave_row_index, 5) = DistInhib_Syn_CellRate(SynNum_index,2)/SynNum_Rate(SynNum_index,2);
    else
        SynNumAve(SynNum_ave_row_index, 4) = -1;
        SynNumAve(SynNum_ave_row_index, 5) = -1;
    end
    inhib_num_start_stop_indicies(folder_index,2)=SynNum_ave_row_index; % gets updated till folder_index is incremented

    SynNum_ave_row_index = SynNum_ave_row_index + 1;
end

% SynRate_CellRate ProxInhib_SynRate_CellRate DistInhib_SynRate_CellRate
for SynRate_index=1:length(SynRate_CellRate)
    SynRateAve(SynRate_ave_row_index, 1) = folders(folder_index);  % firing rate
    SynRateAve(SynRate_ave_row_index, 2) = SynRate_CellRate(SynRate_index,1); % num of e syns
    SynRateAve(SynRate_ave_row_index, 3) = SynRate_CellRate(SynRate_index,2); % ctrl firing rate
    if SynRate_CellRate(SynRate_index,2)>0
        SynRateAve(SynRate_ave_row_index, 4) = ProxInhib_SynRate_CellRate(SynRate_index,2)/SynRate_CellRate(SynRate_index,2);
        SynRateAve(SynRate_ave_row_index, 5) = DistInhib_SynRate_CellRate(SynRate_index,2)/SynRate_CellRate(SynRate_index,2);
    else
        SynRateAve(SynRate_ave_row_index, 4) = -1;
        SynRateAve(SynRate_ave_row_index, 5) = -1;
    end
    inhib_rate_start_stop_indicies(folder_index,2)=SynRate_ave_row_index;% updated until folder_index incremented
    SynRate_ave_row_index = SynRate_ave_row_index + 1;
end

%%h(folder_index,2)=figure
%%hold on
%%plot(SynRate_CellRate(:,1), SynRate_CellRate(:,2),'b')
%%plot(ProxInhib_SynRate_CellRate(:,1), ProxInhib_SynRate_CellRate(:,2),'r')
%%plot(DistInhib_SynRate_CellRate(:,1), DistInhib_SynRate_CellRate(:,2),'g')
%%xlabel('poisson rate of 20 excitatory synapses in hot spot')
%%ylabel('cell firing rate (Hz)')
%%title(['Firing rate vs poisson rate of 20 excit. synapses(blue no inhib), with prox inhib(red) or dist inhib(green), inhib:' folder])

%%saveas(h(folder_index,1),['neuro_results/' folder 'i_' folder(1:end-1) '_e_num.png'],'png')
%%saveas(h(folder_index,1),['neuro_results/' folder 'i_' folder(1:end-1) '_e_num.fig'],'fig')
%%saveas(h(folder_index,2),['neuro_results/' folder 'i_' folder(1:end-1) '_e_pois.png'],'png')
%%saveas(h(folder_index,2),['neuro_results/' folder 'i_' folder(1:end-1) '_e_pois.fig'],'fig')

end

a=SynNumAve(:,4); % candidate prox ratios
SynNum_pr=a(a>0); % actual prox ratios
b=SynNumAve(:,5); % candidate dist ratios
SynNum_dr=b(b>0); % actual dist ratios
disp(['Average (prox inhib rate)/ctrl ratio fraction is ' num2str(mean(SynNum_pr)) ', std = ' num2str(std(SynNum_pr))]);
disp(['Average (distal inhib)/ctrl ratio fraction is ' num2str(mean(SynNum_dr)) ', std = ' num2str(std(SynNum_dr))]);

figure
plot(SynNumAve(:,2),SynNumAve(:,5),'go')
hold on
plot(SynNumAve(:,2),SynNumAve(:,4),'ro')

% find out for stats on a per inhibition level

for folder_index=1:length(folders)
    disp(['stats for ' num2str(folders(folder_index)) 'nS']);
    a=SynNumAve(inhib_num_start_stop_indicies(folder_index,1):inhib_num_start_stop_indicies(folder_index,2),4); % candidate prox ratios
    SynNum_pr=a(a>0); % actual prox ratios
    b=SynNumAve(inhib_num_start_stop_indicies(folder_index,1):inhib_num_start_stop_indicies(folder_index,2),5); % candidate dist ratios
    SynNum_dr=b(b>0); % actual dist ratios
    disp(['  Average (prox inhib rate)/ctrl ratio fraction is ' num2str(mean(SynNum_pr)) ', std = ' num2str(std(SynNum_pr))]);
    disp(['  Average (distal inhib)/ctrl ratio fraction is ' num2str(mean(SynNum_dr)) ', std = ' num2str(std(SynNum_dr))]);
end
    
% redo stats for SynRateAve
%
