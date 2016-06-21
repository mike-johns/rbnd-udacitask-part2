class LinkItem
  include Listable
  attr_reader :description, :site_name
  attr_accessor :priority

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
    @priority = options[:priority]
  end

  def format_name
    @site_name ? @site_name : ""
  end

  def details
    "Site Name: #{format_name} #{format_priority(:priority => @priority)}"
  end
end
