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
      puts "-" * @title.length
      puts @title
      puts "-" * @title.length
      @items.each_with_index do |item, position|
        puts "#{position + 1}) #{item.details}"
      end
    end
    def print
      table = Terminal::Table.new :title => "UdaciList: #{@title}", :headings=> ["Description", "Due Date"]
      @items.each {|item| table.add_row([item.description, item.due])}
      puts table
    end
  end
end
