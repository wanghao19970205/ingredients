% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/partial_dependence.R
\name{partial_dependence}
\alias{partial_dependence}
\alias{partial_dependence.explainer}
\alias{partial_dependence.default}
\alias{partial_dependence.ceteris_paribus_explainer}
\alias{partial_dependency}
\title{Partial Dependence Profiles}
\usage{
partial_dependence(x, ...)

\method{partial_dependence}{explainer}(
  x,
  variables = NULL,
  N = 500,
  variable_splits = NULL,
  grid_points = 101,
  ...,
  variable_type = "numerical"
)

\method{partial_dependence}{default}(
  x,
  data,
  predict_function = predict,
  label = class(x)[1],
  variables = NULL,
  grid_points = 101,
  variable_splits = NULL,
  N = 500,
  ...,
  variable_type = "numerical"
)

\method{partial_dependence}{ceteris_paribus_explainer}(x, ..., variables = NULL)

partial_dependency(x, ...)
}
\arguments{
\item{x}{an explainer created with function \code{DALEX::explain()}, an object of the class \code{ceteris_paribus_explainer} or
or a model to be explained.}

\item{...}{other parameters}

\item{variables}{names of variables for which profiles shall be calculated.
Will be passed to \code{\link{calculate_variable_split}}.
If \code{NULL} then all variables from the validation data will be used.}

\item{N}{number of observations used for calculation of partial dependence profiles. By default \code{500}.}

\item{variable_splits}{named list of splits for variables, in most cases created with \code{\link{calculate_variable_split}}.
If \code{NULL} then it will be calculated based on validation data avaliable in the \code{explainer}.}

\item{grid_points}{number of points for profile. Will be passed to \code{\link{calculate_variable_split}}.}

\item{variable_type}{a character. If \code{"numerical"} then only numerical variables will be calculated.
If \code{"categorical"} then only categorical variables will be calculated.}

\item{data}{validation dataset, will be extracted from \code{x} if it's an explainer
NOTE: It is best when target variable is not present in the \code{data}}

\item{predict_function}{predict function, will be extracted from \code{x} if it's an explainer}

\item{label}{name of the model. By default it's extracted from the \code{class} attribute of the model}
}
\value{
an object of the class \code{aggregated_profiles_explainer}
}
\description{
Partial Dependence Profiles are averages from Ceteris Paribus Profiles.
Function \code{partial_dependence} calls \code{ceteris_paribus} and then \code{aggregate_profiles}.
}
\details{
Find more detailes in the \href{https://pbiecek.github.io/ema/partialDependenceProfiles.html}{Partial Dependence Profiles Chapter}.
}
\examples{
library("DALEX")

model_titanic_glm <- glm(survived ~ gender + age + fare,
                         data = titanic_imputed, family = "binomial")

explain_titanic_glm <- explain(model_titanic_glm,
                               data = titanic_imputed[,-8],
                               y = titanic_imputed[,8],
                               verbose = FALSE)

pdp_glm <- partial_dependence(explain_titanic_glm,
                              N = 25, variables = c("age", "fare"))
head(pdp_glm)
plot(pdp_glm)

\donttest{
library("ranger")

model_titanic_rf <- ranger(survived ~., data = titanic_imputed, probability = TRUE)

explain_titanic_rf <- explain(model_titanic_rf,
                              data = titanic_imputed[,-8],
                              y = titanic_imputed[,8],
                              label = "ranger forest",
                              verbose = FALSE)

pdp_rf <- partial_dependence(explain_titanic_rf, variable_type = "numerical")
plot(pdp_rf)

pdp_rf <- partial_dependence(explain_titanic_rf, variable_type = "categorical")
plotD3(pdp_rf, label_margin = 80, scale_plot = TRUE)
}

}
\references{
Explanatory Model Analysis. Explore, Explain, and Examine Predictive Models. \url{https://pbiecek.github.io/ema/}
}
