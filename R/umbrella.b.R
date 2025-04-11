umbrellaClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "umbrellaClass",
    inherit = umbrellaBase,
    private = list(
        .run = function() {
            df <- self$data
            facs <- self$options$vars
            for (fac in facs)
                df[[fac]] <- df[[fac]]
            df[df == "NA"] <- NA
            
            check <- .check_data(df, JAMOVI=TRUE)
            dat <-  attr(check, "data")
            rows <- dat[which(!dat$column_errors %in% c(NA, "") | !dat$column_type_errors %in% c(NA, "")), ]     
            status <- attr(check, "status")
            message <- attr(check, "message")
            
            text <- paste("Your dataset contains", status, "\n=>", message)
            
            lines <- strsplit(text, '\n')[[1]]
            
            if (status == "ERRORS") {
              style = "style = 'color: #FE191B;' "
              color = "#FE191B"
              background = "#FFC0CB"
            } else if (status == "WARNINGS") {
              style = "style = 'color: #CA8A00;' "
              color = "#CA8A00"
              background = "#FFE4A8"
            } else {
              style = "style = 'color: #068F07;' "
              color = "#068F07"#; display: flex; align-items: center; flex-direction: column; "
              background = "#DAFAD0"
            }
            html <- paste0(paste0("<div style = 'border: 1px solid ", color, "; background-color: ", background, "; padding: 1rem; margin-top: 1rem; color: ",  color, ";'><p "), 
                           style, '>', paste0(lines, collapse=paste0('</p><p ', style, '>')), '</p></div>')
            
            self$results$text$setContent(html)
            
            tableC <- self$results$checktable
            
            tableC$setRow(rowNo = 1,
                          values = list(
                              Row = rows$row_index[1],
                              Type_errors = rows$column_type_errors[1],
                              Description_errors = rows$column_errors[1],
                              author = rows$author[1],
                              year = rows$year[1])
            )           
            
            if (nrow(rows) > 1) {
                for (i in 2:nrow(rows)) {
                    tableC$addRow(rowKey = i,
                                  values = list(
                                      Row = rows$row_index[i],
                                      Type_errors = rows$column_type_errors[i],
                                      Description_errors = rows$column_errors[i],
                                      author = rows$author[i],
                                      year = rows$year[i])
                    )
                }
            }
            if (status != "ERROR") {
                res <- umbrella(df, 
                                JAMOVI = TRUE,
                                max_asymmetry = 100,
                                method.var = self$options$method.var,
                                true_effect = self$options$true_effect,
                                mult.level = self$options$mult.level,
                                pre_post_cor = self$options$pre_post_cor,
                                method.esb = self$options$method.esb,
                                r = self$options$r)
                
                results <- summary(res, digits = 3)
                
                if (self$options$criteria != "None") {
                    evid <- add.evidence(res, criteria = self$options$criteria,
                                         class_I = c(
                                             n_studies = self$options$n_studies_1,
                                             total_n = self$options$total_n_1,
                                             n_cases = self$options$n_cases_1,
                                             p_value = self$options$p_value_1,
                                             I2 = self$options$I2_1,
                                             imprecision = self$options$imprecision_1,
                                             rob = self$options$rob_1,
                                             amstar = self$options$amstar_1,
                                             egger_p = self$options$egger_p_1,
                                             esb_p = self$options$esb_p_1,
                                             JK_p = self$options$JK_p_1,
                                             pi = ifelse(self$options$pi_1 == FALSE, NA_character_, "notnull"),
                                             largest_CI = ifelse(self$options$largest_CI_1 == FALSE, NA_character_, "notnull")
                                         ),
                                         class_II = c(
                                             n_studies = self$options$n_studies_2,
                                             total_n = self$options$total_n_2,
                                             n_cases = self$options$n_cases_2,
                                             p_value = self$options$p_value_2,
                                             I2 = self$options$I2_2,
                                             imprecision = self$options$imprecision_2,
                                             rob = self$options$rob_2,
                                             amstar = self$options$amstar_2,
                                             egger_p = self$options$egger_p_2,
                                             esb_p = self$options$esb_p_2,
                                             JK_p = self$options$JK_p_2,
                                             pi = ifelse(self$options$pi_2 == FALSE, NA_character_, "notnull"),
                                             largest_CI = ifelse(self$options$largest_CI_2 == FALSE, NA_character_, "notnull")
                                         ),
                                         class_III = c(
                                             n_studies = self$options$n_studies_3,
                                             total_n = self$options$total_n_3,
                                             n_cases = self$options$n_cases_3,
                                             p_value = self$options$p_value_3,
                                             I2 = self$options$I2_3,
                                             imprecision = self$options$imprecision_3,
                                             rob = self$options$rob_3,
                                             amstar = self$options$amstar_3,
                                             egger_p = self$options$egger_p_3,
                                             esb_p = self$options$esb_p_3,
                                             JK_p = self$options$JK_p_3,
                                             pi = ifelse(self$options$pi_3 == FALSE, NA_character_, "notnull"),
                                             largest_CI = ifelse(self$options$largest_CI_3 == FALSE, NA_character_, "notnull")
                                         ),
                                         class_IV = c(
                                             n_studies = self$options$n_studies_4,
                                             total_n = self$options$total_n_4,
                                             n_cases = self$options$n_cases_4,
                                             p_value = self$options$p_value_4,
                                             I2 = self$options$I2_4,
                                             imprecision = self$options$imprecision_4,
                                             rob = self$options$rob_4,
                                             amstar = self$options$amstar_4,
                                             egger_p = self$options$egger_p_4,
                                             esb_p = self$options$esb_p_4,
                                             JK_p = self$options$JK_p_4,
                                             pi = ifelse(self$options$pi_4 == FALSE, NA_character_, "notnull"),
                                             largest_CI = ifelse(self$options$largest_CI_4 == FALSE, NA_character_, "notnull")
                                         )
                     )
                    evidence <- merge(summary(evid, digits = 3), results)
                    evidence <- evidence[order(evidence$Class), ]
                } else {
                    evid <- res
                    evidence <- results
                }
                # ====================================================================================== #
                table1 <- self$results$strattable
                
                table1$setRow(rowNo = 1,
                              values = list(
                                  Factor = evidence$Factor[1],
                                  Criteria = ifelse(self$options$criteria == "None", "N/A", evidence$Criteria[1]),
                                  Class = ifelse(self$options$criteria == "None", "N/A", as.character(evidence$Class[1])),
                                  n_studies = evidence$n_studies[1],
                                  total_n = evidence$total_n[1],
                                  n_cases = evidence$n_cases[1],
                                  n_controls = evidence$n_controls[1])
                )           
                
                if (length(unique(evidence$Factor)) > 1) {
                    for (i in 2:(length(unique(evidence$Factor)))) {
                        table1$addRow(rowKey = i,
                                     values = list(
                                         Factor = evidence$Factor[i],
                                         Criteria = ifelse(self$options$criteria == "None", "N/A", evidence$Criteria[i]),
                                         Class = ifelse(self$options$criteria == "None", "N/A", as.character(evidence$Class[i])),
                                         n_studies = evidence$n_studies[i],
                                         total_n = evidence$total_n[i],
                                         n_cases = evidence$n_cases[i],
                                         n_controls = evidence$n_controls[i])
                        )
                    }
                }
                # ====================================================================================== #
                
                table2 <- self$results$metatable
                
                table2$setRow(rowNo = 1,
                             values = list(
                                 Factor = evidence$Factor[1],
                                 measure = evidence$measure[1],
                                 value = evidence$value[1],
                                 value_CI = evidence$value_CI[1],
                                 eG = evidence$eG[1],
                                 eG_CI = evidence$eG_CI[1],
                                 eOR = evidence$eOR[1],
                                 eOR_CI = evidence$eOR_CI[1],
                                 p_value = evidence$p_value[1])
                )
                
                if (length(unique(evidence$Factor)) > 1) {
                    for (i in 2:(length(unique(evidence$Factor)))) {
                        table2$addRow(rowKey = i,
                                     values = list(
                                         Factor = evidence$Factor[i],
                                         measure = evidence$measure[i],
                                         value = evidence$value[i],
                                         value_CI = evidence$value_CI[i],
                                         eG = evidence$eG[i],
                                         eG_CI = evidence$eG_CI[i],
                                         eOR = evidence$eOR[i],
                                         eOR_CI = evidence$eOR_CI[i],
                                         p_value = evidence$p_value[i])
                        )
                    }
                }
                table2$setNote(key = "2", note = "value_CI = Value of the effect size and 95% confidence interval")
                table2$setNote(key = "3", note = "eG = Equivalent Hedges' G // eOR = Equivalent Odds Ratio")
                
                # ====================================================================================== #
                table3 <- self$results$addtable
                
                table3$setRow(rowNo = 1,
                             values = list(
                                 Factor = evidence$Factor[1],
                                 I2 = evidence$I2[1],
                                 PI_eG = evidence$PI_eG[1],
                                 PI_eOR = evidence$PI_eOR[1],
                                 egger_p = evidence$egger_p[1],
                                 ESB_p = evidence$ESB_p[1],
                                 power_med = evidence$power_med[1],
                                 JK_p = evidence$JK_p[1],
                                 largest_CI_eG = evidence$largest_CI_eG[1],
                                 largest_CI_eOR = evidence$largest_CI_eOR[1],
                                 rob = evidence$rob[1],
                                 amstar = evidence$amstar[1])
                )
                
                if (length(unique(evidence$Factor)) > 1) {
                    for (i in 2:(length(unique(evidence$Factor)))) {
                        table3$addRow(rowKey = i,
                                      values = list(
                                          Factor = evidence$Factor[i],
                                          I2 = evidence$I2[i],
                                          PI_eG = evidence$PI_eG[i],
                                          PI_eOR = evidence$PI_eOR[i],
                                          egger_p = evidence$egger_p[i],
                                          ESB_p = evidence$ESB_p[i],
                                          power_med = evidence$power_med[i],
                                          JK_p = evidence$JK_p[i],
                                          largest_CI_eG = evidence$largest_CI_eG[i],
                                          largest_CI_eOR = evidence$largest_CI_eOR[i],
                                          rob = evidence$rob[i],
                                          amstar = evidence$amstar[i])
                        )
                    }
                }
                table3$setNote(key = "4", note = c("PI = 95% prediction interval"))
                table3$setNote(key = "5", note = "egger_p = p-value at the Egger's test")
                table3$setNote(key = "6", note = "ESB_p = p-value at the excess of significance bias test")
                table3$setNote(key = "7", note = "power_med = power provided by the sample size in the meta-analysis to detect a medium effect size (SMD = 0.50)")
                table3$setNote(key = "8", note = "JK_p = largest p-value obtained in the Jackknife meta-analysis")
                table3$setNote(key = "9", note = "largest_CI = 95% CI of the largest study")
                
                plotData <- evid
                image <- self$results$plot
                image$setState(plotData)
            }
        },
            .plot = function(image, ...) {
              if (!is.null(image$state)) {
                  plotData <- image$state
                  title <- ifelse(is.null(self$options$title_forest), "", self$options$title_forest)
                  title_xaxis <- ifelse(is.null(self$options$title_xaxis), NA, self$options$title_xaxis)
                  if (self$options$class_forest == "no_rest") {
                      class_restrict <- c("I", "II", "III", "IV", "V", "ns", "High", "Moderate", "Weak", "Very weak")
                  } else if (self$options$class_forest == "I") {
                      class_restrict <- "I"
                  } else if (self$options$class_forest == "II") {
                      class_restrict <- c("I", "II")
                  } else if (self$options$class_forest == "III") {
                      class_restrict <- c("I", "II", "III")
                  } else if (self$options$class_forest == "IV") {
                      class_restrict <- c("I", "II", "III", "IV")
                  } else if (self$options$class_forest == "High") {
                      class_restrict <- "High"
                  } else if (self$options$class_forest == "Moderate") {
                      class_restrict <- c("High", "Moderate")
                  } else if (self$options$class_forest == "Weak") {
                      class_restrict <- c("High", "Moderate", "Weak")
                  }
                  forest.umbrella(x = plotData,
                                  measure = self$options$measure_forest,
                                  max.value = self$options$max_x,
                                  main_title = title,
                                  main_x_axis = title_xaxis,
                                  print.classes = class_restrict,
                                  cex_title = self$options$cex + 0.4,
                                  cex_text_header = self$options$cex,
                                  cex_text = self$options$cex - 0.1,
                                  cex_value_header = self$options$cex,
                                  cex_value = self$options$cex - 0.1,
                                  cex_x_axis = self$options$cex + 0.1,
                                  cex_x_axis_value = self$options$cex - 0.2,
                                  cex_dots = self$options$cex_dot + 0.2,
                                  x_lim_adj = self$options$x_lim_adj,
                                  y_lim_adj = self$options$y_lim_adj,
                                  x_axis_adj = self$options$x_axis_adj)
                  TRUE
              }
            }
    )
)





