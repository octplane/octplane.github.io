# Title: Image tag with caption for Jekyll
# Description: Easily output images with captions

module Jekyll

  class CaptionImageTag < Liquid::Tag
    @img = nil
    @title = nil
    @class = ''
    @width = ''
    @height = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(\S.*\s+)?(https?:\/\/|\/)(\S+) (https?:\/\/|\/)(\S+)(\s+\d+\s+\d+)?(\s+.+)?/i
        @class = $1 || ''
        @img = $2 + $3
        @link = $4 + $5
        if $7
          @title = $7.strip
        end
        if $6 =~ /\s*(\d+)\s+(\d+)/
          @width = $1
          @height = $2
        end
      end
      super
    end

    def render(context)
      output = super
      if @img
        "<div style='text-align:center;'><span class='#{('caption-wrapper ' + @class).rstrip}'>" +
          "<img class='caption' src='#{@img}' width='#{@width}' height='#{@height}' title='#{@title}'>" +
          "<span class='caption-text'><a href='#{@link}''>#{@title}</a></span>" +
        "</span></div>"
      else
        "Error processing input, expected syntax: {% img [class name(s)] /url/to/image link [width height] [title text] %}"
      end
    end
  end
end

Liquid::Template.register_tag('imgcap', Jekyll::CaptionImageTag)
