# encoding : utf-8
module Wechat
  class Router

    # Wechat::Router.new(:type=>"text")
    # Wechat::Router.new(:type=>"text", :content=>"Hello2BusUser")
    # Wechat::Router.new(:type=>"text", :content=>/^@/)
    # Wechat::Router.new {|xml| xml[:MsgType] == 'image'}
    # Wechat::Router.new(:type=>"text") {|xml| xml[:Content].starts_with? "@"}
    def initialize(options, &block)
      @type = options[:type] if options[:type]
      @content = options[:content] if options[:content]
      @constraint = block if block_given?
    end

    def matches?(request)
      xml = request.params[:xml]
      result = true
      result = result && (xml[:MsgType] == @type) if @type
      result = result && (xml[:Content] =~ @content) if @content.is_a? Regexp
      result = result && (xml[:Content] == @content) if @content.is_a? String
      result = result && @constraint.call(xml) if @constraint

      return result
    end
  end

  # module ActionController
  #   # 辅助方法，用于简化操作，weixin_xml.content 比用hash舒服多了，对不？
  #   def weixin_xml
  #     @weixin_xml ||= WeixinXml.new(params[:xml])
  #     return @weixin_xml
  #   end

  #   class WechatXml
  #     attr_accessor :content, :type, :from_user, :to_user, :pic_url
  #     def initialize(hash)
  #       @content = hash[:Content]
  #       @type = hash[:MsgType]
  #       @from_user = hash[:FromUserName]
  #       @to_user = hash[:ToUserName]
  #       @pic_url = hash[:PicUrl]
  #     end
  #   end
  # end
end

# ActionController::Base.class_eval do
#   include ::Weixin::ActionController
# end
# ActionView::Base.class_eval do
#   include ::Weixin::ActionController
# end