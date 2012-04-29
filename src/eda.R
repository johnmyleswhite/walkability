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

ggplot(coefficients.df, aes(x = reorder(State, Estimate), y = Estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = Estimate - Std..Error, ymax = Estimate + Std..Error)) +
  coord_flip() +
  xlab('State') +
  ylab('Estimated Walkability') +
  opts(title = 'Walkability')
ggsave(file.path('graphs', 'state_coefficients.png'), height = 14, width = 7)

ggplot(state.data, aes(x = ObamaPercentage, y = Estimate)) +
  geom_text(aes(label = State))
ggsave(file.path('graphs', 'state_coefficients_by_voting.png'), height = 14, width = 7)

# Color by winning candidate.
ggplot(state.data, aes(x = reorder(State, Estimate), y = Estimate, color = Democrat)) +
  geom_point() +
  geom_errorbar(aes(ymin = Estimate - Std..Error, ymax = Estimate + Std..Error)) +
  coord_flip() +
  xlab('State') +
  ylab('Estimated Walkability') +
  opts(title = 'Walkability')
ggsave(file.path('graphs', 'colored_state_coefficients.png'), height = 14, width = 7)

summary(lm(WalkScore ~ log(Population) + ObamaPercentage, data = merged.scores))

ggplot(merged.scores, aes(x = Admission, y = WalkScore)) +
  geom_point() +
  geom_smooth(method = 'lm')
ggsave(file.path('graphs', 'walk-score_vs_admission.png'), height = 14, width = 7)

summary(lm(WalkScore ~ Admission, data = merged.scores))

ggplot(merged.scores, aes(x = Admission, y = ObamaPercentage)) +
  geom_point() +
  geom_smooth(method = 'lm')
ggsave(file.path('graphs', 'democrat_vs_admission.png'), height = 14, width = 7)

summary(lm(ObamaPercentage ~ Admission, data = merged.scores))

#ggplot(merged.scores, aes(x = Income, y = ObamaPercentage)) +
#  geom_point() +
#  geom_smooth(method = 'lm')
#ggsave(file.path('graphs', 'democrat_vs_income.png'), height = 14, width = 7)
