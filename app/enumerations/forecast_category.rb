class ForecastCategory < Enumerations::Base
  value :pipeline, name: 'Pipeline'
  value :best_case, name: 'Best Case'
  value :commit, name: 'Commit'
  value :closed, name: 'Closed'
end
