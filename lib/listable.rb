module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date
  end

  def format_priority(options = {})
    priority = options[:priority]
    value = " ⇧".red if priority == "high"
    value = " ⇨".yellow if priority == "medium"
    value = " ⇩".green if priority == "low"
    value = "" if !priority
    return value
  end
end
