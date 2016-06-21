class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      @items.push TodoItem.new(description, options)
    elsif type == "event"
      @items.push EventItem.new(description, options)
    elsif type == "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "Sorry, '#{type}' is not a valid item type."
    end
  end

  def delete(index)
    index <= (@items.count) ? @items.delete_at(index - 1) : (raise UdaciListErrors::IndexExceedsListSize, "Invalid item number, try again.")
  end

  def create_table(title_as_string)
    Terminal::Table.new :title => title_as_string.light_magenta, :headings=> ["#".light_magenta, "Title".light_magenta, "Type".light_magenta, "Details".light_magenta]
  end

  def fill_table(target_table, array_of_items)
    array_of_items.each_with_index do |item, index|
      if item.priority == "high"
        target_table.add_row ["#{index + 1}".red, item.format_description(item.description).red, item.format_class.red, item.details.red]
      elsif item.priority == "medium"
        target_table.add_row ["#{index + 1}".yellow, item.format_description(item.description).yellow, item.format_class.yellow, item.details.yellow]
      elsif item.priority == "low"
        target_table.add_row ["#{index + 1}".green, item.format_description(item.description).green, item.format_class.green, item.details.green]
      else
        target_table.add_row ["#{index + 1}", item.format_description(item.description), item.format_class, item.details]
      end
    end
  end

  def all
    table = create_table("Udacitask: #{@title}")
    fill_table(table, @items)
    puts table
  end

  def high(index)
    @items[index - 1].priority = "high"
    all
  end

  def medium(index)
    @items[index - 1].priority = "medium"
    all
  end

  def low(index)
    @items[index - 1].priority = "low"
    all
  end

  def filter(type)
    if (type.downcase == "task" || type.downcase == "event" || type.downcase == "url")
      filtered_items = []
      @items.each {|item| item.format_class.downcase == type ? filtered_items << item : nil}
      results = create_table("Filtered: #{type.capitalize}s Only")
      fill_table(results, filtered_items)
      puts results
    else
      puts "That's not a valid Type. Try 'Task', 'Event', or 'URL' instead."
    end
  end
end
