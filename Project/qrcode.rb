require 'gtk3'
require 'libglade2'

class Editor &lt; Gtk::Window

  def initialize

    super

    # Create the window from the Glade file
    @glade = GladeXML.new('Builder.glade') do |handler|
      self.method(handler)
    end

    # Grab a reference to the Window, handle detroy, and queue to show
    @window = @glade['window']
    @window.show_all

    # Start GTK processing
    Gtk.main()

  end
end
