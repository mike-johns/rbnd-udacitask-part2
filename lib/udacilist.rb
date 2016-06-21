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
    def delete(index)
      @items.delete_at(index - 1)
    end
    def all
      table = Terminal::Table.new :title => "UdaciList: #{@title}".light_magenta, :headings=> ["#".light_magenta, "Title".light_magenta, "Type".light_magenta, "Details".light_magenta]
      @items.each_with_index do |item, index|
        if item.priority == "high"
          table.add_row ["#{index + 1}".red, item.format_description(item.description).red, item.format_class.red, item.details.red]
        elsif item.priority == "medium"
          table.add_row ["#{index + 1}".yellow, item.format_description(item.description).yellow, item.format_class.yellow, item.details.yellow]
        elsif item.priority == "low"
          table.add_row ["#{index + 1}".green, item.format_description(item.description).green, item.format_class.green, item.details.green]
        else
          table.add_row ["#{index + 1}", item.format_description(item.description), item.format_class, item.details]
        end
      end
      puts table
    end
  end
end
