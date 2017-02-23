require "gtk3"
require 'rqrcode'

app = Gtk::Application.new("org.gtk.example", :flags_none)

app.signal_connect "activate" do |application|
  # create a new window, and set its title
  window = Gtk::ApplicationWindow.new(application)
  window.set_title("QR Generator")
  window.set_border_width(100)

  # Here we construct the container that is going pack our buttons
  grid = Gtk::Grid.new

  # Pack the container in the window
  window.add(grid)

  my_entry = Gtk::Entry.new
  grid.attach(my_entry, 0, 0, 1, 1)

  # button that does nothing
  button = Gtk::Button.new(:label => "Generate QRCode")
  button.signal_connect("clicked") do
    tempurl = my_entry.text
    qrcode = RQRCode::QRCode.new(tempurl)
    qimage = qrcode.as_png
    File.open("Temp/qr.png", "w") do |f|
     f.write(qimage)
    end
  end

  image = Gtk::Image.new :file => 'Temp/qr.png'
  grid.attach(image, 1 , 1, 1 , 1)

  grid.attach(button, 1, 0, 1, 1)
  window.show_all
end
# Gtk::Application#run need C style argv ([prog, arg1, arg2, ...,argn]).
# The ARGV ruby variable only contains the arguments ([arg1, arg2, ...,argb])
# and not the program name. We have to add it explicitly.

status = app.run([$0] + ARGV)

puts status
