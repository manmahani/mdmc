clc
clear
close all

% PLEASE SELECT THE EXPERIMENT HERE: 'VT' or 'VA'
exp_type = 'VA';
model_type = 'fn_mdmc'; % 'mdmc' or 'fn_mdmc'


no_runs_per_itr = 50000;
participants_number = 30;

%% loading data
saved_fname=sprintf('modeling/agg/estimated_params_%s_%s.mat',exp_type, model_type);  % for GA
load(saved_fname)

cdf_file_name=sprintf('exp_data/cdf_agg_%s.csv',exp_type);
caf_file_name=sprintf('exp_data/caf_agg_%s.csv',exp_type);

exp_CDF = csvread(cdf_file_name);
exp_CAF = csvread(caf_file_name);
%% run the evaluation
[vs,indices ] = sort(fvals);
xss=indices(1);
x = Xs(1,:);

if strcmp(model_type, 'mdmc')
    [RTS, CTS, ICTS] = model_mdmc(x, no_runs_per_itr);
elseif strcmp(model_type, 'fn_mdmc')
    [RTS, CTS, ICTS] = model_fn_mdmc(x, no_runs_per_itr);
end
[model_CDF, model_CAF] = extract_model_cdf_caf(RTS, CTS, ICTS);

plot_delta(model_CDF(3,:),model_CDF(9,:), model_CDF(6,:),model_CDF(1,:), model_CDF(7,:), model_CDF(4,:));
title ('Delta - Visual Modality')

plot_delta(model_CDF(7,:), model_CDF(8,:), model_CDF(9,:),model_CDF(1,:),model_CDF(2,:), model_CDF(3,:));
if strcmp(exp_type, 'VT') ==1
    title ('Delta - Tactile Modality')
elseif strcmp(exp_type, 'VA') ==1
    title ('Delta - Auditory Modality')
end


if strcmp(exp_type, 'VT') ==1
    titleMap={'CVCT','NVCT','IVCT','CVNT','NVNT','IVNT','CVIT','NVIT','IVIT'};
elseif strcmp(exp_type, 'VA') ==1
    titleMap={'CVCA','NVCA','IVCA','CVNA','NVNA','IVNA','CVIA','NVIA','IVIA'};
end

figure;
hold on;
xv =[1 2 3 4 5];
for i=1:9
    subplot(3,3,i);
    hold on;
    scatter(xv,exp_CAF(i,:),70,'b','filled');
    plot(xv,model_CAF(i,:),'LineWidth',3);
    title(titleMap{i});
    axis([0.8 5.2 .5 1])
    set(gca,'XTick',[1:5])
    set(gca,'XTickLabel',{'0-20','20-40','40-60',...
        '60-80','80-100'});
    ax = gca;
    ax.XTickLabelRotation = -90;
end

figure;
hold on;
[temp,xvlen]= size(exp_CDF);
xv=[.1 .3 .5 .7 .9];
for i=1:9
    subplot(3,3,i);
    hold on;
    scatter(exp_CDF(i,:),xv,70,'b','filled');
    plot(model_CDF(i,:),xv,'LineWidth',3);
    title(titleMap{i});
    axis([300 600 0 1])
    
end



