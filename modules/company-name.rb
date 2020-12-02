# frozen_string_literal: true

module CompanyName
  attr_accessor :company

  COMPANY_PATTERN = /^[A-Z]{1}+[a-z]{1,}$/.freeze

  def set_company
    @company = gets.chomp
  end
end
