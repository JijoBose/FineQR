require "gtk3"
require 'rqrcode'
require 'launchy'


class RubyApp < Gtk::Window

    def initialize
        super

        init_ui
    end

    def init_ui

        set_title "FineQR - Create QR Code"
        signal_connect "destroy" do
            Gtk.main_quit
        end

        set_default_size 500, 400
        set_window_position :center


        grid = Gtk::Grid.new
        add(grid)

        my_entry = Gtk::Entry.new
        grid.attach(my_entry, 0, 0, 1, 1)

        # generates qr code depending on the my_entry
        button = Gtk::Button.new(:label => "Generate QRCode")
        button.signal_connect "clicked" do
          tempurl = my_entry.text
          qrcode = RQRCode::QRCode.new(tempurl)
          qimage = qrcode.as_png
          File.open("tmp/qr.png", "w") do |f|
           f.write(qimage)
          end
          #Launchy.open("Temp/qr.png")
          on_clicked
        end
        grid.attach(button, 1, 0, 1, 1)

        # save image
        button = Gtk::Button.new(:label => "Save QR Image")
        button.signal_connect "clicked" do
          tempurl = my_entry.text
          qrcode = RQRCode::QRCode.new(tempurl)
          qimage = qrcode.as_png
          File.open("Temp/qr.png", "w") do |f|
            f.write(qimage)
          end
          Launchy.open("Temp/qr.png")
        end
        grid.attach(button, 1, 2, 1, 2)

        #label = Gtk::Label.new "Previous code"
        #grid.attach(label, 1, 2, 1, 2)

        image = Gtk::Image.new :file => 'Temp/qr.png'
        grid.attach(image, 1, 1, 1, 1)



        show_all
    end

    def on_clicked
        about = Gtk::AboutDialog.new
        about.set_program_name "Scan Code"
        about.set_comments "Battery is a simple tool for battery checking"
        about.set_logo GdkPixbuf::Pixbuf.new(:file => "tmp/qr.png")
        about.run
        about.destroy
    end


end

window = RubyApp.new
Gtk.main
