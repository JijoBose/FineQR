require "gtk3"
require 'rqrcode'
require 'launchy'


class RubyApp < Gtk::Window

    def initialize
        super

        init_ui
    end

    def init_ui
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
          File.open("Temp/qr.png", "w") do |f|
           f.write(qimage)
          end
          Launchy.open("Temp/qr.png")
        end
        grid.attach(button, 1, 0, 1, 1)
        image = Gtk::Image.new :file => 'Temp/qr.png'
        grid.attach(image, 1, 1, 1, 1)


=begin
        image = Gtk::Image.new :file => 'Temp/qr.png'
        grid.attach(image, 1, 1, 1, 1)

        table = Gtk::Table.new 1, 2, true

        info = Gtk::Button.new :label => "Information"
        warn = Gtk::Button.new :label => "Warning"
        ques = Gtk::Button.new :label => "Question"
        erro = Gtk::Button.new :label => "Error"

        info.signal_connect "clicked" do
            on_info
        end

=end
        set_title "Messages"
        signal_connect "destroy" do
            Gtk.main_quit
        end

        set_default_size 300, 100
        set_window_position :center

        show_all

    end


    def on_erro

        md = Gtk::MessageDialog.new :parent => self,
            :flags => :modal, :type => :error,
            :buttons_type => :close, :message => "Error loading file"
        begin
            logo = Gdk::Pixbuf.new :file => "Temp/qr.png"
        rescue IOError => e
            puts e
            puts "cannot load image"
            exit
        end
        md.run
        md.destroy
    end

end

window = RubyApp.new
Gtk.main
