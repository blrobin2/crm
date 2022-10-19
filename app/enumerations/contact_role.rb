class ContactRole < Enumerations::Base
  value :owner, name: 'Account Owner (Sales Contact)'
  value :student, name: 'Student'
  value :customer_admin, name: 'Account Admin (Advisor Contact)'
  value :contact, name: 'Account Contact'
end
