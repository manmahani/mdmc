function [] = fit_agg_model(exp_type, model_type, no_itr, max_itr, init_values)

global exp_CDF exp_CAF no_runs_per_itr
no_runs_per_itr = no_itr;
cdf_file_name=sprintf('exp_data/cdf_agg_%s.csv',exp_type);
caf_file_name=sprintf('exp_data/caf_agg_%s.csv',exp_type);

exp_CDF = csvread(cdf_file_name);
exp_CAF = csvread(caf_file_name);

if strcmp(model_type, 'mdmc')
    model_fun_err = @model_mdmc_err_func;
elseif strcmp(model_type, 'fn_mdmc')
    model_fun_err = @model_fn_mdmc_err_func;
end

[init_values_len, dim] = size(init_values);

Xs = zeros(init_values_len, dim);
for opt_run_itr=1:init_values_len
    gcnt =0;
    [x0,fval,flags,ops]=fminsearch(model_fun_err,init_values(opt_run_itr,:),optimset('MaxIter',max_itr, 'MaxFunEvals', max_itr));
    Xs(opt_run_itr,:)=x0;
    fvals(opt_run_itr)=fval;
end
saved_fname=sprintf('modeling/agg/estimated_params_%s_%s.mat',exp_type, model_type);
save(saved_fname);

end

