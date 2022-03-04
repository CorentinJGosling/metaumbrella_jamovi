
# This file is a generated template, your changes will not be overwritten

umbrellaClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "umbrellaClass",
    inherit = umbrellaBase,
    private = list(
        .run = function() {
            df <- self$data

            ## TRY 1: removing the vars argument from the umbrella.a.yaml file.
            ## Failure: 'This analysis has terminated, likely due to a hitting a ressource limit'
            # results <- umbrella(df)
            # table <- self$results$umbrellatable
            # table$setRow(rowNo = 1,
            #              values = list(
            #                  col1 = results$Factor[1],
            #                  col2 = results$n_cases[1],
            #                  col3 = results$n_controls[1])
            # )
            
            ## TRY 2: Lighter function: removing the vars argument from the umbrella.a.yaml file.
            ## Failure: triggers one of our error messages that indicates that the dataframe passed to the function has no column
            # results <- esb.test(df, measure = "RR")
            # table <- self$results$umbrellatable
            # table$setRow(rowNo = 1,
            #              values = list(
            #                  col1 = results$method[1],
            #                  col2 = results$p.value[1],
            #                  col3 = results$mean_power[1])
            # )
            
            # TRY 3: Failure with error message 'argument vars is missing with no default'
            # facs <- self$options$vars
            # for (fac in facs)
            #     df[[fac]] <- as.character(df[[fac]])
            # results <- summary(umbrella(df))
            # table <- self$results$umbrellatable
            # table$setRow(rowNo = 1,
            #              values = list(
            #                  col1 = results$Factor[1],
            #                  col2 = results$n_cases[1],
            #                  col3 = results$n_controls[1])
            # )
            
            
            ## TRY 4: Lighter function - Works perfectly but I do not understand why (why no error due to inclusion of vars options?)
            # facs <- self$options$vars
            # for (fac in facs)
            #     df[[fac]] <- as.character(df[[fac]])
            # 
            results <- esb.test(df, measure = "RR")
            table <- self$results$umbrellatable
            table$setRow(rowNo = 1,
                         values = list(
                             col1 = results$method[1],
                             col2 = results$p.value[1],
                             col3 = results$mean_power[1])
            )
            

            

            
            
            

            # ===================================================================================================#
            
            ## D. replicating the example presented in jamovi's website but using correlations to ensure the issue comes from our package 
            ## this is just to understand how things works if needed
            # formula <- paste('~', self$options$depa, '+', self$options$depb)
            # formula <- as.formula(formula)
            # results <- cor.test(formula, self$data)
            # 
            # table <- self$results$umbrellatable
            # table$setRow(rowNo=1, values=list(
            #     t=results$statistic,
            #     df=results$parameter,
            #     p=results$p.value
            # ))
            # => this is perfectly working 
            
        })
)
