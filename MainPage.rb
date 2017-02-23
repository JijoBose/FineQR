require "gtk3"
require 'rqrcode'

app = Gtk::Application.new("org.gtk.example", :flags_none)

app.signal_connect "activate" do |application|
  # create a new window, and set its title
  window = Gtk::ApplicationWindow.new(application)
  window.set_title("QR Generator")
  window.set_border_width(10)

  # Here we construct the container that is going pack our buttons
  grid = Gtk::Grid.new

  # Pack the container in the window
  window.add(grid)

  entry = Gtk::Entry.new
  grid.attach(entry, 0, 0, 1, 1)

  qrcode = RQRCode::QRCode.new("http://apple.com/")
  qimage = qrcode.as_png
  File.open("qr.png", "w") do |f|
    f.write(qimage)
  end
  image = Gtk::Image.new :file => 'qr.png'
  grid.attach(image, 1 , 1, 1 , 1)


  button = Gtk::Button.new(:label => "Generate QRCode")
  button.signal_connect("clicked") { puts "Hello" }
  # Place the first button in the grid cell (0, 0), and make it fill
  # just 1 cell horizontally and vertically (ie no spanning)
  grid.attach(button, 1, 0, 1, 1)

=begin
  button = Gtk::Button.new(:label => "Button 2")
  button.signal_connect("clicked") { puts "Hello World" }
  # Place the second button in the grid cell (1, 0), and make it fill
  # just 1 cell horizontally and vertically (ie no spanning)
  grid.attach(button, 1, 0, 1, 1)


  button = Gtk::Button.new(:label => "Quit")
  button.signal_connect("clicked") { window.destroy }
  # Place the Quit button in the grid cell (0, 1), and make it
  # span 2 columns.
  grid.attach(button, 0, 1, 2, 1)
=end
  # Now that we are done packing our widgets, we show them all
  # in one go, by calling Gtk::Widget#show_all on the window.
  # This call recursively calls Gtk::Widget#show on all widgets
  # that are contained in the window, directly or indirectly
  window.show_all
end

# Gtk::Application#run need C style argv ([prog, arg1, arg2, ...,argn]).
# The ARGV ruby variable only contains the arguments ([arg1, arg2, ...,argb])
# and not the program name. We have to add it explicitly.

status = app.run([$0] + ARGV)

puts status
