# frozen_string_literal: true

module CompanyName
  def set_company
    @company = gets.chomp
  end

  protected

  attr_accessor :company
end
