# frozen_string_literal: true

# Helpers for navbar partial
module NavigationHelper
  def current_child_of(item)
    child_of(item, @item)
  end

  def child_of(parent, child)
    children_of(parent).include?(child)
  end

  # Returns every navigable item
  # A navigable item contains the :navigable attribute
  # Optionally contains an order attribute, determining the order in the navbar
  def navigables
    items.select { |i| i[:navigable] }.sort_by { |x| x[:order] || 10_000 }
  end
end