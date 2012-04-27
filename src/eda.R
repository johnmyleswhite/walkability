library('ProjectTemplate')
load.project()

ggplot(scores, aes(x = Population, y = WalkScore)) +
  geom_point()
ggsave(file.path('graphs', 'walk-score_vs_population.png'))

ggplot(scores, aes(x = Population, y = WalkScore)) +
  geom_point() +
  scale_x_log10()
ggsave(file.path('graphs', 'walk-score_vs_log-population.png'))

ggplot(scores, aes(x = WalkScore)) +
  geom_density()
ggsave(file.path('graphs', 'walk-score_pdf.png'))

summary(lm(WalkScore ~ log(Population), data = scores))

with(scores, cor.test(WalkScore, log(Population)))

summary(lm(WalkScore ~ log(Population) + State, data = scores))
summary(lm(WalkScore ~ log(Population) + State - 1, data = scores))

coefficients <- summary(lm(WalkScore ~ log(Population) + State - 1, data = scores))$coefficients
coefficients <- coefficients[2:nrow(coefficients), ]
coefficients.df <- as.data.frame(coefficients)
row.names(coefficients.df) <- NULL
coefficients.df <- transform(coefficients.df, State = as.character(row.names(coefficients)))
coefficients.df <- transform(coefficients.df, State = str_replace(State, 'State', ''))

ggplot(coefficients.df, aes(x = reorder(State, Estimate), y = Estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = Estimate - Std..Error, ymax = Estimate + Std..Error)) +
  coord_flip() +
  xlab('State') +
  ylab('Estimated Walkability') +
  opts(title = 'Walkability')
ggsave(file.path('graphs', 'state_coefficients.png'), height = 14, width = 7)

state.data <- merge(coefficients.df, votes2008, by = 'State')
ggplot(state.data, aes(x = ObamaPercentage, y = Estimate)) +
  geom_point()
ggsave(file.path('graphs', 'state_coefficients_by_voting.png'), height = 14, width = 7)
