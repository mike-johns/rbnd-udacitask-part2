module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_priority(options = {})
    priority = options[:priority]
    value = " ⇧".red if priority == "high"
    value = " ⇨".yellow if priority == "medium"
    value = " ⇩".green if priority == "low"
    value = "" if !priority
    return value
  end

  def format_class
    type = self.class.to_s
    result = "Task" if type == "TodoItem"
    result = "Event" if type == "EventItem"
    result = "URL" if type == "LinkItem"
    return result
  end

  def high
    self.priority = "high"
  end

  def medium
    self.priority = "medium"
  end

  def low
    self.priority = "low"
  end
end
