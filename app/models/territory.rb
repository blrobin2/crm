class Territory < ApplicationRecord
  has_closure_tree
  has_paper_trail

  belongs_to :advisor, optional: true, class_name: 'User'
  belongs_to :sales, optional: true, class_name: 'User'

  validates :name, presence: true
  validate :advisor_must_be_advisor
  validate :sales_must_be_sales

  alias_attribute :sales_person, :sales
  delegate :name, to: :advisor, prefix: true, allow_nil: true
  delegate :name, to: :sales_person, prefix: true, allow_nil: true

  private

  def advisor_must_be_advisor
    return unless advisor.present? && !advisor.advisor?

    errors.add(:advisor, 'must be an advisor')
  end

  def sales_must_be_sales
    return unless sales.present? && !sales.sales?

    errors.add(:sales, 'must be a sales person')
  end
end
