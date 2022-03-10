
# This file is a generated template, your changes will not be overwritten

umbrellaClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "umbrellaClass",
    inherit = umbrellaBase,
    private = list(
        .run = function() {
            
            df <- self$data
            facs <- self$options$vars
            for (fac in facs)
                df[[fac]] <- as.character(df[[fac]])
            
            res <- umbrella(df, 
                            method.var = self$options$method.var,
                            true_effect = self$options$true_effect,
                            mult.level = self$options$mult.level,
                            r = self$options$r)
            results <- summary(res)
            
            if (self$options$criteria != "None") {
                evid <- add.evidence(res, criteria = self$options$criteria,
                                     class_I = c(
                                         n_studies = ifelse(self$options$n_studies_1 == -9999, NA_real_, self$options$n_studies_1),
                                         total_n = ifelse(self$options$total_n_1 == -9999, NA_real_, self$options$total_n_1),
                                         n_cases = ifelse(self$options$n_cases_1 == -9999, NA_real_, self$options$n_cases_1),
                                         p_value = ifelse(self$options$p_value_1 == -9999, NA_real_, self$options$p_value_1),
                                         I2 = ifelse(self$options$I2_1 == -9999, NA_real_, self$options$I2_1),
                                         imprecision = ifelse(self$options$imprecision_1 == -9999, NA_real_, self$options$imprecision_1),
                                         rob = ifelse(self$options$rob_1 == -9999, NA_real_, self$options$rob_1),
                                         amstar = ifelse(self$options$amstar_1 == -9999, NA_real_, self$options$amstar_1),
                                         egger_p = ifelse(self$options$egger_p_1 == -9999, NA_real_, self$options$egger_p_1),
                                         esb_p = ifelse(self$options$esb_p_1 == -9999, NA_real_, self$options$esb_p_1),
                                         JK_p = ifelse(self$options$JK_p_1 == -9999, NA_real_, self$options$JK_p_1),
                                         pi = ifelse(self$options$pi_1 == FALSE, NA_character_, "notnull"),
                                         largest_CI = ifelse(self$options$largest_CI_1 == FALSE, NA_character_, "notnull")
                                     ),
                                     
                                     # ,
                                     # pi = ifelse(self$options$pi_1 != "notnull", NA_real_, self$options$pi_1),
                                     # largest_CI = ifelse(self$options$largest_CI_1 != "notnull", NA_real_, self$options$largest_CI_1)
                                     class_II = c(
                                         n_studies = ifelse(self$options$n_studies_2 == -9999, NA_real_, self$options$n_studies_2),
                                         total_n = ifelse(self$options$total_n_2 == -9999, NA_real_, self$options$total_n_2),
                                         n_cases = ifelse(self$options$n_cases_2 == -9999, NA_real_, self$options$n_cases_2),
                                         p_value = ifelse(self$options$p_value_2 == -9999, NA_real_, self$options$p_value_2),
                                         I2 = ifelse(self$options$I2_2 == -9999, NA_real_, self$options$I2_2),
                                         imprecision = ifelse(self$options$imprecision_2 == -9999, NA_real_, self$options$imprecision_2),
                                         rob = ifelse(self$options$rob_2 == -9999, NA_real_, self$options$rob_2),
                                         amstar = ifelse(self$options$amstar_2 == -9999, NA_real_, self$options$amstar_2),
                                         egger_p = ifelse(self$options$egger_p_2 == -9999, NA_real_, self$options$egger_p_2),
                                         esb_p = ifelse(self$options$esb_p_2 == -9999, NA_real_, self$options$esb_p_2),
                                         JK_p = ifelse(self$options$JK_p_2 == -9999, NA_real_, self$options$JK_p_2),
                                         pi = ifelse(self$options$pi_2 == FALSE, NA_character_, "notnull"),
                                         largest_CI = ifelse(self$options$largest_CI_2 == FALSE, NA_character_, "notnull")
                                     ),
                
                # pi = ifelse(self$options$pi_2 != "notnull", NA_real_, self$options$pi_2),
                # largest_CI = ifelse(self$options$largest_CI_2 != "notnull", NA_real_, self$options$largest_CI_2
                                     class_III = c(
                                         n_studies = ifelse(self$options$n_studies_3 == -9999, NA_real_, self$options$n_studies_3),
                                         total_n = ifelse(self$options$total_n_3 == -9999, NA_real_, self$options$total_n_3),
                                         n_cases = ifelse(self$options$n_cases_3 == -9999, NA_real_, self$options$n_cases_3),
                                         p_value = ifelse(self$options$p_value_3 == -9999, NA_real_, self$options$p_value_3),
                                         I2 = ifelse(self$options$I2_3 == -9999, NA_real_, self$options$I2_3),
                                         imprecision = ifelse(self$options$imprecision_3 == -9999, NA_real_, self$options$imprecision_3),
                                         rob = ifelse(self$options$rob_3 == -9999, NA_real_, self$options$rob_3),
                                         amstar = ifelse(self$options$amstar_3 == -9999, NA_real_, self$options$amstar_3),
                                         egger_p = ifelse(self$options$egger_p_3 == -9999, NA_real_, self$options$egger_p_3),
                                         esb_p = ifelse(self$options$esb_p_3 == -9999, NA_real_, self$options$esb_p_3),
                                         JK_p = ifelse(self$options$JK_p_3 == -9999, NA_real_, self$options$JK_p_3),
                                         pi = ifelse(self$options$pi_3 == FALSE, NA_character_, "notnull"),
                                         largest_CI = ifelse(self$options$largest_CI_3 == FALSE, NA_character_, "notnull")
                                     ),
                # ,
                # pi = ifelse(self$options$pi_3 != "notnull", NA_real_, self$options$pi_3),
                # largest_CI = ifelse(self$options$largest_CI_3 != "notnull", NA_real_, self$options$largest_CI_3)
                                     class_IV = c(
                                         n_studies = ifelse(self$options$n_studies_4 == -9999, NA_real_, self$options$n_studies_4),
                                         total_n = ifelse(self$options$total_n_4 == -9999, NA_real_, self$options$total_n_4),
                                         n_cases = ifelse(self$options$n_cases_4 == -9999, NA_real_, self$options$n_cases_4),
                                         p_value = ifelse(self$options$p_value_4 == -9999, NA_real_, self$options$p_value_4),
                                         I2 = ifelse(self$options$I2_4 == -9999, NA_real_, self$options$I2_4),
                                         imprecision = ifelse(self$options$imprecision_4 == -9999, NA_real_, self$options$imprecision_4),
                                         rob = ifelse(self$options$rob_4 == -9999, NA_real_, self$options$rob_4),
                                         amstar = ifelse(self$options$amstar_4 == -9999, NA_real_, self$options$amstar_4),
                                         egger_p = ifelse(self$options$egger_p_4 == -9999, NA_real_, self$options$egger_p_4),
                                         esb_p = ifelse(self$options$esb_p_4 == -9999, NA_real_, self$options$esb_p_4),
                                         JK_p = ifelse(self$options$JK_p_4 == -9999, NA_real_, self$options$JK_p_4),
                                         pi = ifelse(self$options$pi_4 == FALSE, NA_character_, "notnull"),
                                         largest_CI = ifelse(self$options$largest_CI_4 == FALSE, NA_character_, "notnull")
                                     )
                # ,
                # pi = ifelse(self$options$pi_4 != "notnull", NA_real_, self$options$pi_4),
                # largest_CI = ifelse(self$options$largest_CI_4 != "notnull", NA_real_, self$options$largest_CI_4)
                                     )
                
                evidence <- summary(evid) 
            } else {
                evid <- NULL
            }
            # ====================================================================================== #
            table1 <- self$results$strattable
            
            table1$setRow(rowNo = 1,
                          values = list(
                              Factor = results$Factor[1],
                              Criteria = ifelse(is.null(evid), "N/A", evidence$Criteria[1]),
                              Class = ifelse(is.null(evid), "N/A", as.character(evidence$Class[1])),
                              n_studies = results$n_studies[1],
                              total_n = results$total_n[1],
                              n_cases = results$n_cases[1],
                              n_controls = results$n_controls[1])
            )           
            
            if (length(unique(results$Factor)) > 1) {
                for (i in 2:(length(unique(results$Factor)))) {
                    table1$addRow(rowKey = i,
                                 values = list(
                                     Factor = results$Factor[i],
                                     Criteria = ifelse(is.null(evid), "N/A", evidence$Criteria[i]),
                                     Class = ifelse(is.null(evid), "N/A", as.character(evidence$Class[i])),
                                     n_studies = results$n_studies[i],
                                     total_n = results$total_n[i],
                                     n_cases = results$n_cases[i],
                                     n_controls = results$n_controls[i])
                    )
                }
            }
            
            # ====================================================================================== #
            
            table2 <- self$results$metatable
            
            table2$setRow(rowNo = 1,
                         values = list(
                             Factor = results$Factor[1],
                             measure = results$measure[1],
                             value = results$value[1],
                             value_CI = results$value_CI[1],
                             eG = results$eG[1],
                             eG_CI = results$eG_CI[1],
                             eOR = results$eOR[1],
                             eOR_CI = results$eOR_CI[1],
                             p_value = results$p_value[1])
            )
            
            if (length(unique(results$Factor)) > 1) {
                for (i in 2:(length(unique(results$Factor)))) {
                    table2$addRow(rowKey = i,
                                 values = list(
                                     Factor = results$Factor[i],
                                     measure = results$measure[i],
                                     value = results$value[i],
                                     value_CI = results$value_CI[i],
                                     eG = results$eG[i],
                                     eG_CI = results$eG_CI[i],
                                     eOR = results$eOR[i],
                                     eOR_CI = results$eOR_CI[i],
                                     p_value = results$p_value[i])
                    )
                }
            }
            
            # ====================================================================================== #
            table3 <- self$results$addtable
            
            table3$setRow(rowNo = 1,
                         values = list(
                             Factor = results$Factor[1],
                             I2 = results$I2[1],
                             PI_eG = results$PI_eG[1],
                             PI_eOR = results$PI_eOR[1],
                             egger_p = results$egger_p[1],
                             ESB_p = results$ESB_p[1],
                             power_med = results$power_med[1],
                             JK_p = results$JK_p[1],
                             largest_CI_eG = results$largest_CI_eG[1],
                             largest_CI_eOR = results$largest_CI_eOR[1],
                             rob = results$rob[1],
                             amstar = results$amstar[1])
            )
            
            if (length(unique(results$Factor)) > 1) {
                for (i in 2:(length(unique(results$Factor)))) {
                    table3$addRow(rowKey = i,
                                  values = list(
                                      Factor = results$Factor[i],
                                      I2 = results$I2[i],
                                      PI_eG = results$PI_eG[i],
                                      PI_eOR = results$PI_eOR[i],
                                      egger_p = results$egger_p[i],
                                      ESB_p = results$ESB_p[i],
                                      power_med = results$power_med[i],
                                      JK_p = results$JK_p[i],
                                      largest_CI_eG = results$largest_CI_eG[i],
                                      largest_CI_eOR = results$largest_CI_eOR[i],
                                      rob = results$rob[i],
                                      amstar = results$amstar[i])
                    )
                }
            }
            plotData <- res
            image <- self$results$plot
            image$setState(plotData)
        },
        .plot = function(image, criteria = self$options$criteria, ...) {
            plotData <- image$state
            forest.umbrella(x = add.evidence(plotData, criteria = criteria))
            TRUE
        })
)





