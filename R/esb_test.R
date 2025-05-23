#' Perform some tests for excess of significance
#'
#' The \code{esb.test()} function performs various tests to examine the presence of an excess of statistical significance in a given set of studies.
#' These tests aims to determine whether there is an excess in the observed number of studies with statistically significant results compared to what could have been expected.
#'
#' @param x a well-formatted dataset or an object of class \dQuote{rma} or \dQuote{meta}. If a well-formatted dataset is used, only one factor should be included.
#' @param input the type of object used as input. It must be \code{"dataframe"}, \code{"rma"} or \code{"meta"}.
#' @param n_cases vector with the number of cases of each included studies. Only required when \code{x} is an object of class \dQuote{rma} or \dQuote{meta}.
#' This information  can be indicated via the \code{n_cases} argument of the \code{esb.test()} function or directly when calling the \code{rma()} or \code{meta()} functions (see examples below).
#' @param n_controls vector with the number of controls of each included studies. Only required when \code{x} is an object of class \dQuote{rma} or \dQuote{meta}
#' This information  can be indicated via the \code{n_controls} argument of the \code{esb.test()} function or directly when calling the \code{rma()} or \code{meta()} functions (see examples below).
#' @param measure the measure of the effect: "SMD", "MD", "R", "Z", "G", "OR" or "logOR, "RR" or "logRR", "HR" or "logHR", "IRR" or "logIRR".
#' If a an object of class \dQuote{rma} or \dQuote{meta} is used, the effect size should be either "SMD" or "OR". However, note that for \dQuote{rma} objects, a SMD is systematically assumed to be a G (to respect the naming used in the \pkg{metafor} package). For \dQuote{meta} objects, a SMD is assumed to be a G unless it is explicitly stated that this is not the case (i.e., using the \code{method.smd = "Cohen"} argument).
#' The effect size measure used can be indicated via the measure argument of the \code{esb.test()} function or directly when calling the \code{rma()} or \code{meta()} functions (see examples below).
#' @param method.esb the method used to conduct the test. It must be \code{PSST}, \code{TESS} or \code{TESSPSST}  (see details). Default is \code{"TESSPSST"}.
#' @param tau2 The tau2 value that should be used when using one of the \code{PSST}, \code{TESS} or \code{TESSPSST} methods (see details).
#' @param true_effect the best approximation of the true effect. It must be \code{"largest"}, \code{"UWLS"} or a numeric value (see details). Default is \code{"UWLS"}.
#' @param seed an integer value used as an argument by the set.seed() function. Only used for measures "OR", "logOR, "RR", "logRR", "IRR" or "logIRR".
#'
#' @details The function starts by calculating whether each individual study has significant results (p < .05). Then, it estimates the statistical power of each individual study to detect an effect size equal to the best approximation of the true effect.
#' The \code{true_effect} argument can be used to select the method that will be applied to estimate the true effect.
#' * If \code{"largest"} is entered, the true effect size is assumed to be equal to the effect size of the largest study included in the meta-analysis.
#' * If \code{"UWLS"} is entered, the true effect size is assumed to be equal to unrestricted weighted least squares weighted average.
#' * If a \code{numeric} value is entered, the true effect size is assumed to be equal to the value entered by the user (note that the value of ratios must be in their natural scale).
#'
#' Last, this function performs a statistical test to determine whether the observed number of statistically significant studies is higher than expected given the mean statistical power. The \code{method.esb} argument can be used to select the test.
#' * If \code{"TESS"} is entered, the test of excess statistical significance (TESS) described by Stanley and colleagues (2021) is performed. This test assesses whether the proportion of excess statistical significance is larger than 5%. In this test, power calculations take into account between-study heterogeneity.
#' * If \code{"PSST"} is entered, the proportion of statistical significance test (PSST) described by Stanley and colleagues (2021) is performed. This is a test assessing whether the proportion of statistically significant studies is higher than what could have been expected given the mean statistical power. In this test, power calculations take into account between-study heterogeneity.
#' * If \code{"TESSPSST"} is entered, the function combines results of both "PSST" and "TESS" analyses. "TESSPSST" assumes an excess of statistical significance if at least one of "TESS" and "PSST" is statistically significant.
#'
#' @return
#' The dataset contains the following columns: \tabular{ll}{
#'  \code{method} \tab method used to conduct the test.\cr
#'  \tab \cr
#'  \code{p.value} \tab p-value for the test statistic.\cr
#'  \tab \cr
#'  \code{power} \tab the power of each individual study to detect the best\cr
#'  \tab approximation of the true effect (\code{true_effect}) at an alpha of .05.\cr
#'  \tab \cr
#'  \code{mean_power} \tab the mean power of all individual studies to detect the best\cr
#'  \tab approximation of the true effect (\code{true_effect}) at an alpha of .05.\cr
#'  \tab \cr
#'  \code{k} \tab the total number of studies.\cr
#'  \tab \cr
#'  \code{sig} \tab whether each individual study has statistically significant results.\cr
#'  \tab \cr
#'  \code{O} \tab the total number of studies with statistically significant results.\cr
#'  \tab \cr
#'  \code{E} \tab the total expected number of studies with statistically significant results.\cr
#'  \tab \cr
#'}
#'
#' @md
#'
#' @export esb.test
#'
#' @references Ioannidis, JPA., Munafo, MR., Fusar-Poli, P., Nosek, BA., & David, SP. (2014). Publication and other reporting biases in cognitive sciences: detection, prevalence, and prevention. \emph{Trends in Cognitive Sciences}, \bold{18}, 235-241.
#'
#' @examples
#' ### load a well-formatted dataframe with a single factor
#' df <- df.SMD[df.SMD$factor == "Surgical", ]
#'
#' ### perform an excess significance bias directly on this dataframe
#' esb <- esb.test(df, measure = "SMD", input = "dataframe",
#'                 method.esb = "TESS", true_effect = "largest")
#'
#' ### perform an excess significance bias using the umbrella function
#' esb.umbrella <- umbrella(df, method.esb = "TESS", true_effect = "largest")[[1]]$esb
#'
#' ### perform an excess significance bias on a rma object
#' ### we convert the SMD into Hedges' g
#' G <- metaumbrella:::.estimate_g_from_d(df$value, df$n_cases, df$n_controls)
#' rma <- metafor::rma(yi = G$value, sei = G$se,
#'                     measure = "SMD",
#'                     ni = df$n_cases + df$n_controls,
#'                     data = df)
#'
#' esb.rma <- esb.test(rma, n_cases = df$n_cases, input = "rma", method.esb = "TESS")
#'
#' ### perform an excess significance bias on a meta object
#' meta <- meta::metagen(TE = G$value, seTE = G$se,
#'                       sm = "SMD",
#'                       n.e = n_cases, n.c = n_controls,
#'                       data = df)
#'
#' esb.meta <- esb.test(meta, input = "meta", method.esb = "TESS")
#'
#' all.equal(esb$p.value, esb.umbrella$p.value, esb.rma$p.value, esb.meta$p.value)
esb.test = function (x, input = "dataframe", n_cases = NULL, n_controls = NULL, measure = NULL, method.esb = "TESSPSST", true_effect = "UWLS", seed = NA, tau2 = NULL) {

  # some checkings
  if (length(unique(x$factor)) > 1) {
    stop("Only one factor can be assessed in the esb.test")
  } else if (!method.esb %in% c("TESS", "PSST", "TESSPSST")) {
    stop("The method.esb argument must be either 'TESS', 'PSST', 'TESSPSST'.)")
  } else if (!true_effect %in% c("UWLS", "largest") & !is.numeric(true_effect)) {
    stop("The true_effect argument should be either 'UWLS', 'largest', a numeric value or 'pooled' (=> only if indicated from the umbrella() function). Please see the manual for more information.")
  }


  # we check that the input passed to the function is appropriate according to the input required
  #### RMA -------
  if (input == "rma") {
    if (!inherits(x, "rma")) { stop("The object passed to esb.test should be a 'rma' object when 'input = rma'") }

    measure = ifelse(x$measure %in% c("SMD", "OR", "logOR"),
                     x$measure,
                     ifelse(!is.null(measure),
                            measure,
                            stop("The measure should be indicated either when calling the 'rma' function or when calling the 'esb.test' function.")))

    x = .rma_to_umbrella_x(x, n_cases, n_controls, measure)
    tau2 = ifelse(is.null(tau2), attr(x, "tau2"), tau2)
    measure[measure=="OR"] <- "logOR"
  #### meta --------
  } else if (input == "meta") {

    if (!inherits(x, "meta")) { stop("The object passed to esb.test should be a 'meta' object when 'input = meta'") }

    measure = ifelse(x$sm %in% c("SMD", "OR", "logOR"),
                     x$sm,
                     ifelse(!is.null(measure), measure, stop("The measure should be indicated either when calling the 'meta' function or when calling the 'esb.test' function.")))

    x = .meta_to_umbrella_x(x, n_cases, n_controls, measure)
    tau2 = ifelse(is.null(tau2), attr(x, "tau2"), tau2)
    measure[measure=="OR"] <- "logOR"
  #### well-formatted dataset --------
  } else if (input == "dataframe") {
    res_umb = umbrella(subset(x, factor == unique(x$factor)[1]),
             method.esb = method.esb,
             mult.level=TRUE,
             tau2 = tau2,
             true_effect = true_effect, seed = seed)
    return(res_umb[[1]]$esb)
    #### called from umbrella() --------
  }
  if (method.esb %in% c("TESS", "PSST", "TESSPSST") & is.na(tau2)) {
    stop("The tau2 value cannot be empty when requesting 'method.esb' = 'TESS', 'PSST' or 'TESSPSST'.")
  }

  if (measure %in% c("G", "SMC", "SMD", "MD", "MC")) {

    N = x$n_cases + x$n_controls
    if (any(is.na(N))) {
      miss_n = which(is.na(N))
      N_imput <- round((2 + x$value^2/4)/x$se^2) * 2
      N[miss_n] = N_imput[miss_n]
      x$n_cases[miss_n] = round(N[miss_n]/2)
      x$n_controls[miss_n] = round(N[miss_n]/2)
      x$n_sample[miss_n] = round(N[miss_n])
    }
    J <- .d_j(x$n_cases + x$n_controls - 2)
    x$value <- x$value / J
    x$se = sqrt(1/x$n_cases + 1/x$n_controls)
  }

  # Estimate p.values
  k = nrow(x)
  x$p.value = NA

  for (i in 1:k) {
    value_i = ifelse(measure %in% c("HR", "IRR", "OR", "RR"),
                     log(x$value[i]),
                     x$value[i])
    x$p.value[i] = ifelse(
      value_i == 0,
      1,
      .two_tail(ifelse(measure %in% c("HR", "IRR", "OR", "RR",
                                      "logHR", "logIRR", "logOR", "logRR",
                                      "R", "Z"),
                       pnorm(value_i / x$se[i]),
                       pt(value_i / x$se[i], x$n_cases[i] + x$n_controls[i] - 2)
                       )
                )
      )
  }

  x$signif = is.na(x$p.value) | x$p.value < 0.05 # is.na for NSUEs

  # estimate the best approximation of the true effect
  if (true_effect == "largest") {
    true_value = .largest_overall(x, return = "value")
  } else if (is.numeric(true_effect)) {
    true_value = true_effect
  } else if (true_effect == "UWLS") {
    if (measure %in% c("HR", "IRR", "OR", "RR")) {
      t = log(x$value) / x$se
      prec = 1 / x$se
      true_value = exp(as.numeric(lm(t ~ 0 + prec)$coefficients))
    } else {
      t = x$value / x$se
      prec = 1 / x$se
      true_value = as.numeric(lm(t ~ 0 + prec)$coefficients)
    }
  }

  # estimate statistical power
  x$power = NA

  if (is.na(seed)) { withr::local_preserve_seed() } else { withr::local_seed(seed) }

  if (method.esb %in% c("TESS", "PSST", "TESSPSST")) {
    if (measure %in% c("OR", "HR", "RR", "IRR")) {
      x$power = 1 - pnorm( (1.96 * x$se - abs(log(true_value))) / (sqrt(x$se^2 + tau2)) )
    } else {
      x$power = 1 - pnorm( (1.96 * x$se - abs(true_value)) / (sqrt(x$se^2 + tau2)) )
    }
  }

  # print(measure)
  # print(tau2)
  # print(x$power[1])
  # print(true_value)
  # print(method.esb)

  # Conduct the test
  if (all(!is.na(x$power))) {
    SS = sum(x$signif)
    expected_mean_power = mean(x$power)
    Esig = sum(x$power)
    esb = switch (method.esb,
                  "TESS" = {
                    method.esb = "New methods for excess statistical significance (TESS)"
                    ESS = (SS - Esig) / k
                    z_TESS = (ESS - 0.05) / sqrt(0.05 * (1 - 0.05) / k)
                    p.value = 1 - pnorm(z_TESS)
                    data.name <- paste0("A total of ", SS, " studies have statistically significant results,",
                    " while we can theoritically expect this number to be ", Esig,
                    ". The proportion of excess statistical significance is thus equal to: ",
                    round(ESS, 3)*100, "%")
                    estimate <- z_TESS
                    attr(estimate, "names") <- "z-statistics"
                    attr(p.value, "names") <- NULL

                    list(
                      method = method.esb,
                      estimate = estimate,
                      p.value = p.value,
                      data.name = data.name,
                      power = x$power,
                      sig = x$signif,
                      mean_power = expected_mean_power,
                      k = k,
                      SS = SS,
                      Esig = Esig
                    )
                  },
                  "PSST" = {
                    method.esb <- "New methods for excess statistical significance (PSST)"
                    z_PSST = (SS/k - Esig/k) / sqrt(Esig/k * (1 - Esig/k) / k)
                    p.value = 1 - pnorm(z_PSST)
                    data.name <- paste0("A total of ", SS, " studies have statistically significant results while the theoretical number of statistically significant studies is equal to ", round(Esig, 3))
                    estimate <- z_PSST
                    attr(estimate, "names") <- "z-statistics";
                    attr(p.value, "names") <- NULL
                    list(
                      method = method.esb,
                      estimate = estimate,
                      p.value = p.value,
                      data.name = data.name,
                      power = x$power,
                      sig = x$signif,
                      mean_power = expected_mean_power,
                      k = k,
                      SS = SS,
                      Esig = Esig
                    )
                  },
                  "TESSPSST" = {
                    method.esb <- "New methods for excess significance bias (TESSPSST)"
                    ESS = (SS - Esig) / k
                    z_PSST = (SS/k - Esig/k) / sqrt(Esig/k * (1 - Esig/k) / k)
                    p_PSST = 1 - pnorm(z_PSST)
                    z_TESS = (ESS - 0.05) / sqrt(0.05 * (1 - 0.05) / k)
                    p_TESS = 1 - pnorm(z_TESS)
                    p.value = min(p_PSST, p_TESS)
                    estimate <- max(z_TESS, z_PSST)
                    data.name <- paste0("The proportion of excess statistical significance is equal to: ", round(ESS, 3)*100, "% // A total of ", SS, " studies have statistically significant results while the theoretical number of statistically significant studies is equal to ", round(Esig, 3))
                    attr(estimate, "names") <- "z-statistics"
                    attr(p.value, "names") <- NULL
                    list(
                      method = method.esb,
                      p.value = p.value,
                      p.value.TESS = p_TESS,
                      p.value.PSST = p_PSST,
                      data.name = data.name,
                      estimate = estimate,
                      power = x$power,
                      sig = x$signif,
                      mean_power = expected_mean_power,
                      k = k,
                      SS = SS,
                      Esig = Esig
                    )
                  }
    )
  } else {
    warning(paste0("An unplanned error occured in the excess of significance bias test for factor ", paste(unique(x$factor), collapse = ","), ". Please contact us to obtain more information."))
    esb = list(
      p.value = NA,
      method.esb = "Test for excess significance bias not conducted."
    )
  }
  class(esb) = "htest"
  return(esb)
}

