function [ output_args ] = plot_delta( CDF_TS_VO, CDF_TO_VO, CDF_TC_VO, CDF_TS_VS, CDF_TO_VS, CDF_TC_VS )
    figure;
    delta =mean([(CDF_TS_VO);(CDF_TO_VO);(CDF_TC_VO)])-mean([(CDF_TS_VS);(CDF_TO_VS);(CDF_TC_VS)]);
    plot(mean([(CDF_TS_VS);(CDF_TO_VS);(CDF_TC_VS)]),delta,'k-*','LineWidth',2)

end

