clc
clear
close all

%% set parameters
exp_type = 'VA';
model_type = 'mdmc'; % 'mdmc' or 'fn_mdmc'

max_itr = 2000;
runs_per_itr = 50000;

%% init values for different experiments

VA_mdmc_init_values = [[313,33.1,54.1,.52,13.5,38,6.1,28, 3.1]];
VA_fn_mdmc_init_values = [[313,33.1,54.1,.52,13.5,38,6.1,28, 300, 3.1]];

VT_mdmc_init_values = [[313,33.1,54.1,.52,13.5,38,6.1,28, 3.1]];
VT_fn_mdmc_init_values = [[313,33.1,54.1,.52,13.5,38,6.1,28, 300,  3.1]];

% selecting the init values based on experiment and model 
init_value_command_str = sprintf('init_values = %s_%s_init_values;', exp_type, model_type);
eval(init_value_command_str);

%% call optimization for either individuals or aggregated data

% aggregated
% fit_agg_model(exp_type, model_type, runs_per_itr, max_itr, init_values);

% list of participants
par_list = 1:1:2;
fit_ind_model(exp_type, model_type, runs_per_itr, max_itr, init_values, par_list);