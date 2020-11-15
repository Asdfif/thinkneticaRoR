# frozen_string_literal: true

module CompanyName
  def set_company
    puts 'Введите название компании'
    @company = gets.chomp
  end

  protected

  attr_accessor :company
end
