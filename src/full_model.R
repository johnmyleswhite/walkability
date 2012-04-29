library('ProjectTemplate')
load.project()

summary(lm(WalkScore ~ log(Population) + ObamaPercentage + Admission,
		   data = merged.scores))
summary(lm(WalkScore ~ log(Population) + State - 1,
	   data = merged.scores))
