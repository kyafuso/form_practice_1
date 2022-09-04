class Form::ProductCollection < Form::Base
  FORM_COUNT = 5
  attr_accessor :products

  def initialize(attributes = {})
    super attributes
    self.products = FORM_COUNT.times.map { Product.new() } unless self.products.present?
  end

  def products_attributes=(attributes)
    self.products = attributes.map { |_, v| Product.new(v) }
  end

  def valid?
    super
    target_products = products.select{|product| product.availability == true}
    unless target_products.map(&:valid?).all?
      target_products.flat_map { |p| p.errors.full_messages }.uniq.each do |message|
        errors.add(:base, message)
      end
    end
    errors.blank?
  end

  def save
    return false unless valid?
    Product.transaction do
      self.products.map do |product|
        if product.availability
          product.save
        end
      end
    end
    true
  end
end