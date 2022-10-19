class UserRole < Enumerations::Base
  value :admin, name: 'Application Administrator'
  value :sales, name: 'Sales Team Member'
  value :advisor, name: 'Content Curration Advisor'
end
