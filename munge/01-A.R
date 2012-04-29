coefficients <- summary(lm(WalkScore ~ log(Population) + State - 1, data = scores))$coefficients
coefficients <- coefficients[2:nrow(coefficients), ]
coefficients.df <- as.data.frame(coefficients)
row.names(coefficients.df) <- NULL
coefficients.df <- transform(coefficients.df, State = as.character(row.names(coefficients)))
coefficients.df <- transform(coefficients.df, State = str_replace(State, 'State', ''))

state.data <- merge(coefficients.df, votes2008, by = 'State')

state.data <- transform(state.data, Democrat = factor(ifelse(ObamaPercentage > 50, 1, 0)))

merged.scores <- merge(scores, votes2008, by = 'State')

statehood <- transform(statehood, Admission = mdy(Admission))
statehood <- transform(statehood, State = state_to_abbreviation(State))

merged.scores <- merge(merged.scores, statehood, by = 'State')

# Why does this crash when analogue above works?
#income <- transform(income, StateAbb = state_to_abbreviation(State))
#merged.scores <- merge(merged.scores, income, by = 'State')
