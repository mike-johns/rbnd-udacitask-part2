class TodoItem
  include Listable
  attr_reader :description, :due
  attr_accessor :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = check_priority_value(options[:priority])
  end

  def format_date
    @due ? @due.strftime("%D") : "No due date"
  end

  def details
    "Due: #{format_date} #{format_priority(:priority => @priority)}"
  end
end
