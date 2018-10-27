clc
clear
close all


% PLEASE SELECT THE EXPERIMENT HERE: 'VT' or 'VA'
exp_type = 'VT';
model_type = 'mdmc'; % 'mdmc' or 'fn_mdmc'


no_runs_per_itr = 50000;
participants_number = 30;

for p_itr=1:participants_number
    %saved_fname=sprintf('individual/saved/p%d.mat',hyper_p); %
    load_fname=sprintf('modeling/individual/estimated_params_%s_%s/p%d.mat',exp_type, model_type, p_itr);  % for GA
    load(load_fname)
    
    
    cdf_file_name_ind = sprintf('exp_data/individual/exp_cdf/cdf_%s_%d.csv', exp_type, p_itr);
    caf_file_name_ind = sprintf('exp_data/individual/exp_caf/caf_%s_%d.csv', exp_type, p_itr);
   
    exp_CDF = csvread(cdf_file_name_ind);
    exp_CAF = csvread(caf_file_name_ind);
    
    exp_CDF_individual(p_itr,:,:) = exp_CDF;
    exp_CAF_individual(p_itr,:,:) = exp_CAF;
    [vs,indices ] = sort(fvals);
    xss=indices(1);
    x = Xs(xss,:);
    x_all(p_itr,:)  = x;
end
mean(x_all)
std(x_all) ./sqrt(30)