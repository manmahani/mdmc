function [] = fit_ind_model(exp_type, model_type, no_itr, max_itr, init_values, par_list)

for p_itr=par_list
    global exp_CDF exp_CAF no_runs_per_itr
    no_runs_per_itr = no_itr;
  
    cdf_file_name_ind = sprintf('exp_data/individual/exp_cdf/cdf_%s_%d.csv', exp_type, p_itr);
    caf_file_name_ind = sprintf('exp_data/individual/exp_caf/caf_%s_%d.csv', exp_type, p_itr);
   
    exp_CDF = csvread(cdf_file_name_ind);
    exp_CAF = csvread(caf_file_name_ind);
    
    if strcmp(model_type, 'mdmc')
        model_fun_err = @model_mdmc_err_func;
    elseif strcmp(model_type, 'fn_mdmc')
        model_fun_err = @model_fn_mdmc_err_func;
    end
    
    [init_values_len, dim] = size(init_values);
    
    Xs = zeros(init_values_len, dim);
    fprintf('fitting for particpant %d :',p_itr);
    for opt_run_itr=1:init_values_len
        gcnt =0;
        [x0,fval,flags,ops]=fminsearch(model_fun_err,init_values(opt_run_itr,:),optimset('MaxIter',max_itr, 'MaxFunEvals', max_itr));
        Xs(opt_run_itr,:)=x0;
        fvals(opt_run_itr)=fval;
    end
    saved_fname=sprintf('modeling/individual/estimated_params_%s_%s/p%d.mat',exp_type, model_type, p_itr);
    save(saved_fname);
    
end
end