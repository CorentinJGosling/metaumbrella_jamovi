
# This file is a generated template, your changes will not be overwritten

checkClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "checkClass",
    inherit = checkBase,
    private = list(
        .run = function() {
            df <- self$data
            facs <- self$options$vars
            for (fac in facs)
                df[[fac]] <- df[[fac]]
            df[df == "NA"] <- NA
            check <- .check_data(df)
            dat <-  attr(check, "data")
            rows <- dat[which(!dat$column_errors %in% c(NA, "") | !dat$column_type_errors %in% c(NA, "")), ]     
            status <- attr(check, "status")
            message <- attr(check, "message")
            
            self$results$text$setContent(paste("Your dataset contains", status, "\n=>", message))
            
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
            
            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)
            # 
            # $status
            # [1] "NO ERRORS OR WARNINGS"
            # 
            # $message
            # [1] "Your dataset is well formatted."
            # 
            # $data
            
        })
)
