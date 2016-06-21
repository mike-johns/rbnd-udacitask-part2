class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :priority

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    @priority = options[:priority]
  end

  def format_date
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
  end

  def details
    "Event Dates: #{format_date} #{format_priority(:priority => @priority)}"
  end
end
